#!/bin/bash 

CONFIGFILE=/etc/sysconfig/SuperManager
[ -f ${CONFIGFILE} ] && source ${CONFIGFILE}
CLAVEYEAR=${FILEKEY:-2018}

HOMEUSER=$(grep ${DEST_USER} /etc/passwd | awk -F: '{print $6}')
BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )
TODAY=$(date '+%Y%m%d%H%M')
DESTDIR="${HOMEUSER}/Dropbox/SuperManager"


[ -d ${DESTDIR} ] && mkdir -p  ${DESTDIR}

SMFILE="${BASEDIR}/full/SM${CLAVEYEAR}.latest.p"
TEMPORADA="${BASEDIR}/temporada/ACB${CLAVEYEAR}.latest.p"


rsync -aq  ${SMFILE} ${TEMPORADA} ${DESTDIR}
