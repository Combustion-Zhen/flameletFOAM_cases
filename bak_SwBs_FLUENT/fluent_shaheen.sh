#!/bin/bash
#SBATCH --account=k1242
#SBATCH -N 1
#SBATCH -t 1-00:00:00
#SBATCH -J SwBsL3WALE
#SBATCH -e job%J.err
#SBATCH -o job%J.out
#SBATCH --partition=workq

module load ansys/v170
export FLUENT_ENABLE_SLURM_SUPPORT=1

cd /scratch/luz0a/SwB/SwBs_L-300360R100180_16M_FLUENT_WALE

ln -s /opt/cray/mpt/7.2.4/gni/mpich2-cray/8.3/lib/libmpich.so libmpich.so.1

fluent -t32 3ddp -mpi=cray -g -nmon -i SwBs_L-300_WALE.jou
exit
OK
EOF
