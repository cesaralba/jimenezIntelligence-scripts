#!/bin/bash 

CONFIGFILE=/etc/sysconfig/SuperManager

BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )
WRKDIR="${BASEDIR}/wrk"
TODAY=$(date '+%Y%m%d%H%M')

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

ORIGSMFILE="${BASEDIR}/temporada/ACB2017.latest.p"
DESTSMFILE="${BASEDIR}/temporada/ACB2017.newest.p"
DESTSMFILEDATED="${BASEDIR}/temporada/ACB2017.${TODAY}.p"

python ${WRKDIR}/DescargaTemporada.py -e 62 -i ${ORIGSMFILE} -o ${DESTSMFILE}
#python ${WRKDIR}/DescargaTemporada.py -e 62 -o ${DESTSMFILE}

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

