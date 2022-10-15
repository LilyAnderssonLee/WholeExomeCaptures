#!/bin/bash

#SBATCH	-A	XXXX
#SBATCH	-p	core
#SBATCH	-n	3
#SBATCH	-t	100:00:00
#SBATCH	-J	compress


module load bioinfo-tools
module load tabix/0.2.6

#for f in *.vcf;
#do 
#	bgzip ${f} && tabix -p vcf ${f}.gz;
#done

input=$1
bgzip ${input} && tabix -p vcf ${input}.gz
