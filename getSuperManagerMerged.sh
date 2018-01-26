#!/bin/bash 

CONFIGFILE=/etc/sysconfig/SuperManager

BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )
TODAY=$(date '+%Y%m%d%H%M')

if [ -n "${DATADIR}" ] ; then
  ROOTDATA=${DATADIR}
else
  ROOTDATA=${BASEDIR}
fi

WRKDIR="${ROOTDATA}/wrk"

[ -f ${CONFIGFILE} ] && source ${CONFIGFILE}

if [ "x${SM_REPO}" = "x" ]
then
  echo "ORROR: No se ha suministrado valor para SM_REPO. Adios."
  exit 1
fi
[ -d ${WRKDIR} ] && rm -rf  ${WRKDIR}
mkdir -p ${WRKDIR}
git clone -q --branch master ${SM_REPO} ${WRKDIR}

if [ $? != 0 ]
then
  echo "$0: Problems with GIT. Bye"
  exit 1
fi

source /home/calba/devel/SuperManagerPython/SACBenv/bin/activate

ORIGSMFILE="${ROOTDATA}/full/SM2017.latest.p"
DESTSMFILE="${ROOTDATA}/full/SM2017.newest.p"
DESTSMFILEDATED="${ROOTDATA}/full/SM2017.${TODAY}.p"
TEMPORADA="${ROOTDATA}/temporada/ACB2017.latest.p"


python ${WRKDIR}/GetSuperManagerMerged.py -u ${SM_USER} -p ${SM_PASSWORD} -i ${ORIGSMFILE} -o ${DESTSMFILE} -t ${TEMPORADA}

if [ $? = 0 ]
then
  if [ -f ${DESTSMFILE} ]
  then
    cp ${DESTSMFILE} ${DESTSMFILEDATED}
    gzip -9 ${DESTSMFILEDATED}
    mv ${DESTSMFILE} ${ORIGSMFILE}
  fi
fi  


