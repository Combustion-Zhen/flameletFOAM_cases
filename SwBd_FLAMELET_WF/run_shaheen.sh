#!/bin/bash
#SBATCH --account=k1242
#SBATCH --job-name=SwBdFLTL4
#SBATCH --nodes=8
#SBATCH --ntasks-per-node=32
#SBATCH --ntasks=256
#SBATCH --ntasks-per-socket=16
#SBATCH --time=1-00:00:00
#SBATCH -e job%J.err
#SBATCH -o job%J.out
#SBATCH --partition=workq
##SBATCH --partition=72hours
##SBATCH --qos=72hours

OMP_NUM_THREADS=1

module load python/3.6.2
AIRINLET="AIR1 AIR2 AIR3 AIR4"

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    cp /project/k1242/Zhen/OpenFOAM/OpenFOAM_py/python3.6/process/inlet_time_ext.py .
    cd ..
done
cd ../..

canteraToFoam
sed "s/@NUMSUBDOM@/256/g" \
    system/decomposeParDict_template > system/decomposeParDict
decomposePar

sed -e "s/@STARTTIME@/startTime/g" -e "s/@ENDTIME@/0.001/g" \
    -e "s/@DELTAT@/1e-7/g" -e  "s/@WRITEINTERVAL@/0.001/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g"  \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
sed -e "s/@DIVPHIU@/Gauss vanLeer/g" \
    system/fvSchemes_template > system/fvSchemes
srun --hint=nomultithread flameletFoam -parallel

cp system/controlDict system/log1_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.01/g" \
    -e "s/@DELTAT@/1e-6/g" -e "s/@WRITEINTERVAL@/0.001/g" \
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

#cp system/controlDict system/log3_controlDict
#sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.15/g" \
#    -e "s/@DELTAT@/1e-6/g" -e  "s/@WRITEINTERVAL@/0.01/g" \
#    -e "s/@WRITEFORMAT@/binary/g" \
#    -e "s/@ENABLED@/false/g" \
#    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
#    system/controlDict_template > system/controlDict
#sed -e "s/@DIVPHIU@/Gauss linear/g" \
#    system/fvSchemes_template > system/fvSchemes
#srun --hint=nomultithread flameletFoam -parallel
#
## START TAKING AVERAGES
#
#cp system/controlDict system/log4_controlDict
#sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.20/g" \
#    -e "s/@DELTAT@/1e-6/g" -e  "s/@WRITEINTERVAL@/0.01/g" \
#    -e "s/@WRITEFORMAT@/binary/g" \
#    -e "s/@ENABLED@/true/g" \
#    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
#    system/controlDict_template > system/controlDict
#sed -e "s/@DIVPHIU@/Gauss linear/g" \
#    system/fvSchemes_template > system/fvSchemes
#srun --hint=nomultithread flameletFoam -parallel
#
#
## CONTINUE AVERAGING
#cp system/controlDict system/log5_controlDict
#sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.25/g" \
#    -e "s/@DELTAT@/1e-6/g" -e  "s/@WRITEINTERVAL@/0.01/g" \
#    -e "s/@WRITEFORMAT@/binary/g" \
#    -e "s/@ENABLED@/true/g" \
#    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
#    system/controlDict_template > system/controlDict
#sed -e "s/@DIVPHIU@/Gauss linear/g" \
#    system/fvSchemes_template > system/fvSchemes
#srun --hint=nomultithread flameletFoam -parallel
