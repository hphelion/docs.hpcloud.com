echo 'running docs.hpcloud.com/jenkins/sync.sh'

SRCDIR=spec/fixtures/files/
TAINER=":tainer"
TMPDSTFILES=/tmp/sinkdst$$
TMPSRCFILES=/tmp/sinksrc$$

cd "${SRCDIR}"
find * | while read FILE
do
  if [ -f "${FILE}" ]
  then
    SUM=$(md5sum <"${FILE}" | sed -e 's/  *-//')
    echo "${FILE};${SUM}"
  fi
done | sort >${TMPSRCFILES}
hpcloud list "${TAINER}" -l -c sname,etag -d ';' |sort >${TMPDSTFILES}

IFS=';'
while read FILE SRCMD5SUM
do
  SRC="${FILE}"
  DEST="${TAINER}/${FILE}"
  if ! grep "^${FILE};${SRCMD5SUM}$" ${TMPDSTFILES} >/dev/null
  then
    hpcloud copy "${FILE}" "${DEST}"
  fi
done <${TMPSRCFILES}

while read FILE DESTMD5SUM
do
  SRC="${FILE}"
  DEST="${TAINER}/${FILE}"
  if [ ! -f "${SRC}" ]
  then
    hpcloud rm "${DEST}"
  fi
done <${TMPDSTFILES}

rm -f "${TMPDSTFILES}"
rm -f "${TMPSRCFILES}"
