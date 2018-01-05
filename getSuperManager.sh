#!/bin/bash

TODAY=$(date '+%Y%m%d%H%M')

source /home/calba/devel/SuperManagerPython/SACBenv/bin/activate

ORIGSMFILE="/home/calba/devel/SuperManager/datos/SM2017.latest.p"
DESTSMFILE="/home/calba/devel/SuperManager/datos/SM2017.newest.p"
DESTSMFILEDATED="/home/calba/devel/SuperManager/datos/SM2017.${TODAY}.p"

python /home/calba/Dropbox/devel/SuperManagerPython/BrowseSuperManager.py -u mirza15 -p delibasi -i ${ORIGSMFILE} -o ${DESTSMFILE}

if [ $? = 0 ]
then
  if [ -f ${DESTSMFILE} ]
  then
    cp ${DESTSMFILE} ${DESTSMFILEDATED}
    mv ${DESTSMFILE} ${ORIGSMFILE}
  fi
fi  


chown -R calba /home/calba/devel/SuperManager

