#!/bin/bash

CONFIGFILE=/etc/sysconfig/SuperManager

BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )
TODAY=$(date '+%Y%m%d%H%M')

[ -f ${CONFIGFILE} ] && source ${CONFIGFILE}
CLAVEYEAR=${FILEKEY:-2023}

if [ -n "${DATADIR}" ] ; then
  ROOTDATA=${DATADIR}
else
  ROOTDATA=${BASEDIR}
fi

if [ "x${SM_REPO}" = "x" ]
then
  echo "ORROR: No se ha suministrado valor para SM_REPO. Adios."
  exit 1
fi

WRKDIR="${ROOTDATA}/wrk"
[ -d ${WRKDIR} ] && rm -rf  ${WRKDIR}
mkdir -p ${WRKDIR}
git clone -q --branch master ${SM_REPO} ${WRKDIR}

if [ $? != 0 ]
then
  echo "$0: Problems with GIT. Bye"
  exit 1
fi

VENV=${VENVHOME:-"${BASEDIR}/venv"}

if [ -f "${VENV}/bin/activate" ] ; then
  source "${VENV}/bin/activate"
else
  echo "ORROR: Incapaz de encontrar activador de virtualenv"
fi


ORIGSMFILE="${ROOTDATA}/temporada/ACB${CLAVEYEAR}.latest.p"
DESTSMFILE="${ROOTDATA}/temporada/ACB${CLAVEYEAR}.newest.p"
DESTSMFILEDATED="${ROOTDATA}/temporada/ACB${CLAVEYEAR}.${TODAY}.p"

if [ -f ${ORIGSMFILE} ]
then
  ORIGPARAM="-i ${ORIGSMFILE}"
else
  ORIGPARAM="-f"
fi

#python ${WRKDIR}/DescargaTemporada.py -o ${DESTSMFILE} -f  -b
python ${WRKDIR}/DescargaTemporada.py ${ORIGPARAM} -o ${DESTSMFILE} -b
#python ${WRKDIR}/DescargaTemporada.py -e 62 -o ${DESTSMFILE}

if [ $? = 0 ]
then
  if [ -f ${DESTSMFILE} ]
  then
    cp ${DESTSMFILE} ${DESTSMFILEDATED}
    gzip -9 ${DESTSMFILEDATED}
    cp ${DESTSMFILEDATED}.gz ${DESTSMFILE}.gz
    mv ${DESTSMFILE} ${ORIGSMFILE}
  fi
fi
