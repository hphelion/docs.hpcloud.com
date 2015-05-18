#!/bin/bash 
 

#Delete any tempfiles left over from the last run and write introduction
rm master-toc.md > /dev/null 2>&1
rm master-toc.tmp > /dev/null 2>&1
 
echo "---" > master-toc.md
echo "layout: default" >> master-toc.md
echo "title: \"Master TOC\"" >> master-toc.md
echo "permalink: /master-toc/" >> master-toc.md
echo "---" >> master-toc.md
echo "<!--$1-->" >> master-toc.md
echo "#Master TOC#" >> master-toc.md
echo "Below is a list of all the pages on docs.hpcloud.com"  >> master-toc.md
echo " " >> master-toc.md
echo " " >> master-toc.md
 
 
 
 
for i in `find . -path ./content/documentation/redirects -prune -o -name "*.md" -print`
 
do


	if [[ -z $(head $i | grep "published: *false") ]];
	then		
if [[ -z $(grep  redirect $i) ]]
then
echo "* ["`head -10 $i | grep title | sed 's/title: //'| sed 's/"//g'`"]("`head $i | grep permalink | sed 's/permalink: //'`")" >> master-toc.tmp
fi
	fi


done

sort -t "(" -k 2 master-toc.tmp | grep -v "\[\]\(\)"  | grep -v "error.html"   >> master-toc.md
