#!/bin/bash

set -eu

CONFIGFILE=${DEVSMCONFIGFILE:-/etc/sysconfig/SuperManager}
[ -f ${CONFIGFILE} ] && source ${CONFIGFILE}

if [ "x${SM_DEBUGSCRIPTS}" = 1 ]
then
  set -vx
fi

BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )

if [ -n "${DATADIR}" ] ; then
  ROOTDATA=${DATADIR}
else
  ROOTDATA=${BASEDIR}
fi

mkdir -pv ${ROOTDATA}/{temporada,programa}

