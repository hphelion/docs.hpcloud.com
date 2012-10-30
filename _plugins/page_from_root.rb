# By default Jekyll pages are based out of the root of the directory they are in.
# Permalinks are based here rather than the root of the site like posts are.
# In addition pages end in pagename.html rather than pagename/index.html.
# This plugin modifies this behavior so page names and permalinks operate from
# the root of the site in a similar manner to posts.

module Jekyll
  AOP.around(Page, :destination) do |page_instance, args, proceed, abort|
    result = proceed.call
    result = File.join(args, CGI.unescape(page_instance.url))
    result = File.join(result, "index.html") if page_instance.url =~ /\/$/
    puts result
    result
  end
end