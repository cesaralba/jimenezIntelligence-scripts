#!/bin/bash

set -vx

CONFIGFILE=${DEVSMCONFIGFILE:-/etc/sysconfig/SuperManager}
[ -f ${CONFIGFILE} ] && source ${CONFIGFILE}

set -eu
ME="$(readlink -e $0)"
HEREDIR=$(cd "$(dirname ${ME})" && pwd )
BASEDIR=$(cd "${HEREDIR}/../" && pwd )

AUXVENVDIR="${BASEDIR}/venv"

VENVHOME=${VENVHOME:-${AUXVENVDIR}}
ACTIVATIONSCR="${VENVHOME}/bin/activate"

function soLong {
  MSG=${1:-No msg}
  echo ${MSG}
  exit 1
}

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


if [ -d ${VENVHOME} -a -f ${ACTIVATIONSCR} ]
then
  :
else
  echo "Creando VENV en ${VENVHOME}"
  python -mvenv --clear ${VENVHOME} || soLong "Problemas creand VENV en ${VENVHOME}"
fi

source ${ACTIVATIONSCR}  || soLong "Problemas cargando ${ACTIVATIONSCR}"
pip install -q -U pip wheel



PARAMREQS=""
for REQ in "${WRKDIR}/requirements.txt"
do
  if [ -f $REQ -a -r $REQ ]
  then
    PARAMREQS="${PARAMREQS} -r $REQ"
  else
    echo "Fichero de requisitos ${REQ} inexistente o no se puede leer. Ignorando"
  fi
done

if [ -n "${PARAMREQS}" ]
then
  pip install -q ${PARAMREQS}
fi
