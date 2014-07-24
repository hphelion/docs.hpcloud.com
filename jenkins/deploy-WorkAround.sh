#!/bin/bash -e
#
# Generic deploy script
#

echo 'running docs.hpcloud.com/jenkins/deploy.sh'
if [ -z "${1}" -o -z "${2}" ]
then
  echo "Usage: ${0} application domain <url>"
  exit 1
fi
APP="${1}"
DOMAIN="${2}"
if [ -n "${3}" ]
then
  URL=${3}
else
  URL=${DOMAIN}
fi
echo "Deploying http://docs.${URL}"
set -x
~/stackato/stackato target https://api.${DOMAIN}
~/stackato/stackato login
~/stackato/stackato group Documentation
~/stackato/stackato unmap docs-${APP} docs.${URL} || true
cp stackato-${APP}.yml stackato.yml
~/stackato/stackato stop docs-${APP}
#stackato update -n --nostart docs-${APP} ||
#stackato update -n --nostart docs-${APP}
~/stackato/stackato push docs-${APP} ||
~/stackato/stackato push docs-${APP}
echo "Deploying http://docs-${APP}.${DOMAIN}"
~/stackato/stackato start docs-${APP}
~/stackato/stackato map docs-${APP} docs.${URL}
rm -f stackato.yml
echo "Done."
exit 0
