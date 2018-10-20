#!/bin/bash

CONFIGFILE=/etc/sysconfig/SuperManager

BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )
TODAY=$(date '+%Y%m%d%H%M')

[ -f ${CONFIGFILE} ] && source ${CONFIGFILE}

if [ -n "${DATADIR}" ] ; then
  ROOTDATA=${DATADIR}
else
  ROOTDATA=${BASEDIR}
fi


DESTFILE="${ROOTDATA}/mercado/SuperManager-${TODAY}.html"

curl -s  http://supermanager.acb.com/mercado > $DESTFILE
gzip -9 ${DESTFILE}

