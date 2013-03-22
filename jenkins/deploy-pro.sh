#!/bin/bash -e
export TERM=xterm-256color
source "$HOME/.rvm/scripts/rvm"
rvm use ruby-1.9.2@docs

echo '=git================================================================='
git checkout master
git pull origin master

echo '=build==============================================================='
./jenkins/clean.sh
./jenkins/build.sh

echo '=deploy================================================================'
./jenkins/deploy.sh secondary1-stackato.cx.hpcloud.net hpcloud.com <<!
${LOGIN}
${PASSWORD}
!
./jenkins/deploy.sh prod1-stackato.cx.hpcloud.net hpcloud.com <<!
${LOGIN}
${PASSWORD}
!

echo '====================================================================='
echo 'http://docs.hpcloud.com/'
echo '====================================================================='
