#!/bin/bash 

BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )
TODAY=$(date '+%Y%m%d%H%M')

ORIGSMFILE="${BASEDIR}/full/SM2017.latest.p"
DESTSMFILE="${BASEDIR}/full/SM2017.newest.p"
DESTSMFILEDATED="${BASEDIR}/full/SM2017.${TODAY}.p"


if [ $? = 0 ]
then
  if [ -f ${DESTSMFILE} ]
  then
    cp ${DESTSMFILE} ${DESTSMFILEDATED}
    gzip -9 ${DESTSMFILEDATED}
    mv ${DESTSMFILE} ${ORIGSMFILE}
  fi
fi  

