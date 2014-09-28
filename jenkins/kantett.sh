#!/bin/bash
ftp_site=kantatt.de
username=w007a881
passwd=only4kantett
remote=/path/to/remote/folder
folder=$1
#cd /home/jenkins/DevExBuild/workspace/docs-emergency-build/_site/$folder


pwd
ftp -in <<END_SCRIPT
open $ftp_site
user $username $passwd
#mkdir $remote/$folder
#cd $remote/$folder
#mput *
/home/jenkins/DevExBuild/workspace/docs-emergency-build/_site/index.html
close
bye