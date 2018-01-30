#!/bin/bash
#SBATCH --account=k1242
#SBATCH --job-name=SwBdFLTSFCD
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=32
#SBATCH --ntasks-per-socket=16
#SBATCH -e job%J.err
#SBATCH -o job%J.out
##SBATCH --partition=workq
##SBATCH --time=1-00:00:00
#SBATCH --partition=72hours
#SBATCH --qos=72hours
#SBATCH --time=3-00:00:00

OMP_NUM_THREADS=1

canteraToFoam

sed "s/@NUMSUBDOM@/96/g" \
    system/decomposeParDict_template > system/decomposeParDict
decomposePar -latestTime

#####################################################################

sed -e "s/@GRAD@/cellLimited Gauss linear 1/g" \
    -e "s/@DIVPHIU@/vanLeerV/g" -e "s/@DIVPHIZ@/vanLeer/g" \
    system/fvSchemes_template > system/fvSchemes

sed -e "s/@STARTTIME@/startTime/g" -e "s/@ENDTIME@/0.001/g" \
    -e "s/@DELTAT@/1e-7/g" -e  "s/@WRITEINTERVAL@/0.001/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g"  \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cp system/controlDict system/log1_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.01/g" \
    -e "s/@DELTAT@/1e-6/g" -e "s/@WRITEINTERVAL@/0.009/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cp system/controlDict system/log2_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.1/g" \
    -e "s/@DELTAT@/5e-6/g" -e "s/@WRITEINTERVAL@/0.09/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

sed -e "s/@GRAD@/Gauss linear/g" \
    -e "s/@DIVPHIU@/vanLeerV/g" -e "s/@DIVPHIZ@/vanLeer/g" \
    system/fvSchemes_template > system/fvSchemes

cp system/controlDict system/log3_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.3/g" \
    -e "s/@DELTAT@/5e-6/g" -e "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

#####################################################################

sed -e "s/@GRAD@/Gauss linear/g" \
    -e "s/@DIVPHIU@/SFCDV/g" -e "s/@DIVPHIZ@/linear/g" \
    system/fvSchemes_template > system/fvSchemes

cp system/controlDict system/log4_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.0/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

#####################################################################

cp system/controlDict system/log5_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.0/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel
