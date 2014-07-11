#!/bin/bash -e
#
# Run a deploy
#

echo 'running docs.hpcloud.com/jenkins/deploy-pro.sh'
export TERM=xterm-256color
source "$HOME/.rvm/scripts/rvm"
rvm use ruby-1.9.2-p320@docs



echo '=deploy================================================================'
./jenkins/deploy-WorkAround.sh one secondary1-stackato.cx.hpcloud.net hpcloud.com  
./jenkins/deploy-WorkAround.sh one prod1-stackato.cx.hpcloud.net hpcloud.com  
./jenkins/deploy-WorkAround.sh two secondary1-stackato.cx.hpcloud.net hpcloud.com  
./jenkins/deploy-WorkAround.sh two prod1-stackato.cx.hpcloud.net hpcloud.com  

echo '====================================================================='
echo 'http://docs.hpcloud.com/'
echo '====================================================================='
