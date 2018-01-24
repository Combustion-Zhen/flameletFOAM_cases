#!/bin/bash
#SBATCH --account=k1164
#SBATCH --job-name=SwBd
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --ntasks-per-socket=16
#SBATCH -e job%J.err
#SBATCH -o job%J.out
#SBATCH --partition=workq
#SBATCH --time=1-00:00:00
##SBATCH --partition=72hours
##SBATCH --qos=72hours

OMP_NUM_THREADS=1

sed "s/@NUMSUBDOM@/32/g" \
    system/decomposeParDict_template > system/decomposeParDict
decomposePar

sed -e "s/@STARTTIME@/startTime/g" -e "s/@ENDTIME@/0.001/g" \
    -e "s/@DELTAT@/1e-6/g" -e  "s/@WRITEINTERVAL@/0.001/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g"  \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread pimpleFoam -parallel

cp system/controlDict system/log1_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.01/g" \
    -e "s/@DELTAT@/5e-6/g" -e "s/@WRITEINTERVAL@/0.009/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread pimpleFoam -parallel

cp system/controlDict system/log2_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.1/g" \
    -e "s/@DELTAT@/5e-6/g" -e "s/@WRITEINTERVAL@/0.01/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread pimpleFoam -parallel

cp system/controlDict system/log3_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.6/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.05/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread pimpleFoam -parallel

cp system/controlDict system/log4_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.0/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.05/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread pimpleFoam -parallel

cp system/controlDict system/log5_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.0/g" \
    -e "s/@DELTAT@/0.000005/g" -e  "s/@WRITEINTERVAL@/0.05/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread pimpleFoam -parallel

## transient data for animation
#
#cp system/controlDict system/log22_controlDict
#sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.01/g" \
#    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.0001/g" \
#    -e "s/@WRITEFORMAT@/binary/g" \
#    -e "s/@ENABLED@/true/g" \
#    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
#    system/controlDict_template > system/controlDict
#srun --hint=nomultithread pimpleFoam -parallel
