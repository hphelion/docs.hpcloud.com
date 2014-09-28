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
./jenkins/api.sh master
./jenkins/documentation.sh  development

echo '=build==============================================================='
./jenkins/clean.sh
 

echo '=deploy================================================================'


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


ejekyll build --trace

 cp _site/* /var/www/

#
# Special post-build logo handling for Cloud OS docs:
#
# find _site/cloudos -name "index.html" -print | xargs sed -i -e 's#<a href="http://www.hpcloud.com/" class="logo"><img src="/images/hp-public-cloud-logo.png" alt="HP Public Cloud" />#<a href="/cloudos" class="logo"><img src="/images/hp-cloud-logo.png" alt="HP Cloud" />#g'
#
# Next, replace Sign Up Now text (which is irrelevant for Cloud OS private clouds) and link target with For More Info and better Cloud OS target URL:
#
find _site/cloudos -name "index.html" -print | xargs sed -i -e 's#<a href="https://console.hpcloud.com/signup" class="signup-button-orange gutter-top-half">Sign Up Now</a>#<a href="https://cloudos.hpwsportal.com" target="_blank" class="signup-button-orange gutter-top-half">For More Info</a>#g'
#
# Now replace For More Info target link on Cloud OS for Moonshot pages:
#
find _site/cloudos/moonshot -name "index.html" -print | xargs sed -i -e 's#<a href="https://cloudos.hpwsportal.com" target="_blank" class="signup-button-orange gutter-top-half">For More Info</a>#<a href="http://www.hp.com/go/moonshot" target="_blank" class="signup-button-orange gutter-top-half">For More Info</a>#g'

ifconfig | grep Bcast
