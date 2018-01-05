#!/bin/bash

CONFIGFILE=/etc/sysconfig/SuperManager

REPOURL="git@github.com:cesaralba/jimenezIntelligence.git"
BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )
WRKDIR="${BASEDIR}/wrk"
TODAY=$(date '+%Y%m%d%H%M')

[ -d ${WRKDIR} ] && rm -rf  ${WRKDIR}
mkdir -p ${WRKDIR}
git clone -q --branch master ${REPOURL} ${WRKDIR}

if [ $? != 0 ]
then
  echo "$0: Problems with GIT. Bye"
  exit 1
fi

source /home/calba/devel/SuperManagerPython/SACBenv/bin/activate

[ -f ${CONFIGFILE} ] && source ${CONFIGFILE}

ORIGSMFILE="${BASEDIR}/datos/SM2017.latest.p"
DESTSMFILE="${BASEDIR}/datos/SM2017.newest.p"
DESTSMFILEDATED="${BASEDIR}/datos/SM2017.${TODAY}.p"

python ${WRKDIR}/BrowseSuperManager.py -u ${SM_USER} -p ${SM_PASSWORD} -i ${ORIGSMFILE} -o ${DESTSMFILE}

if [ $? = 0 ]
then
  if [ -f ${DESTSMFILE} ]
  then
    cp ${DESTSMFILE} ${DESTSMFILEDATED}
    gzip -9 ${DESTSMFILEDATED}
    mv ${DESTSMFILE} ${ORIGSMFILE}
  fi
fi  


chown -R calba /home/calba/devel/SuperManager

