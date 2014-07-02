echo "running docs.hpcloud.com/jenkins/pdfer.sh"

cd _site
find cloudos -name index.html | 
while read FILE
do
   DIR=$(echo $FILE | sed -e 's/index.html//')
   RELATIVE=$(echo $DIR| sed -e 's,[^/]*/,\.\./,g')
   PDFFILE=$(echo $FILE | sed -e 's/index.html/index.pdf/' -e 's,cloudos,pdf/cloudos,')
   echo "============== $DIR - $RELATIVE"
   sed -i -e "s,/cloudos/\([^\"]*\)\",${RELATIVE}cloudos/\1index.pdf\",g" $FILE
   mkdir -p $DIR
   wkhtmltopdf $FILE $PDFFILE
   echo "============== $PDFFILE"
done
