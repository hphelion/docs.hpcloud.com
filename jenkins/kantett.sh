#!/bin/sh
 
remote=/
folder=$1

cd /home/jenkins/DevExBuild/workspace/docs-emergency-build/_site/$folder

ftp -np kantett.de <<SCRIPT
user w007a881 only4kantett
ascii
mkdir $remote/$folder
cd $remote/$folder
mput *
close
bye
SCRIPT
exit 0


 

