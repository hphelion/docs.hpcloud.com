#!/bin/bash 
 
echo "start"

#Delete any tempfiles left over from the last run and write introduction
rm master-toc.md > /dev/null 2>&1 
 
echo "---" > master-toc.md
echo "layout: defaul"t >> master-toc.md
echo "title: \"Master Index\"" >> master-toc.md
echo "permalink: /masterindex/" >> master-toc.md
echo "---" >> master-toc.md
echo "<!--UNDER REVISION-->" >> master-toc.md
echo "#Master TOC#" >> master-toc.md
echo "This file is rebuilt each time docs-emergency-build is run"  >> master-toc.md
echo "The file is not copied to the master branch and not pushed to production" >> master-toc.md
echo " " >> master-toc.md
  
for i in `find . -path ./redirects -prune -o -name "*.md" -print`
 
do


	if [[ -z $(head $i | grep "published: false") ]];
	then				 
		echo "* ["`head -10 $i | grep title | sed 's/title: //'| sed 's/"//g'`"]("`head $i | grep permalink | sed 's/permalink: //'`")" >> master-toc.md
	fi
done


