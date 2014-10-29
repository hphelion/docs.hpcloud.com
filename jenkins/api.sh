#!/bin/bash -e
#
# This script pulls in the apihome repo into the content directory
#

echo 'running docs.hpcloud.com/jenkins/api.sh'
#if [ -z "${1}" ]
#then
#  echo "Usage: ${0} <branch>"
#  exit 1
#fi
#BRANCH="${1}"
#mkdir -p content
#cd content
#rm -rf api
#git clone git@git.hpcloud.net:DevExDocs/apihome.git
#mv apihome api
#cd api
#git checkout "${BRANCH}"
#git pull origin "${BRANCH}"
cp -r ./content/documentation/publiccloud/apidocs/* ./content/api/