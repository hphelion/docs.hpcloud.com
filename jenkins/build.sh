#!/bin/bash -e
#
# This script builds the _site directory
#
ejekyll build
#
# Special post-build logo handling for Cloud OS docs:
#
find _site/cloudos -name "index.html" -print | xargs sed -i -e 's#<a href="http://www.hpcloud.com/" class="logo"><img src="/images/hp-public-cloud-logo.png" alt="HP Public Cloud" />#<a href="/cloudos" class="logo"><img src="/images/hp-cloud-logo.png" alt="HP Cloud" />#g'
#
# Next, replace Sign Up Now text (which is irrelevant for Cloud OS private clouds) and link target with For More Info and better Cloud OS target URL:
#
find _site/cloudos -name "index.html" -print | xargs sed -i -e 's#<a href="https://console.hpcloud.com/signup" class="signup-button-orange gutter-top-half">Sign Up Now</a>#<a href="https://cloudos.hpwsportal.com" class="signup-button-orange gutter-top-half">For More Info</a>#g'
