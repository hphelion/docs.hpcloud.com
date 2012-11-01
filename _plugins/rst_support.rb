# This plugin adds restructured text support to Jekyll via Docutils.
# Note, we are using docutils because the version of pandoc in the ubuntu repos
# is missing features we use. The version mismatches makes using docutils better
# than pandoc in this place and will reduce the possible errors.

require 'rbst'

module Jekyll
  class ReSTConverter < Converter
    safe true

    priority :low

    def matches(ext)
      ext =~ /rst/i
    end 

    def output_ext(ext)
      ".html"
    end

    def convert(content)
    	RbST.new(content).to_html
    end
  end
end  