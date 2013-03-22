#!/bin/bash -e
#
# This script pulls in the documentation repo into the content directory
#
if [ -z "${1}" ]
then
  echo "Usage: ${0} <branch>"
  exit 1
fi
BRANCH="${1}"
mkdir -p content
cd content
rm -rf documentation
git clone git@git.hpcloud.net:DevExDocs/documentation.git
cd documentation
git checkout "${BRANCH}"
git pull origin "${BRANCH}"
