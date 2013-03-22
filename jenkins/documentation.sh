#!/bin/bash -e
#
#
#
mkdir -p content
cd content
rm -rf documentation
git clone git@git.hpcloud.net:DevExDocs/documentation.git
cd documentation
git checkout "${1}"
git pull origin "${1}"
