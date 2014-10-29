#!/bin/bash -e
#
# Run a deploy to qa
#

echo 'running docs.hpcloud.com/jenkins/deploy-qa.sh'
export TERM=xterm-256color
source "$HOME/.rvm/scripts/rvm"
rvm use ruby-1.9.2-p320@docs

echo '=debug==============================================================='
echo "LOGIN IS: ${LOGIN}"
echo "PASSWORD IS: ${PASSWORD}"


echo '=git================================================================='
git checkout -f master
git pull origin master

echo '=content============================================================='
./jenkins/documentation.sh master
./jenkins/api.sh  


echo '=build==============================================================='
./jenkins/clean.sh
./jenkins/build.sh
./jenkins/deploy.sh one qa1-stackato.cx.hpcloud.net <<!
${LOGIN}
${PASSWORD}
!
./jenkins/deploy.sh two qa1-stackato.cx.hpcloud.net <<!
${LOGIN}
${PASSWORD}
!






echo '====================================================================='
echo 'http://docs.qa1-stackato.cx.hpcloud.net/'
echo '====================================================================='
