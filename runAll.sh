#!/bin/bash

BASEDIR=$(cd "$(dirname $(readlink -e $0))" && pwd )

echo "Ejecución $(date)"

bash ${BASEDIR}/buildDataTree.sh
bash ${BASEDIR}/getMercado.sh
echo "Get Temporada"
bash ${BASEDIR}/getTemporada.sh
#echo "Get SuperManager"
#bash ${BASEDIR}/getSuperManagerMerged.sh -y
echo "Final ejecución $(date)"
