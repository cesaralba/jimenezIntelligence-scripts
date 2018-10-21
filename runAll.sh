#!/bin/bash

BASEDIR=$(cd "$(dirname $(readlink -e $0))" && pwd )


bash ${BASEDIR}/buildDataTree.sh
bash ${BASEDIR}/getMercado.sh
bash ${BASEDIR}/getTemporada.sh
bash ${BASEDIR}/getSuperManagerMerged.sh -y
