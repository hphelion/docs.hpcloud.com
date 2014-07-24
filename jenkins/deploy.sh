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
stackato target https://api.${DOMAIN}
stackato login --password ${PASSWORD} ${LOGIN}
stackato group Documentation
stackato unmap docs-${APP} docs.${URL} || true
cp stackato-${APP}.yml stackato.yml
stackato stop docs-${APP}
# Following two commnds deprecated in stackato client 3.2.1
stackato update -n --nostart docs-${APP} ||
stackato update -n --nostart docs-${APP}
echo "Deploying http://docs-${APP}.${DOMAIN}"
stackato start docs-${APP}
stackato map docs-${APP} docs.${URL}
rm -f stackato.yml
echo "Done."
exit 0
