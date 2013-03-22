cd content
rm -rf api
git clone git@git.hpcloud.net:DevExDocs/apihome.git
mv apihome api
cd api
git checkout "${1}"
git pull origin "${1}"
