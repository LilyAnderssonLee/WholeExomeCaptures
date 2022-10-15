#!/bin/bash

#SBATCH -J	subset
#SBATCH	-A	XXXXX
#SBATCH -p	core
#SBATCH -n	1
#SBATCH -t	5-00:00:00
#SBATCH -M	snowy

module load bioinfo-tools
module load vcftools/0.1.15

#############################SNPs filtering in VCFtools#################################
##filter SNPs by minor allele frequency
input=$1
output=$2
vcftools --vcf $input --maf 0.1 --recode --recode-INFO-all --out $output

##filter samples by missing genoytpes
input_vcf=$1
out_missing=$2
vcftools --vcf $input_vcf --missing-indv --out $out_missing

##filter SNPs by missing genotyoes across samples
vcftools --vcf $input_vcf --missing-site --out $out_missing

##filter singletons
#1:
vcftools --vcf $input --singletons
#2:
vcftools --vcf $input --exclude-positions $singletons --recode --recode-INFO-all --out $output

##filter multiple allelic sites:
vcftools --vcf $input --max-alleles 2 --recode --recode-INFO-all --out $2


##########################subset samples from vcf files##############################
input=$1
keep=$2
output=$3
vcftools --gzvcf $input --keep $keep --recode --recode-INFO-all --stdout | bgzip > $output
vcftools --vcf $input --remove $keep --recode --recode-INFO-all --out $output
######allele frequency
input=$1
output=$2
vcftools --gzvcf $input --freq --out $output
######genotypes
vcftools --vcf $input --extract-FORMAT-info GT --out $output



