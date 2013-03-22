#!/bin/bash -e
if [ -z "${1}" ]
then
  echo "Usage: ${0} domain"
  exit 1
fi
DOMAIN="${1}"
if [ -n "${2}" ]
then
  URL=${2}
else
  URL=${DOMAIN}
fi
echo "Deploying http://docs.${URL}"
set -x
stackato target https://api.${DOMAIN}
stackato login
stackato group Documentation
stackato map docs-two docs.${URL} || true
stackato unmap docs-one docs.${URL} || true
cp stackato-one.yml stackato.yml
stackato stop docs-one
stackato update -n --nostart docs-one ||
stackato update -n --nostart docs-one
echo "Deploying http://docs-one.${DOMAIN}"
stackato start docs-one
stackato map docs-one docs.${URL}
stackato unmap docs-two docs.${URL} || true
cp stackato-two.yml stackato.yml
stackato stop docs-two
stackato update -n --nostart docs-two ||
stackato update -n --nostart docs-two
echo "Deploying http://docs-two.${DOMAIN}"
stackato start docs-two
stackato map docs-two docs.${URL}
rm -f stackato.yml
echo "Done."
exit 0
