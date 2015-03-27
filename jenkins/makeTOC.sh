#!/bin/bash 
 

#Delete any tempfiles left over from the last run and write introduction
rm master-toc.md > /dev/null 2>&1
rm master-toc.tmp > /dev/null 2>&1
 
echo "---" > master-toc.md
echo "layout: default" >> master-toc.md
echo "title: \"Master TOC\"" >> master-toc.md
echo "permalink: /master-toc/" >> master-toc.md
echo "---" >> master-toc.md
echo "<!--UNDER REVISION-->" >> master-toc.md
echo "#Master TOC#" >> master-toc.md
echo "This file is rebuilt each time docs-emergency-build is run."  >> master-toc.md
echo "The file is not copied to the master branch and not pushed to production." >> master-toc.md
echo " " >> master-toc.md

echo "
<div>
<script>
(function() {
var cx = '016914425578488494023:saefz1ifgsc';
var gcse = document.createElement('script');
gcse.type = 'text/javascript';
gcse.async = true;
gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
'//www.google.com/cse/cse.js?cx=' + cx;
var s = document.getElementsByTagName('script')[0];
 s.parentNode.insertBefore(gcse, s);
})();
</script>
<gcse:search></gcse:search> 
</div>" >> master-toc.md 
 
for i in `find . -path ./content/documentation/redirects -prune -o -name "*.md" -print`
 
do


	if [[ -z $(head $i | grep "published: false") ]];
	then		
if [[ -z $(grep  redirect $i) ]]
then
echo "* ["`head -10 $i | grep title | sed 's/title: //'| sed 's/"//g'`"]("`head $i | grep permalink | sed 's/permalink: //'`")" >> master-toc.tmp
fi
	fi


done

sort -t "(" -k 2 master-toc.tmp | grep -v "\[\]\(\)"  | grep -v "error.html"   >> master-toc.md
