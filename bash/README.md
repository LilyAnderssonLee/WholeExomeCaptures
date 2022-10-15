This folder includes bash commands to prepare the SNPs file from Whole exome captures.

# GATK.sh

**The GATK software was used to perform the following steps:**

## Combine individual g.vcf file together

## Call genotypes

## ApplyVQSR

Apply a score cutoff to filter variants based on a re-calibration table.

## Hard filtering

Filter SNPs failed to pass the threshold.

## Remove filtered variants

## Annotation

## Merge vcf files of different intervals

## Check the distribution of each mapping parameters: change Variant into table

## Index vcf file

## Select non-variants

# vcf.sh

**The vcf tools was used to perform the following steps:**

## SNPs filtering

## Subset samples from vcf files

# plink.sh 

**The PLINK tool was used to convert different formats of SNPs.**

## VCF to BED

## VCF to PED

## BED to PED

## Estimate Linkage disequilibrium (LD)

# compress_index_vcf.sh

**Compress and index vcf files**

# tassel.sh

**Prepare Hapmap file by vcf file**
