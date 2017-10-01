#!/bin/bash
#SBATCH --account=k1242
#SBATCH --nodes=8
#SBATCH --ntasks-per-node=32
#SBATCH --ntasks-per-socket=16
#SBATCH --partition=workq
#SBATCH -t 1-00:00:00
#SBATCH -J SwBsL3WALEPDF
#SBATCH -e job%J.err
#SBATCH -o job%J.out

module load ansys/v170
export FLUENT_ENABLE_SLURM_SUPPORT=1

rm libmpich.so.1
ln -s /opt/cray/mpt/7.2.4/gni/mpich2-cray/8.3/lib/libmpich.so libmpich.so.1

fluent -t256 3ddp -mpi=cray -g -nmon -i SwBs_L-300_WALE_PDF.jou
exit
OK
EOF
