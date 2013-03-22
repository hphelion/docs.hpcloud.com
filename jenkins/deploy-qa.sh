#!/bin/bash -e
#
# Run a deploy to qa
#
export TERM=xterm-256color
source "$HOME/.rvm/scripts/rvm"
rvm use ruby-1.9.2@docs

echo '=git================================================================='
git checkout develop
git pull origin develop

echo '=content============================================================='
./jenkins/api.sh develop
./jenkins/documentation.sh develop

echo '=build==============================================================='
./jenkins/clean.sh
./jenkins/build.sh
./jenkins/deploy.sh qa1-stackato.cx.hpcloud.net <<!
${LOGIN}
${PASSWORD}
!
echo '====================================================================='
echo 'http://docs.qa1-stackato.cx.hpcloud.net/'
echo '====================================================================='
