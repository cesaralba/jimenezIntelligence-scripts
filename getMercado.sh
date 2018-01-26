#!/bin/bash

BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )
TODAY=$(date '+%Y%m%d%H%M')

if [ -n "${DATADIR}" ] ; then
  ROOTDATA=${DATADIR}
else
  ROOTDATA=${BASEDIR}
fi


DESTFILE="${ROOTDATA}/mercado/SuperManager-${TODAY}.html"

curl -s  http://supermanager.acb.com/mercado > $DESTFILE
gzip -9 ${DESTFILE}

chown -R calba:calba ${BASEDIR}

