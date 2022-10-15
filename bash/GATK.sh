####GATK SNP calling pipe for spruce exome sequences

#!/bin/bash

#SBATCH	-A	XXXX
#SBATCH	-p	core
#SBATCH	-n	1
#SBATCH	-t	5-00:00:00
#SBATCH	-J	comb_gvcf
#SBATCH	-M	snowy

module load bioinfo-tools
uppmax_gatk=/sw/apps/bioinfo/GATK/3.5.0/GenomeAnalysisTK.jar

####################################combine individula g.vcf files#################################

ref=probes_RG_0802-diploid_scaffolds.fa
##devide references into 10 intervals to save running time when deal with large data set
interval01=probes_RG_0802-diploid_scaffolds_01.intervals
interval02=probes_RG_0802-diploid_scaffolds_02.intervals
interval03=probes_RG_0802-diploid_scaffolds_03.intervals
interval04=probes_RG_0802-diploid_scaffolds_04.intervals
interval05=probes_RG_0802-diploid_scaffolds_05.intervals
interval06=probes_RG_0802-diploid_scaffolds_06.intervals
interval07=probes_RG_0802-diploid_scaffolds_07.intervals
interval08=probes_RG_0802-diploid_scaffolds_08.intervals
interval09=probes_RG_0802-diploid_scaffolds_09.intervals
interval10=probes_RG_0802-diploid_scaffolds_10.intervals

input_list=$1
output=$2

java -Xmx64G -jar $uppmax_gatk -T CombineGVCFs \
	-R $ref --variant $input_list \
	--intervals $interval01 --intervals $interval02 --intervals $interval03 --intervals $interval04 --intervals $interval05 \
	--intervals $interval06 --intervals $interval07 --intervals $interval08 --intervals $interval09 --intervals $interval10 \
	-o $output

###################################call genotypes##################################
#!/bin/bash

#SBATCH -J	genoGVCF
#SBATCH	-A	xxxxx
#SBATCH -p	core
#SBATCH -n	16
#SBATCH -t	10-00:00:00
#SBATCH -M	snowy

module load bioinfo-tools


Threads=16
JavaMem=110G
GatkJar=/sw/apps/bioinfo/GATK/3.5.0/GenomeAnalysisTK.jar
Ref=probes_RG_0802-diploid_scaffolds.fa


folder=$1 ###input forlder where stored g.vcf.gz file from combinegvcf
output=$2 
inter=$3  ###interval files: probes_RG_0802-diploid_scaffolds_01.intervals

file=${folder}/*.g.vcf

call="java -Xmx${JavaMem} -jar $GatkJar -nt $Threads -T GenotypeGVCFs -R $Ref -L $inter -maxAltAlleles 6"

for f in $file; do
    call+=" -V $f"
done


call+=" -stand_emit_conf 10.0 -stand_call_conf 20.0 -allSites -o $output " 
echo "$call "
eval $call


#############################ApplyVQSR####################################
module load bioinfo-tools
module load GATK
module load bioinfo-tools R

Ref=probes_RG_0802-diploid_scaffolds.fa
GatkJar=/sw/apps/bioinfo/GATK/3.5.0/GenomeAnalysisTK.jar
memjava=18g

input=$1   ####GenoGVCF/interval/probes_RG_0802-diploid_scaffolds_00.intervals
tranchesFile=$2
recalFile=$3
output=$4
interval=$5


java -Xmx${memjava} -jar $GatkJar \
   -T ApplyRecalibration \
   -nt 3 \
   -R $Ref \
   -L $interval \
   -input $input \
   --ts_filter_level 99.0 \
   -tranchesFile $tranchesFile \
   -recalFile $recalFile \
   -mode SNP \
   -o $output

##########################hard filtering##########################
#SBATCH -J	filter
#SBATCH	-A	XXXX
#SBATCH -p	core
#SBATCH -n	1
#SBATCH -t	3-00:00:00
#SBATCH -M	snowy

module load bioinfo-tools
module load perl/5.18.4
module load perl_modules/5.18.4
module load BioPerl/1.6.924_Perl5.18.4

filter_script=filter_AD2_MQ20_MR_80.pl

input_vcf=$1
output=$2

perl $filter_script $input_vcf $output

###################remove filtered variants################

zless $input| grep "PASS" > $output


################################annotation###################

#!/bin/bash -l

#SBATCH -J	filter
#SBATCH	-A	snic2017-7-328
#SBATCH -p	core
#SBATCH -n	1
#SBATCH -t	3-00:00:00
#SBATCH -M	snowy

module load bioinfo-tools
module load perl/5.18.4
module load perl_modules/5.18.4
module load BioPerl/1.6.924_Perl5.18.4

input_vcf=$1

perl read_gff.pl $input_vcf 

###################################merge vcf files of different intervals

#!/bin/bash

module load bioinfo-tools
module load GATK/4.1.1.0
module load picard/2.10.3

ref=probes_RG_0802-diploid_scaffolds.fa
Picard_jar=/sw/apps/bioinfo/picard/2.10.3/snowy/picard.jar

###input1 and input2 have same samples and different scaffolds.
input1=$1  
input2=$2  
output=$3

java -jar ${Picard_jar} MergeVcfs \
	R=${ref} \
	I=$input1 \
	I=$input2 \
	COMPRESSION_LEVEL=2 \
	O=$output

#######check the distribution of each mapping parameters: change Variant into table
#!/bin/bash

#SBATCH -J	VariantToTable
#SBATCH	-A	XXXXX
#SBATCH -p	core
#SBATCH -n	3
#SBATCH -t	1-00:00:00
#SBATCH -M	snowy

module load bioinfo-tools
module load GATK/3.5.0


Ref=probes_RG_0802-diploid_scaffolds.fa
uppmax_gatk=/sw/apps/bioinfo/GATK/3.5.0/GenomeAnalysisTK.jar

input=$1
output=$2

java -Xmx18g -jar $uppmax_gatk \
     -R $Ref \
     -T VariantsToTable \
     -V $input \
     --allowMissingData \
     -F CHROM -F POS -F ID -F QUAL -F QD -F MQ -F SOR -F FS -F MQRankSum -F BaseQRankSum \
     -o $output

####index vcf file
gatk_jar=/sw/bioinfo/GATK/4.1.1.0/snowy/gatk-package-4.1.1.0-local.jar

file=$1

gatk --java-options '-DGATK_STACKTRACE_ON_USER_EXCEPTION=true' IndexFeatureFile -F $file

###############################select variants########################

Ref=probes_RG_0802-diploid_scaffolds.fa
uppmax_gatk=/sw/apps/bioinfo/GATK/3.5.0/GenomeAnalysisTK.jar

file=$1 ##output of GenotypeGVCF for instance: GenoGVCF/genoGVCF1.vcf.gz
output=$2

memjava=6g  ###change as the number of cores
java -Xmx${memjava} -jar ${uppmax_gatk} -T SelectVariants \
   -R $Ref \
   -V $file \
   -nt 1 \
   -o $output \
   -env 

##############################select non-variants###################
memjava=16g
java -Xmx${memjava} -jar ${uppmax_gatk} -T SelectVariants \
   -R $Ref \
   -V $file \
   -nt 3 \
   -o $output \
   -selectType NO_VARIATION


