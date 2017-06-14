#!/bin/bash
#SBATCH --accout=k1242
#SBATCH --partition=workq
#SBATCH --job-name=fltD_chi
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=32
#SBATCH --ntasks=128
#SBATCH --ntasks-per-socket=16
#SBATCH --time=1-00:00:00
#SBATCH -e job%J.err
#SBATCH -o job%J.out

sed -e "s/@STARTTIME@/startTime/g" -e "s/@ENDTIME@/0.001/g" \
    -e "s/@DELTAT@/1e-7/g" -e  "s/@WRITEINTERVAL@/0.001/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g"  \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict

blockMesh
extrudeMesh
stitchMesh front back -perfect
cp 1e-07/* 0
cp 1e-07/polyMesh/* constant/polyMesh
rm -r 1e-07
cp 0.bak/* 0
canteraToFoam
setFields
decomposePar

OMP_NUM_THREADS=1

sed -e "s/@DIVPHIU@/Gauss vanLeer/g" \
    system/fvSchemes_template > system/fvSchemes
srun --hint=nomultithread flameletFoam -parallel

cp system/controlDict system/log1_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.01/g" \
    -e "s/@DELTAT@/1e-6/g" -e "s/@WRITEINTERVAL@/0.009/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
sed -e "s/@DIVPHIU@/Gauss vanLeer/g" \
    system/fvSchemes_template > system/fvSchemes
srun --hint=nomultithread flameletFoam -parallel

cp system/controlDict system/log2_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.10/g" \
    -e "s/@DELTAT@/1e-6/g" -e "s/@WRITEINTERVAL@/0.01/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
sed -e "s/@DIVPHIU@/Gauss vanLeer/g" \
    system/fvSchemes_template > system/fvSchemes
srun --hint=nomultithread flameletFoam -parallel

cp system/controlDict system/log3_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.15/g" \
    -e "s/@DELTAT@/1e-6/g" -e  "s/@WRITEINTERVAL@/0.01/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
sed -e "s/@DIVPHIU@/Gauss linear/g" \
    system/fvSchemes_template > system/fvSchemes
srun --hint=nomultithread flameletFoam -parallel

# START TAKING AVERAGES

cp system/controlDict system/log4_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.20/g" \
    -e "s/@DELTAT@/1e-6/g" -e  "s/@WRITEINTERVAL@/0.01/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
sed -e "s/@DIVPHIU@/Gauss linear/g" \
    system/fvSchemes_template > system/fvSchemes
srun --hint=nomultithread flameletFoam -parallel


# CONTINUE AVERAGING
cp system/controlDict system/log5_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.25/g" \
    -e "s/@DELTAT@/1e-6/g" -e  "s/@WRITEINTERVAL@/0.01/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
sed -e "s/@DIVPHIU@/Gauss linear/g" \
    system/fvSchemes_template > system/fvSchemes
srun --hint=nomultithread flameletFoam -parallel
