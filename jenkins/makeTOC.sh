#!/bin/bash 
 

#Delete any tempfiles left over from the last run and write introduction
rm 1.1master-toc.md > /dev/null 2>&1
rm 1.1master-toc.tmp > /dev/null 2>&1
 
echo "---" > 1.1master-toc.md
echo "layout: defaul"t >> 1.1master-toc.md
echo "title: \"Master TOC\"" >> 1.1master-toc.md
echo "permalink: /1.1/contents/" >> 1.1master-toc.md
echo "---" >> 1.1master-toc.md
echo "<!--UNDER REVISION-->" >> 1.1master-toc.md
echo "#Master TOC#" >> 1.1master-toc.md
echo "This file is rebuilt each time docs-emergency-build is run."  >> 1.1master-toc.md
echo "The file is not copied to the master branch and not pushed to production." >> 1.1master-toc.md
echo " " >> 1.1master-toc.md
  
for i in `find . -path ./content/documentation/redirects -prune -o -name "*.md" -print`
 
do


	if [[ -z $(head $i | grep "published: false") ]];
	then		
if [[ -z $(grep  redirect $i) ]]
then
echo "* ["`head -10 $i | grep title | sed 's/title: //'| sed 's/"//g'`"]("`head $i | grep permalink | sed 's/permalink: //'`")" >> 1.1master-toc.tmp
fi
	fi


done

sort -t "(" -k 2 1.1master-toc.tmp | grep -v "\[\]\(\)"  | grep -v "error.html" | grep -v "1.0"  | grep -v "1.01"  >> 1.1master-toc.md
