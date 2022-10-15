#!/bin/bash -l

#SBATCH -J      bayenv2_matrix
#SBATCH -A      XXX
#SBATCH -p      core
#SBATCH -n      5
#SBATCH -M      snowy
#SBATCH -t      10-00:00:00


ENVFILE=$1
MATFILE=$2
POPNUM=$3
ITNUM=$4
ENVNUM=$5
folder=$6


for f in split/${folder}/*
do
./bayenv2 -i $f -e $ENVFILE -m $MATFILE -k $ITNUM -r 123 -p $POPNUM -n $ENVNUM -t -c -X -o bf_out/${folder}
done
#rm -f ${fold}/*