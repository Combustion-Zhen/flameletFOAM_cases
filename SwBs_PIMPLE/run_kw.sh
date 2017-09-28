#!/bin/bash

NPROC=14

sed -e "s/@STARTTIME@/startTime/g" \
    -e "s/@ENDTIME@/0.005/g" -e "s/@DELTAT@/1e-6/g" \
    -e "s/@WRITEINTERVAL@/1000/g" -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g"  \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict

#sed "s/@NUMSUBDOM@/$NPROC/g" \
#    system/decomposeParDict_template > system/decomposeParDict
#decomposePar

mpirun -n $NPROC pimpleFoam -parallel

#sed -e "s/@STARTFROM@/latestTime/g" -e "s/@STARTTIME@/0.0/g" \
#    -e "s/@ENDTIME@/0.01/g" -e "s/@DELTAT@/1e-6/g" \
#    -e "s/@WRITEINTERVAL@/1000/g" -e "s/@WRITEFORMAT@/binary/g" \
#    -e "s/@ENABLED@/false/g"  \
#    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
#    system/controlDict_template > system/controlDict
#mpirun -n $NPROC pimpleFoam -parallel
#
#sed -e "s/@STARTFROM@/latestTime/g" -e "s/@STARTTIME@/0.0/g" \
#    -e "s/@ENDTIME@/0.015/g" -e "s/@DELTAT@/1e-6/g" \
#    -e "s/@WRITEINTERVAL@/1000/g" -e "s/@WRITEFORMAT@/binary/g" \
#    -e "s/@ENABLED@/false/g"  \
#    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
#    system/controlDict_template > system/controlDict
#mpirun -n $NPROC pimpleFoam -parallel
