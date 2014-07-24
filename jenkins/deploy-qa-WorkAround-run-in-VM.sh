#!/bin/bash -e
#
# Run a deploy to qa
#

echo 'running docs.hpcloud.com/jenkins/deploy-qa.sh'
export TERM=xterm-256color
source "$HOME/.rvm/scripts/rvm"
rvm use ruby-1.9.2-p320@docs



echo '=build==============================================================='
./jenkins/clean.sh
./jenkins/build.sh
./jenkins/deploy-WorkAround.sh one qa1-stackato.cx.hpcloud.net  
./jenkins/deploy-WorkAround.sh two qa1-stackato.cx.hpcloud.net  
echo '====================================================================='
echo 'http://docs.qa1-stackato.cx.hpcloud.net/'
echo '====================================================================='
