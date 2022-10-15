#!/bin/bash

#SBATCH -A      snic2017-7-328
#SBATCH -p      core
#SBATCH -n      1
#SBATCH -t      1:00:00
#SBATCH -J      UMAP
#SBATCH -M  snowy

input=$1
N_pc=$2 ##pc5, pc10
neighbour=$3 ###5,10,15
min_GD=$4 ###0.001,0.01,0.1
N_dimension=$5 ###2,3

python general_umap_script.py \\
-dset $input \\
-pc $N_pc \\
-nn $neighbour \\
-md $min_GD \\
-nc N_dimension \\
-outdir ../../output \\
-head F \\
-log ../../log/