# This plugin rewrites media paths to point to the proper locations. This is
# due to storing media in subtrees and when in use for a web server having it
# display in the proper locations.

module Jekyll
  AOP.around(Page, :to_liquid) do |page_instance, args, proceed, abort|
    result = proceed.call
    
    # Our media is stored in locations like /content/documentation/media/abc.png
    # with paths in the files like media/abc.png. The path in a website would be
    # /content/documentation/media/abc.png and the output needs to reference
    # the proper locations so they display.
    
    # Start with img tags
    # @todo Add tutorial images.
    page_instance.content = page_instance.content.gsub('<img src="media/', '<img src="/content/documentation/media/')
    result['content'] = result['content'].gsub('<img src="media/', '<img src="/content/documentation/media/')

    # Markdown tags
    # @todo Support tutorial images.
    page_instance.content = page_instance.content.sub!(/!(\[.*?\])\((.*?)\)/, '\1(/content/documentation/\2)' )
    result['content'] = result['content'].sub!(/!(\[.*?\])\((.*?)\)/, '\1(/content/documentation/\2)' )

    result
  end
end