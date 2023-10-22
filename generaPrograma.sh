#!/bin/bash

TARGETCLUB=${1:-RMB}

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
if [ ! -d ${WRKDIR} ]
then
  mkdir -p ${WRKDIR}
  git clone -q --branch master ${SM_REPO} ${WRKDIR}

  if [ $? != 0 ]
  then
    echo "$0: Problems with GIT. Bye"
    exit 1
  fi
fi

VENV=${VENVHOME:-"${BASEDIR}/venv"}

if [ -f "${VENV}/bin/activate" ] ; then
  source "${VENV}/bin/activate"
else
  echo "ORROR: Incapaz de encontrar activador de virtualenv"
fi


ORIGSMFILE="${ROOTDATA}/temporada/ACB${CLAVEYEAR}.latest.p"
REPORTDIR="${ROOTDATA}/programa/J${CLAVEYEAR}"

DESTFILENAME="sigPartido-${TARGETCLUB}-ACB${CLAVEYEAR}-${TODAY}.pdf"
DESTFILE="${REPORTDIR}/${DESTFILENAME}"

[ -d ${REPORTDIR} ] || mkdir -pv ${REPORTDIR}
if [ $? != 0 ]
then
  echo "$0: Problems creating ${REPORTDIR}"
  exit 1
fi

python ${WRKDIR}/bin/generaPrograma.py -t ${ORIGSMFILE} -e ${TARGETCLUB} -o ${DESTFILE}

if [ $? = 0 ]
then
  echo "$0: Generado ${DESTFILE}"
fi

