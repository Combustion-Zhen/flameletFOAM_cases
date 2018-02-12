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

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    cp /project/k1242/Zhen/OpenFOAM/OpenFOAM_py/SwB/inlet/inlet_time_ext.py .
    cd ..
done
cd ../..

canteraToFoam

sed "s/@NUMSUBDOM@/96/g" \
    system/decomposeParDict_template > system/decomposeParDict
decomposePar -latestTime

#####################################################################

sed -e "s/@TIMESCHEME@/Euler/g" \
    -e "s/@GRAD@/leastSquares/g" -e "s/@DIVPHIU@/vanLeerV/g" \
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

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

cp system/controlDict system/log3_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.2/g" \
    -e "s/@DELTAT@/5e-6/g" -e "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
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

cp system/controlDict system/log4_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.3/g" \
    -e "s/@DELTAT@/5e-6/g" -e "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/true/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel

####################################################################

sed -e "s/@TIMESCHEME@/Euler/g" \
    -e "s/@GRAD@/Gauss linear/g" -e "s/@DIVPHIU@/LUST grad(U)/g" \
    system/fvSchemes_template > system/fvSchemes

cd constant/boundaryData
for folder in $AIRINLET
do
    cd $folder
    python3 inlet_time_ext.py
    cd ..
done
cd ../..

cp system/controlDict system/log5_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.4/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/false/g" \
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

cp system/controlDict system/log6_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.5/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log7_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.6/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log8_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.7/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log9_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.8/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log10_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/0.9/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log11_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.0/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log12_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.1/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log13_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.2/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log14_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.3/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log15_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.4/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log16_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.5/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log17_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.6/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log18_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.7/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log19_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.8/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log20_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/1.9/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
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

cp system/controlDict system/log21_controlDict
sed -e "s/@STARTTIME@/latestTime/g" -e "s/@ENDTIME@/2.0/g" \
    -e "s/@DELTAT@/5e-6/g" -e  "s/@WRITEINTERVAL@/0.1/g" \
    -e "s/@WRITEFORMAT@/binary/g" \
    -e "s/@ENABLED@/true/g" \
    -e "s/@RESTART@/true/g" -e "s/@RESTARTOUT@/false/g" \
    system/controlDict_template > system/controlDict
srun --hint=nomultithread flameletFoam -parallel
