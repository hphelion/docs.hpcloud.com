#!/bin/bash -e
#
# This script builds the _site directory
#
ejekyll build
#
# Special post-build logo handling for Cloud OS docs
#
find _site/cloudos -name "index.html" -print | xargs sed -i -e 's#<a href="http://www.hpcloud.com/" class="logo"><img src="/images/hp-public-cloud-logo.png" alt="HP Public Cloud" />#<a href="/cloudos" class="logo"><img src="/images/hp-cloud-logo.png" alt="HP Cloud" />#g'
