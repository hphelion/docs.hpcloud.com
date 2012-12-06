import logging
import optparse
import os
import re
import signal
import socket
import string
import subprocess
import sys
import xmlrpclib


PROGRAM_NAME = 'singer'
__version__ = '1.0'
VERBOSE = False
DEFAULT_CS_API_MD = '../cs-api.md'
DEFAULT_CS_API_INTERNAL_MD = '../private/cs-admin-api.md'


class OptionParser(optparse.OptionParser):
    def error(self, msg):
        # clue in --help option
        n = self.get_prog_name()
        msg = msg + "\n%s: try `%s --help' for more information" % (n, n)
        optparse.OptionParser.error(self, msg)


class HelpFormatter(optparse.IndentedHelpFormatter):
    def format_description(self, description):
        # don't wrap __doc__
        return description

    def format_usage (self, usage):
        # prefer title case
        return "Usage: %s\n" % usage

    def format_heading (self, heading):
        # prefer title case
        return "%*s%s:\n" % (self.current_indent, "", heading.title())


def parse_args(args):
    # setup and return parsed arguments
    p = OptionParser(
            prog=PROGRAM_NAME,
            description=__doc__,
            version=__version__,
            formatter=HelpFormatter(),
            usage="%prog [options] [LABEL...]"
    )
    #p.set_defaults(outfile=DEFAULT_CS_API_MD)
    
    def enable_disable_cb(option, opt_str, value, parser, enabled):
        # callback for the enable/disable options to handle var args
        option_values = getattr(parser.values, option.dest)
        option_values.append((value, enabled))
        while parser.rargs and not parser.rargs[0].startswith("-"):
            option_values.append((parser.rargs.pop(0), enabled))
        setattr(parser.values, option.dest, option_values)
	
    def man_page_cb(option, opt_str, value, parser):
        __pychecker__ = "unusednames=option,opt_str,value"
        # callback to emit man page and exit
        print MAN_PAGE.replace(
            "@@@OPTION_HELP@@@",
            parser.format_option_help().replace("show this help", "show help")
        )
        sys.exit(2)
		
    p.add_option("-o", "--outfile", dest="outfile", metavar="FILE",
                 help="output file [default: %default]")
    p.add_option("-p", "--public", dest="public", action="store_true",
                 help="generate public API markdown")
    p.add_option("-r", "--private", dest="private", action="store_true",
                 help="generate private API markdown")
    p.add_option("-w", "--wiki", dest="wiki", action="store_true",
                 help="generate and publish CS APIs to wiki")
    p.add_option("-U", "--user", dest="wiki_user",
                 help="wiki user name. i.e. joe.doe@hp.com")
    p.add_option("-P", "--password", dest="wiki_password",
                 help="wiki user password")
    p.add_option("-m", "--mdfile", dest="wiki_file", metavar="FILE",
                 help="markdown file to be published to wiki [default: cs-api.md]")
    p.add_option("-v", "--verbose", dest="verbose", action="store_true",
                 help="display verbose output")
    return p.parse_args(args)


def bail(msg=None):
    if msg:
        print "%s. Bailing ..." % (msg)
    sys.exit(1)


def verbose(msg=None):
    if VERBOSE:
        print "%s\n" % (msg)


def read_file(filename=None):
    try:
        f = open(filename, 'r')
        content = f.read()
        f.close()
        return content
    except:
        bail("Error: unable to read %s" % (filename))


def grep_all_mds(rootdir, subdirs):
    content = {}
    try:
        for subdir in subdirs:
            dirname = os.path.join(rootdir, subdir)
            dlist = os.listdir(dirname)
            for fname in dlist:
                if fname.endswith('.md'):
                    verbose('reading %s' % (fname))
                    if fname in content:
                        content[fname] = content[fname] + read_file(os.path.join(dirname, fname))
                    else:
                        content[fname] = read_file(os.path.join(dirname, fname))
        md_content = []
        for fname in sorted(content.keys()):
            md_content.append(content[fname])
        return string.join(md_content, '\n')
    except:
        bail("Error: unable to read %s" % (dirname))


