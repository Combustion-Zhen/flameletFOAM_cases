#!/bin/bash

NPROC=14

sed -e "s/@STARTFROM@/startTime/g" -e "s/@STARTTIME@/0.0/g" \
    -e "s/@ENDTIME@/0.005/g" -e "s/@DELTAT@/1e-6/g" \
    -e "s/@WRITEINTERVAL@/1000/g" -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@AVE_ENABLED@/false/g" -e "s/@SAMPLE_ENABLED@/false/g" \
    system/controlDict_template > system/controlDict

blockMesh
extrudeMesh
stitchMesh front back -perfect
cp 1e-06/* 0/
cp 1e-06/polyMesh/* constant/polyMesh/
rm -r 1e-06

createPatch
cp 1e-06/polyMesh/* constant/polyMesh/
rm -r 1e-06
cp 0.bak/* 0
perturbUCylinder

sed "s/@NUMSUBDOM@/$NPROC/g" \
    system/decomposeParDict_template > system/decomposeParDict
decomposePar

mpirun -n $NPROC pimpleFoam -parallel

sed -e "s/@STARTFROM@/latestTime/g" -e "s/@STARTTIME@/0.0/g" \
    -e "s/@ENDTIME@/0.01/g" -e "s/@DELTAT@/1e-6/g" \
    -e "s/@WRITEINTERVAL@/1000/g" -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@AVE_ENABLED@/true/g" -e "s/@SAMPLE_ENABLED@/false/g" \
    system/controlDict_template > system/controlDict
mpirun -n $NPROC pimpleFoam -parallel

sed -e "s/@STARTFROM@/latestTime/g" -e "s/@STARTTIME@/0.0/g" \
    -e "s/@ENDTIME@/0.015/g" -e "s/@DELTAT@/1e-6/g" \
    -e "s/@WRITEINTERVAL@/1000/g" -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@AVE_ENABLED@/true/g" -e "s/@SAMPLE_ENABLED@/true/g" \
    system/controlDict_template > system/controlDict
mpirun -n $NPROC pimpleFoam -parallel
