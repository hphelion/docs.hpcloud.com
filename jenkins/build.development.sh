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
./jenkins/api.sh develop
./jenkins/documentation.sh development

echo '=build==============================================================='
./jenkins/clean.sh

 
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
ejekyll build

cp ./_site/* /var/www/
 