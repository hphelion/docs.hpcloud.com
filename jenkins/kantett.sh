#!/bin/bash
ftp_site=kantatt.de
username=w007a881
passwd=only4kantett
remote=/path/to/remote/folder
folder=$1
#cd /home/jenkins/DevExBuild/workspace/docs-emergency-build/_site/$folder

/home/jenkins/DevExBuild/workspace/docs-emergency-build/_site/
pwd
ftp -in <<EOF
open $ftp_site
user $username $passwd
mkdir $remote/$folder
cd $remote/$folder
#mput *
put index.html
close
bye