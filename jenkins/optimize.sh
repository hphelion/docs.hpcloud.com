#!/bin/bash -e
#
# Optimize _size
#
echo "Minifying the CSS..."
java -jar _build/yuicompressor.jar --verbose --type css -o _site/css/application.css _site/css/application.css
echo "Minifying the HTML..."
java -jar _build/htmlcompressor.jar -r --type html -o _site _site
