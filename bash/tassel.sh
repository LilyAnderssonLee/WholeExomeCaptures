#!/bin/bash

#SBATCH -J	tassel
#SBATCH	-A	XXXX
#SBATCH -p	node
#SBATCH -n	1
#SBATCH -t	1:00:00

input=$1
output=$2


perl /proj/XXXX/Picea_genome/tassel-5-standalone/run_pipeline.pl -Xmx30g \
-vcf $input \
-sortPositions \
-filterAlign \
-filterAlignRemMinor \
-export ${output}.hmp \
-exportType Hapmap


