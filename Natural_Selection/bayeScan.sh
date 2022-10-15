#!/bin/bash -l

#SBATCH -A xxx
#SBATCH -p core
#SBATCH -n 16
#SBATCH -J outliers
#SBATCH -t 9-13:00:00
#SBATCH -M snowy

#directory
cd /XXX/lili_6000/new_version_corrected/Fst_outliers/BayeScan/BayeScan2.1/source

#BayScan to identify outliers
input=$1
pr_odds=$2 ### 100, 500, 1000
output_folder=$3

./bayescan_2.1 $input -threads 16 -n 5000 -thin 10 -nbp 20 -pilot 5000 -burn 50000 -pr_odds $pr_odds -od $output_folder