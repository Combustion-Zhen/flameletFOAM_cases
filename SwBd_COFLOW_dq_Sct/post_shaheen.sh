#!/bin/bash
#SBATCH -A k1242
#SBATCH -J SwBdpost
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -e post.err
#SBATCH -o post.out
#SBATCH -p workq
#SBATCH -t 02:00:00

reconstructPar -time '1.12:1.56'

