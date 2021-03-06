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
CLAVEYEAR=${FILEKEY:-2018}

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

VENV=${VENVHOME:-"${BASEDIR}/venv"}

if [ -f "${VENV}/bin/activate" ] ; then
  source "${VENV}/bin/activate"
else
  echo "ORROR: Incapaz de encontrar activador de virtualenv"
fi

ORIGSMFILE="${ROOTDATA}/full/SM${CLAVEYEAR}.latest.p"
TEMPORADA="${ROOTDATA}/temporada/ACB${CLAVEYEAR}.latest.p"
DESTSMFILE="${ROOTDATA}/full/SM${CLAVEYEAR}.newest.p"
DESTTMFILE="${ROOTDATA}/temporada/ACB${CLAVEYEAR}.newest.p"
DESTEXFILE="${ROOTDATA}/excel/SM.newest.xlsx"
DESTEXFILEDATED="${ROOTDATA}/excel/SM${TODAY}.xlsx"

python ${WRKDIR}/creaExcel.py -i ${ORIGSMFILE}  -t ${TEMPORADA} -o ${DESTEXFILE} $*
cp ${DESTEXFILE}  ${DESTEXFILEDATED}


