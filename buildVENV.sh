#!/bin/bash

set -e
HEREDIR=$(cd "$(dirname $(readlink -e $0))" && pwd )
TARGETDIR="${HEREDIR}/../venv"

function soLong {
  MSG=${1:-No msg}
  echo ${MSG}
  exit 1
}


function help {
  #https://stackoverflow.com/a/1655389
  MSG=$(cat<<FIN
  $0 : Crea Virtual environment con requirements (opcionales). Uso:

  $0 [VENVHOME] [REQSFILES]

  VENVHOME: Ubicación del virtual environment. Por defecto '${TARGETDIR}'
  REQSFILES: Ficheros requirements.txt con módulos a instalar. Se instalan todos a la vez

FIN
)
  echo "${MSG}"
  exit 1
}

if [ "x$1" = "x-h" ]
then
  help
  exit 1
fi

VENVHOME=${1:-${TARGETDIR}}
ACTIVATIONSCR="${VENVHOME}/bin/activate"

shift

if [ -d ${VENVHOME} -a -f ${ACTIVATIONSCR} ]
then
  #Nothing to see here
  exit 0
fi

echo "Creando VENV en ${VENVHOME}"
python -mvenv --clear ${VENVHOME} || soLong "Problemas creand VENV en ${VENVHOME}"
source ${ACTIVATIONSCR}  || soLong "Problemas cargando ${ACTIVATIONSCR}"
pip install --upgrade pip wheel

PARAMREQS=""
for REQ in $*
do
  echo "===REQ ${REQ}"
  if [ -f $REQ -a -r $REQ ]
  then
    PARAMREQS="${PARAMREQS} -r $REQ"
  fi
done

if [ -n "${PARAMREQS}" ]
then
  pip install ${PARAMREQS}
fi
