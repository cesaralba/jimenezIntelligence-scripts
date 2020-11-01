#!/bin/bash

CONFIGFILE=/etc/sysconfig/SuperManager

HEREDIR=$(cd "$(dirname $(readlink -e $0))" && pwd)
BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd)

[ -f ${CONFIGFILE} ] && source ${CONFIGFILE}

VENV=${VENVHOME:-"${BASEDIR}/venv"}

if [ -f "${VENV}" ]; then
  echo "Borrando el Virtual Env existente ${VENV}"
  rm -rf ${VENV}
fi

python3 -mvenv --clear ${VENV}
source "${VENV}/bin/activate"
${VENV}/bin/python3 -m pip install --upgrade pip
${VENV}/bin/pip install -U setuptools wheel
${VENV}/bin/pip install -r "${HEREDIR}/requirements.txt"
