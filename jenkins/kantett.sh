#!/bin/sh
 
ftp -n kantett.de <<SCRIPT
user w007a881 only4kantett
put /home/jenkins/DevExBuild/workspace/docs-emergency-build/_site/index.html
quit
SCRIPT
exit 0