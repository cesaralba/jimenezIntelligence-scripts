#!/bin/bash

BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )

if [ -n "${DATADIR}" ] ; then
  ROOTDATA=${DATADIR}
else
  ROOTDATA=${BASEDIR}
fi

mkdir -p ${ROOTDIR}/{mercado,full,temporada}

