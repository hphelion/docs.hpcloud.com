require 'open3'

module Jekyll
  module Converters
    class Markdown < Converter
      safe true

      pygments_prefix "\n"
      pygments_suffix "\n"

      def setup
        return if @setup
        @parser = case @config['markdown']
          when 'redcarpet'
            RedcarpetParser.new @config
          when 'kramdown'
            KramdownParser.new @config
          when 'rdiscount'
            RDiscountParser.new @config
          when 'maruku'
            MarukuParser.new @config
          when 'md2html'
            Md2htmlParser.new @config
          else
            STDERR.puts "Invalid Markdown processor: #{@config['markdown']}"
            STDERR.puts " Valid options are [ maruku | rdiscount | kramdown ]"
            raise FatalException.new("Invalid Markdown process: #{@config['markdown']}")
        end
        @setup = true
      end

      def matches(ext)
        rgx = '(' + @config['markdown_ext'].gsub(',','|') +')'
        ext =~ Regexp.new(rgx, Regexp::IGNORECASE)
      end

      def output_ext(ext)
        ".html"
      end

      def convert(content)
        setup
        @parser.convert(content)
      end
    end
  end
end

module Jekyll
  module Converters
    class Markdown
      class Md2htmlParser
        def initialize(config)
          @config = config
        end

        def convert(content)
          output = ''
          Open3.popen3("#{File.expand_path(File.dirname(__FILE__))}/markdown-extra convert --toc") do |stdin, stdout, stderr, wait_thr|
            stdin.puts content
            stdin.close
            output = stdout.read.strip
          end
          output
        end
      end
    end
  end
end
