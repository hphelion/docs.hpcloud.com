# This plugin makes sure when yaml front matter has either published: false (on pages)
# or private: true (on pages) that these are not published to the web.

module Jekyll
  AOP.around(Page, :write) do |page_instance, args, proceed, abort|
    if page_instance.data['private'] != true and page_instance.data['published'] != false
	    result = proceed.call
	    result
    end
  end
end
