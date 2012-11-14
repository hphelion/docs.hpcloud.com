require 'open3'

class Jekyll::MarkdownConverter

  def convert(content)
    output = ''
    Open3.popen3("#{File.expand_path(File.dirname(__FILE__))}/md2html convert") do |stdin, stdout, stderr, wait_thr|
      stdin.puts content
      stdin.close
      output = stdout.read.strip 
    end
    output
  end
end