#!/bin/bash

#SBATCH -A XXXX
#SBATCH -p core -n 3
#SBATCH -t 10-00:00:00
#SBATCH -J admixture
#SBATCH -M snowy

module load bioinfo-tools
module load ADMIXTURE/1.3.0

input=$1 ##bed file
K=$2


admixture --cv=10 -B -s time -j3 $input $K | tee SSF_5385_bootstrap_log${K}.out

###j3: three cores