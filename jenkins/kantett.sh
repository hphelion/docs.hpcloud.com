#!/bin/sh
HOST='kantett.de'
USER='w007a881'
PASSWD='w007a881'
FILE='index.html'

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
put $FILE
quit
END_SCRIPT
exit 0