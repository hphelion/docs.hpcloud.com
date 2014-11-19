#!/bin/bash 
 
echo "start"

#Delete any tempfiles left over from the last run and write introduction
rm checktmp > /dev/null 2>&1  
rm permalinklist1.txt  > /dev/null 2>&1  
rm permalinklist2.txt  > /dev/null 2>&1  
rm filepermalink1.txt > /dev/null 2>&1  
rm master-toc.tmp > /dev/null 2>&1 
 
echo "---" > master-toc.md
echo "layout: defaul"t >> master-toc.md
echo "title: \"Master Index\"" >> master-toc.md
echo "permalink: /masterindex/" >> master-toc.md
echo "---" >> master-toc.md
echo "<!--UNDER REVISION-->" >> master-toc.md
echo "#Master Index#" >> master-toc.md
  
echo "start 1" 
for i in `find . -path ./redirects -prune -o -name "*.md" -print`
 
do
echo $i

	if [[ -z $(head $i | grep "published: false") ]];
	then				 
		sed ':a;N;$!ba;s/\n/ /g' $i |  sed 's|-->|-->\n|g' | sed 's|<!--.*-->||g' | sed 's|](|\n](|g'  | grep "](/.*)" | sed 's/.*](//' | sed 's/).*//' | sed 's|#.*||' | grep -v "/api/" | grep -v "^/file/" | sed 's|\/$||' >> permalinklist1.txt
		cat permalinklist1.txt | sed 's/ *//g'  | grep -v http | sort | uniq >> permalinklist2.txt
		grep permalink $i | sed 's|.* /|/|' | sed 's|\/$||' >> filepermalink1.txt
		head -10 $i | tail -5 | grep title | sed 's/title: //'| sed 's/"//g'								
		echo "* ["`head -10 $i | grep title | sed 's/title: //'| sed 's/"//g'`"]("`head $i | grep permalink | sed 's/permalink: //'`")" >> master-toc.tmp
	fi
done


rm checktmp > /dev/null 2>&1  
rm permalinklist1.txt  > /dev/null 2>&1  
rm permalinklist2.txt  > /dev/null 2>&1  
rm filepermalink1.txt > /dev/null 2>&1  
rm master-toc.tmp > /dev/null 2>&1 