def get_api_index_table(api_table, private_api=None):
    if private_api:
        table = ['| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |']
        table.append('| :------- | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: |')
    else:
        # hide the privelege level column for public APIs
        table = ['| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? |']
        table.append('| :------- | :------------------- | :---------- | :--------------------- | :---------------- |')
    for (group, operation, operation_tag, verb, path, jx, priv) in api_table:
        if private_api:
            table.append('| %s | [%s](#%s) | %s | %s | %s | %s |' % (
                group, operation, operation_tag, verb, path, jx, priv))
        else:
            table.append('| %s | [%s](#%s) | %s | %s | %s |' % (
                group, operation, operation_tag, verb, path, jx))
    return string.join(table, '\n')


def create_actions_index(action_names):
    table = ['| Actions |']
    table.append('| :------ |')
    for (action_name, tag) in action_names:
        table.append('| [%s](#%s) |' % (action_name, tag))
    return string.join(table, '\n')


def first_letter_cap(s):
    word_list = s.split(' ')
    cap_word_list = []
    for word in word_list:
        if len(word) > 0:
            word = word[0].upper() + word[1:]
            cap_word_list.append(word)
    return string.join(cap_word_list, ' ')


def create_anchor_tag(s):
    word_list = s.split(' ')
    lower_word_list = []
    for word in word_list:
        if len(word) > 0:
            word = word.lower()
            word = word.replace("'", "")
            lower_word_list.append(word)
    return string.join(lower_word_list, '_')


def create_actions_appendix(rootdir, subdirs):
    contents = grep_all_mds(rootdir, subdirs)
    action_names = []
    api_content = []
    for line in contents.split('\n'):
        if line.startswith('# '):
            line = line.replace('#', '')
            action_name = line.strip()
            action_name_tag = create_anchor_tag(action_name)
            action_names.append((action_name, action_name_tag))
            line = '### %s {#%s}' % (action_name, action_name_tag)
        elif line.startswith('## '):
            line = line.replace('##', '####')
        api_content.append(line)
    return '%s\n\n%s\n' % (create_actions_index(action_names),
               string.join(api_content, '\n'))

            
def create_cs_api_md(opt, outfile, rootdir, subdirs, chapter='4.4', private_api=None):
    if opt.outfile:
        outfile = opt.outfile
    intro_md = read_file('cs-api-intro.md')
    end_md = read_file('cs-api-end.md')
    if private_api:
        intro_md = read_file('cs-private-api-intro.md')
        end_md = read_file('cs-private-api-end.md')
    contents = grep_all_mds(rootdir, subdirs)
    group_count = 0
    action_count = 0
    api_table = []
    group_name = None
    action_name = None
    action_name_tag = None
    verb = None
    path = None
    pattern = '^####\s+(?P<verb>[GPD][A-Z]+)\s+(?P<path>[\[/].+)'
    re_http = re.compile(pattern)
    priv_pattern = '^\**Privilege Level:\s*(?P<privilege>[^\*]+)\**$'
    re_priv = re.compile(priv_pattern)
    api_content = []
    inquote=False
    space_determined=False
    need_spaces = False
    for line in contents.split('\n'):
        if line.startswith('# '):
            group_count = group_count + 1
            action_count = 0
            group_name = first_letter_cap(line[2:])
            api_content.append("### %s.%s %s" % (chapter,
                group_count, group_name))
        elif line.startswith('## '):
            action_count = action_count + 1
            action_name = first_letter_cap(line[3:])
            action_name_tag = create_anchor_tag(action_name)
            api_content.append('#### %s.%s.%s %s#### {#%s}' % (
                chapter, group_count, action_count, action_name, action_name_tag))
        elif line.startswith('```') and line.rstrip() == '```':
            inquote = (not inquote)
            space_determined = False
            need_spaces = False
            api_content.append("%s" % (line))
        else:
            # remove private tag/content, depending on API type
            if line.startswith('{{PRIVATE}}'):
                if private_api:
                    # remove the tag
                    line = line[11:]
                    line = line.strip()
                else:
                    # public API, do not add private content
                    continue
            
            m = re_http.match(line)
            if m:
                verb = m.group('verb')
                path = m.group('path')
                # loose more junk
                path = path.replace('[HPKeystoneExtensionBaseURI]', '/HP-IDM/v1.0')
                path = path.replace('[csbu:HPKeystoneExtensionBaseURI]', '/HP-IDM/v1.0')
                line = line.replace('[HPKeystoneExtensionBaseURI]', '/HP-IDM/v1.0')
                line = line.replace('[csbu:HPKeystoneExtensionBaseURI]', '/HP-IDM/v1.0')
                line = line.replace('[KeystoneBaseURI]', '')
                #if path.startswith('[csbu:'):
                #    path = path[6:]
                # strip query string part since we are already describing
                # them in the URL section
                qs = path.find('?')
                if qs != -1:
                    path = path[:qs]
                #line = line.replace('{', '\<')
                #line = line.replace('}', '\>')
                line = line.replace('\<', '{')
                line = line.replace('\>', '}')
                # loose more junk
                line = line.replace('[csbu:', '')
                qs = line.find('?')
                if qs != -1:
                    line = line[:qs]
                path = path.replace('\<', '{')
                path = path.replace('\>', '}')
                print line
            pm = re_priv.match(line)
            if pm:
                priv_lev = pm.group('privilege')
                if priv_lev == '{Privilege Level}':
                    # SA?
                    priv_lev = 'SA'
                api_table.append((group_name, action_name, action_name_tag, verb, path, 'Y/Y',
                    priv_lev))
                if not private_api:
                    continue
            if inquote:
                if space_determined is False:
                    space_determined = True
                    if line[:1] != ' ':
                        need_spaces = True
                if need_spaces is True:
                    line = "    " + line
            api_content.append("%s" % (line))
    intro_md = intro_md.replace('{API_INDEX_TABLE_PLACE_HOLDER}', get_api_index_table(api_table, private_api))
    output = open(outfile, 'w')
    output.write(intro_md)
    output.write(string.join(api_content, '\n'))
    if private_api:
        action_appendix = create_actions_appendix(os.path.join(rootdir, 'private'), ['actions'])
        end_md = end_md.replace('{AVAILABLEACTIONS}', action_appendix)
    output.write(end_md)
    output.close()


