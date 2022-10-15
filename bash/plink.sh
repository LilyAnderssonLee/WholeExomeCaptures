#!/bin/bash

#SBATCH	-A	XXXXXX
#SBATCH	-p	core
#SBATCH	-n	1
#SBATCH	-t	20:00:00
#SBATCH	-J	bed
#SBATCH -M  snowy

module load bioinfo-tools
module load plink/1.90b4.9
module load eems/20160605


###############format changes#################
input_vcf=$1
output=$2

###vcf into bed file: --allow-extra-chr: work for exome sequences
plink --vcf $input_vcf --no-parents --no-sex --no-pheno --const-fid 0 --allow-extra-chr --make-bed --out $output

###vcf into ped file: 
rm_indiv=$3 ###remove some samples
plink --noweb --const-fid 0 --allow-extra-chr --vcf $input --remove $rm_indiv --recode --out $output

###bed into ped files
plink --bfile $input --no-parents --no-sex --no-pheno --const-fid 0 --allow-extra-chr --recode --tab --out $output

###estimate  Linkage disequlibrium (LD):
plink --noweb --const-fid 0 --vcf $input --no-sex --recode --allow-extra-chr --r2 --ld-window-kb 5 --ld-window 100 --ld-window-r2 0 --out $output




