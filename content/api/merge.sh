#!/bin/bash -e

BRANCH=${1}
if [ -z "${BRANCH}" ]
then
  echo "Usage: ${0} master|develop"
  exit 1
fi

export TERM=xterm-256color
source "$HOME/.rvm/scripts/rvm"
rvm use ruby-1.9.2@docs

echo '============================api-site============================'
rm -rf api-site
git clone git@git.hpcloud.net:DevExDocs/api-site.git
cd api-site
set -x
git checkout -b ${BRANCH} || git checkout ${BRANCH}
git pull origin ${BRANCH}
git subtree pull -P content/api git@git.hpcloud.net:DevExDocs/apihome.git ${BRANCH}
git push origin ${BRANCH}
set +x

echo '==========================docs.hpcloud.com======================'
rm -rf docs.hpcloud.com
git clone git@git.hpcloud.net:DevExDocs/docs.hpcloud.com.git
cd docs.hpcloud.com
set -x
git checkout -b ${BRANCH} || git checkout ${BRANCH}
git pull origin ${BRANCH}
git subtree pull -P content/api git@git.hpcloud.net:DevExDocs/apihome.git ${BRANCH}
git push origin ${BRANCH}
