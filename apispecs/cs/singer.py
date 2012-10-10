import logging
import optparse
import os
import signal
import socket
import sys


PROGRAM_NAME = 'singer'
__version__ = '1.0'
VERBOSE = False


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
    p.set_defaults(outfile='cs-api.md')
    
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
    p.add_option("-i", "--internal", dest="internal", action="store_true",
                 help="generate internal API markdown")
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


def create_cs_api_md(opt, chapter='4.4'):
    outfile = 'cs-api.md'
    if opt.outfile:
        outfile = opt.outfile
    intro_md = read_file('cs-api-intro.md')
    end_md = read_file('cs-api-end.md')
    contents = grep_all_mds('public')
    output = open(outfile, 'w')
    output.write(intro_md)
    group_count = 0
    action_count = 0
    for line in contents.split('\n'):
        if line.startswith('# '):
            group_count = group_count + 1
            action_count = 0
            output.write("### %s.%s %s\n" % (chapter, group_count, line[2:]))
        elif line.startswith('## '):
            action_count = action_count + 1
            output.write("#### %s.%s.%s %s\n" % (
                chapter, group_count, action_count, line[3:]))
        else:
            output.write("%s\n" % (line))
    output.write(end_md)
    output.close()


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
    if opt.public and opt.internal:
        bail("Error: -p and -i are mutually exclusive")

    if not opt.public and not opt.internal:
        bail("Error: -p or -i must be specified")

    VERBOSE = opt.verbose

    if opt.public:
        create_cs_api_md(opt)


if __name__ == "__main__":
	sys.exit(main())

