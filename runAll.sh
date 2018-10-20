#!/bin/bash

BASEDIR=$(cd "$(dirname $(readlink -e $0))/../" && pwd )


bash ${BASEDIR}/bin/buildDataTree.sh
bash ${BASEDIR}/bin/getMercado.sh
bash ${BASEDIR}/bin/getTemporada.sh
bash ${BASEDIR}/bin/getSuperManagerMerged.sh -y
