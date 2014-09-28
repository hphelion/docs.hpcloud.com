#!/bin/sh
 
cd /home/jenkins/DevExBuild/workspace/docs-emergency-build/_site/
 
ftp -np kantett.de <<SCRIPT
user w007a881 only4kantett
ascii
put index.html
quit
SCRIPT
exit 0