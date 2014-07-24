#!/bin/bash -e
#
# Generic deploy script
#

echo 'running  docs.hpcloud.com/jenkins/deploy.sh'
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
/usr/bin/stackato target https://api.${DOMAIN}
/usr/bin/stackato login
/usr/bin/stackato group Documentation
/usr/bin/stackato unmap docs-${APP} docs.${URL} || true
cp stackato-${APP}.yml stackato.yml
/usr/bin/stackato stop docs-${APP}
stackato update -n --nostart docs-${APP} ||
stackato update -n --nostart docs-${APP}
#/usr/bin/stackato push docs-${APP} ||
#/usr/bin/stackato push docs-${APP}
echo "Deploying http://docs-${APP}.${DOMAIN}"
/usr/bin/stackato start docs-${APP}
/usr/bin/stackato map docs-${APP} docs.${URL}
rm -f stackato.yml
echo "Done."
exit 0