def create_cs_api_public_md(opt):
    create_cs_api_md(opt, DEFAULT_CS_API_MD, os.path.dirname(os.path.abspath(__file__)), ['public'])


def create_cs_api_private_md(opt):
    create_cs_api_md(opt, DEFAULT_CS_API_INTERNAL_MD, os.path.dirname(os.path.abspath(__file__)), ['public', 'private'], private_api=True)


def convert_api_to_wiki_content(opt):
    filename = 'cs-api.md'
    if opt.wiki_file:
        filename = opt.wiki_file
    return subprocess.check_output(['markdown2confluence', filename]) 


def publish_to_wiki(opt):
    spacekey = "iaas"
    pagetitle = "CS APIs Markdown"

    server = xmlrpclib.ServerProxy('https://wiki.hpcloud.net/rpc/xmlrpc')
    token = server.confluence1.login(opt.wiki_user, opt.wiki_password)

    page = server.confluence1.getPage(token, spacekey, pagetitle)
    if page is None:
        bail("Error: unable to find %s/%s" % (space, pagetitle))
    
    content = convert_api_to_wiki_content(opt)
    content = '{note}\nDO NOT EDIT! This page is auto-generated.\n{note}\n\n' \
              + content
    page['content'] = content
    page = server.confluence1.storePage(token, page)
 

# ----------------------------------------------------------------------------
# Main

def main(argv=None):
    global VERBOSE

    if argv is None:
        argv = sys.argv
    
    # Prevent Broken pipe exception
    signal.signal(signal.SIGPIPE, signal.SIG_DFL)

    # parse CLI arguments, config and instantiate our helper classes
    opt, cli_labels = parse_args(argv[1:])

    if not opt.public and not opt.private and not opt.wiki:
        bail("Error: -p, -i, or -w must be specified")

    VERBOSE = opt.verbose

    if opt.public:
        create_cs_api_public_md(opt)
    elif opt.private:
        create_cs_api_private_md(opt)
    else:
        # make sure username and password are specified
        if not opt.wiki_user and not opt.wiki_password:
            bail("Error: wiki user name and password must be specified")
        publish_to_wiki(opt)


if __name__ == "__main__":
	sys.exit(main())

