setwd("~/Desktop/LL/conStruct")
#! /usr/bin/Rscript --vanilla --default-packages=utils
args = commandArgs(trailingOnly=TRUE) ###input as variables
install.packages('gtools',repos='http://cran.us.r-project.org')
require('gtools')
##load genotypes 
#AF<-read.table("Cline_russ_merged_formass_raw_variant_RG0802_diploid_scaffolds_whole_contigs_VarRecalibrate_PASS_and_filtered_biallelic_ind_84_neutral_noSingletons_unlinked05_rmOutliers_rmNonVar_PA.GT.FORMAT_test",header = T)
AF<-read.table(args[1],header = T) ##AF: genotypes extracted by vcftools 
AF<-AF[,3:dim(AF)[2]]
T_AF<-as.data.frame(t(AF))
T_AF$Well<-rownames(T_AF)

###sample information
smp<-read.table("../sample_info/sample_info.txt",
                header = T,sep = "\t")
smp<-smp[(-43),]
pop<-smp[,c(1,3)]

####merge pops information and genotypes
merged<-merge(pop,T_AF,by="Well")

Mean_AF<-aggregate(merged[, 3:dim(merged)[2]], by=list(merged$Source), FUN = mean, na.rm=T,na.action="na.pass")
Mean_AF<-Mean_AF[mixedorder(as.character(Mean_AF$Group.1)),]

smp_coord<-smp[,3:5]
pop_coord<-unique(smp_coord)
colnames(Mean_AF)[1]<-"Source"
coord<-merge(Mean_AF,pop_coord,by="Source")
coord<-coord[,c(1,202,201)]
#write.table(coord,"PA_pop_coord.txt",row.names = F,col.names = T,sep = "\t")
write.table(coord,args[2],row.names = F,col.names = T,sep = "\t")

