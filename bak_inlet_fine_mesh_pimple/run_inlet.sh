#!/bin/bash

TIMESTEP=2e-07
MAPCASE=../inlet_r96_pimple
MAPTIME=0.012
NPROC=14

sed -e "s/@STARTFROM@/startTime/g" -e "s/@STARTTIME@/0.0/g" \
    -e "s/@ENDTIME@/0.015/g" -e "s/@DELTAT@/$TIMESTEP/g" \
    -e "s/@WRITEINTERVAL@/1000/g" -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@AVE_ENABLED@/false/g" -e "s/@SAMPLE_ENABLED@/false/g" \
    system/controlDict_template > system/controlDict

# construct the mesh
blockMesh
extrudeMesh
stitchMesh front back -perfect
cp $TIMESTEP/* 0/
cp $TIMESTEP/polyMesh/* constant/polyMesh/
rm -r $TIMESTEP

# cyclic boundary
createPatch
cp $TIMESTEP/polyMesh/* constant/polyMesh/
rm -r $TIMESTEP

# boundary conditions
cp 0.bak/* 0

sed -e "s/@STARTFROM@/startTime/g" -e "s/@STARTTIME@/$MAPTIME/g" \
    -e "s/@ENDTIME@/0.015/g" -e "s/@DELTAT@/$TIMESTEP/g" \
    -e "s/@WRITEINTERVAL@/1000/g" -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@AVE_ENABLED@/false/g" -e "s/@SAMPLE_ENABLED@/false/g" \
    system/controlDict_template > system/controlDict

# map previous results
mapFields $MAPCASE -consistent

set "s/@NUMSUBDOM@/$NPROC/g" \
    system/decomposeParDict > system/decomposeParDict_template
decomposePar

mpirun -n $NPROC pimpleFoam -parallel

sed -e "s/@STARTFROM@/latestTime/g" -e "s/@STARTTIME@/0.012/g" \
    -e "s/@ENDTIME@/0.018/g" -e "s/@DELTAT@/$TIMESTEP/g" \
    -e "s/@WRITEINTERVAL@/1000/g" -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@AVE_ENABLED@/true/g" -e "s/@SAMPLE_ENABLED@/false/g" \
    system/controlDict_template > system/controlDict
mpirun -n $NPROC pimpleFoam -parallel
