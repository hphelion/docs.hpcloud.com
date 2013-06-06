#!/bin/bash -e
#
# Generic deploy script
#
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
stackato login
stackato group Documentation
stackato unmap docs-${APP} docs.${URL} || true
cp stackato-${APP}.yml stackato.yml
stackato stop docs-${APP}
stackato update -n --nostart docs-${APP} ||
stackato update -n --nostart docs-${APP}
echo "Deploying http://docs-${APP}.${DOMAIN}"
stackato start -timeout 360 docs-${APP}
stackato map docs-${APP} docs.${URL}
rm -f stackato.yml
echo "Done."
exit 0
