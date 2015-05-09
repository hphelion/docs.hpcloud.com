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

./jenkins/documentation.sh master
./jenkins/api.sh 

echo '=build==============================================================='
./jenkins/clean.sh

chmod 777 ./jenkins/*.sh
./jenkins/makeTOC.sh "PUBLISHED"

./jenkins/build.sh

echo '=deploy================================================================'
./jenkins/deploy.sh one secondary1-stackato.cx.hpcloud.net hpcloud.com <<!
${LOGIN}
${PASSWORD}
!
./jenkins/deploy.sh one prod1-stackato.cx.hpcloud.net hpcloud.com <<!
${LOGIN}
${PASSWORD}
!
./jenkins/deploy.sh two secondary1-stackato.cx.hpcloud.net hpcloud.com <<!
${LOGIN}
${PASSWORD}
!
./jenkins/deploy.sh two prod1-stackato.cx.hpcloud.net hpcloud.com <<!
${LOGIN}
${PASSWORD}
!


./jenkins/deploy.sh one secondary1-stackato.cx.hpcloud.net hpcloud.com
./jenkins/deploy.sh one prod1-stackato.cx.hpcloud.net hpcloud.com 
./jenkins/deploy.sh two secondary1-stackato.cx.hpcloud.net hpcloud.com
./jenkins/deploy.sh two prod1-stackato.cx.hpcloud.net hpcloud.com


git remote set-url origin https://helion-jenkins:D0cuments!@github.com/hphelion/docs.hpcloud.com.git
BRANCH=`git branch | grep "\*" | sed 's|^\* ||'`
git tag -a "$BUILD_TAG-$BRANCH" -m "$REASON_FOR_PUBLISHING (This tag was created by a jenkins build to indicate the fileset used for that build.)"
git push --tags

cd content/documentation/
pwd
git remote set-url origin https://helion-jenkins:D0cuments!@github.com/hphelion/documentation.git
BRANCH=`git branch | grep "\*" | sed 's|^\* ||'`
git tag -a "$BUILD_TAG-$BRANCH" -m "$REASON_FOR_PUBLISHING (This tag was created by a jenkins build to indicate the fileset used for that build.)"

git push --tags

echo '====================================================================='
echo 'http://docs.hpcloud.com/'
echo '====================================================================='
