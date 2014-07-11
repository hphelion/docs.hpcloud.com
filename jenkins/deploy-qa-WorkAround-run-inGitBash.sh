#!/bin/bash -e
#
# Run a deploy to qa
#

echo 'running docs.hpcloud.com/jenkins/deploy-qa.sh'

echo '=git================================================================='
git checkout -f master
git pull origin master

echo '=content============================================================='

./jenkins/api.sh develop
./jenkins/documentation.sh master

echo '=build==============================================================='
./jenkins/clean.sh
 
