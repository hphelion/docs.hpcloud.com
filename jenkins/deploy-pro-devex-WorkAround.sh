#!/bin/bash -e
#
# Run a deploy
#

echo 'running docs.hpcloud.com/jenkins/deploy-pro.sh'
export TERM=xterm-256color
source "$HOME/.rvm/scripts/rvm"
rvm use ruby-1.9.2-p320@docs

echo '=git================================================================='
git checkout master
git pull origin master

echo '=content============================================================='
./jenkins/api.sh master
./jenkins/documentation.sh master

echo '=build==============================================================='
./jenkins/clean.sh
./jenkins/build.sh

echo '=deploy================================================================'
#./jenkins/deploy.sh one secondary1-stackato.cx.hpcloud.net hpcloud.com <<!
#${LOGIN}
#${PASSWORD}
#!
#./jenkins/deploy.sh one prod1-stackato.cx.hpcloud.net hpcloud.com <<!
#${LOGIN}
#${PASSWORD}
#!
#./jenkins/deploy.sh two secondary1-stackato.cx.hpcloud.net hpcloud.com <<!
#${LOGIN}
#${PASSWORD}
#!
#./jenkins/deploy.sh two prod1-stackato.cx.hpcloud.net hpcloud.com <<!
#${LOGIN}
#${PASSWORD}
#!


./jenkins/deploy-devex-WorkAround.sh one secondary1-stackato.cx.hpcloud.net hpcloud.com
./jenkins/deploy-devex-WorkAround.sh one prod1-stackato.cx.hpcloud.net hpcloud.com 
./jenkins/deploy-devex-WorkAround.sh two secondary1-stackato.cx.hpcloud.net hpcloud.com
./jenkins/deploy-devex-WorkAround.sh two prod1-stackato.cx.hpcloud.net hpcloud.com

echo '====================================================================='
echo 'http://docs.hpcloud.com/'
echo '====================================================================='
