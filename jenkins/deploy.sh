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
echo "===stackato target==="
stackato target https://api.${DOMAIN}

echo "===stackato login==="
stackato login --password ${PASSWORD} ${LOGIN}

echo "===stackato group==="
stackato group Documentation

echo "===stackato unmap==="
stackato unmap docs-${APP} docs.${URL} || true

echo "===stackato stackato.yml==="
cp stackato-${APP}.yml stackato.yml

echo "===stackato stop==="
stackato stop docs-${APP}

echo "===stackato update==="
# Following two commnds deprecated in stackato client 3.2.1
stackato update -n --nostart docs-${APP} ||
stackato update -n --nostart docs-${APP}
 
echo "Deploying http://docs-${APP}.${DOMAIN}"

echo "===stackato start==="
stackato start docs-${APP}

echo "===stackato map==="
stackato map docs-${APP} docs.${URL}

echo "===stackato stackato.yml==="
rm -f stackato.yml
echo "Done."
exit 0
