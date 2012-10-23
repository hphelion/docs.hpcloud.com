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
DEFAULT_CS_API_MD = 'cs-api.md'
DEFAULT_CS_API_INTERNAL_MD = 'cs-api-private.md'


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


def grep_all_mds(dirname=None):
    content = ''
    try:
        dlist = os.listdir(dirname)
        for fname in sorted(dlist):
            if fname.endswith('.md'):
                verbose('reading %s' % (fname))
                content = content + read_file(os.path.join(dirname, fname))
        return content
    except:
        bail("Error: unable to read %s" % (dirname))


def get_api_index_table(api_table):
    table = ['| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |']
    table.append('| :------- | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: |')
    for (group, operation, verb, path, jx, priv) in api_table:
        table.append('| %s | %s | %s | %s | %s | %s |' % (
            group, operation, verb, path, jx, priv))
    return string.join(table, '\n')


def create_cs_api_md(opt, outfile, dirname, chapter='4.4'):
    if opt.outfile:
        outfile = opt.outfile
    intro_md = read_file('cs-api-intro.md')
    end_md = read_file('cs-api-end.md')
    contents = grep_all_mds(dirname)
    group_count = 0
    action_count = 0
    api_table = []
    group_name = None
    action_name = None
    verb = None
    path = None
    pattern = '^####\s+(?P<verb>[GPD][A-Z]+)\s+(?P<path>/.+)'
    re_http = re.compile(pattern)
    priv_pattern = '^\*Privilege Level:\s*(?P<privilege>[^\*]+)\*$'
    re_priv = re.compile(priv_pattern)
    api_content = []
    for line in contents.split('\n'):
        if line.startswith('# '):
            group_count = group_count + 1
            action_count = 0
            group_name = line[2:]
            api_content.append("### %s.%s %s" % (chapter,
                group_count, line[2:]))
        elif line.startswith('## '):
            action_count = action_count + 1
            action_name = line[3:]
            api_content.append("#### %s.%s.%s %s" % (
                chapter, group_count, action_count, line[3:]))
        else:
            m = re_http.match(line)
            if m:
                verb = m.group('verb')
                path = m.group('path')
            pm = re_priv.match(line)
            if pm:
                api_table.append((group_name, action_name, verb, path, 'Y/Y',
                    pm.group('privilege')))
            api_content.append("%s" % (line))
    intro_md = intro_md.replace('{API_INDEX_TABLE_PLACE_HOLDER}', get_api_index_table(api_table))
    output = open(outfile, 'w')
    output.write(intro_md)
    output.write(string.join(api_content, '\n'))
    output.write(end_md)
    output.close()


def create_cs_api_public_md(opt):
    create_cs_api_md(opt, DEFAULT_CS_API_MD, 'public')


def create_cs_api_private_md(opt):
    create_cs_api_md(opt, DEFAULT_CS_API_INTERNAL_MD, 'private')


def convert_api_to_wiki_content(opt):
    filename = 'cs-api.md'
    if opt.wiki_file:
        filename = opt.wiki_file
    return subprocess.check_output(['markdown2confluence', filename]) 


def public_to_wiki(opt):
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
        public_to_wiki(opt)


if __name__ == "__main__":
	sys.exit(main())

