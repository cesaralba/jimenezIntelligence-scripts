#!/bin/bash 

BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )
TODAY=$(date '+%Y%m%d%H%M')

ORIGSMFILE="${BASEDIR}/temporada/ACB2017.latest.p"
DESTSMFILE="${BASEDIR}/full/ACB2017.newest.p"
DESTSMFILEDATED="${BASEDIR}/full/ACB2017.${TODAY}.p"


if [ $? = 0 ]
then
  if [ -f ${DESTSMFILE} ]
  then
    cp ${DESTSMFILE} ${DESTSMFILEDATED}
    gzip -9 ${DESTSMFILEDATED}
    mv ${DESTSMFILE} ${ORIGSMFILE}
  fi
fi  

