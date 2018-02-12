#!/bin/bash
#SBATCH --account=k1242
#SBATCH --job-name=SwBdFLT
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

module load python/3.6.2
AIRINLET="AIR1 AIR2 AIR3 AIR4"

#cd constant/boundaryData
#for folder in $AIRINLET
#do
#    cd $folder
#    cp /project/k1242/Zhen/OpenFOAM/OpenFOAM_py/SwB/inlet/inlet_time_ext.py .
#    cp /project/k1242/Zhen/OpenFOAM/OpenFOAM_py/SwB/inlet/inlet_time_jump.py .
#    cd ..
#done
#cd ../..
#
#canteraToFoam
#
#cd constant/boundaryData
#for folder in $AIRINLET
#do
#    cd $folder
#    python3 inlet_time_jump.py
#    cd ..
#done
#cd ../..
#
#sed "s/@NUMSUBDOM@/96/g" \
#    system/decomposeParDict_template > system/decomposeParDict
#decomposePar -latestTime

#####################################################################

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.1/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.2/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.3/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.4/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.5/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.6/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.7/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.8/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.9/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/3.0/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/3.1/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/3.2/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/3.3/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/3.4/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/3.5/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/3.6/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/3.7/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/3.8/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/3.9/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/4.0/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/false/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel
