#! /usr/bin/Rscript --vanilla --default-packages=utils

#setwd("~/Desktop/exome_6000/ld")
#install.packages("devtools")
#install_github("tpbilton/GUSbase")
#install_github("AgResearch/GUS-LD")

library(devtools)
library(GUSbase)
library(GUSLD)

#convert VCF file to an RA file
rafile <- VCFtoRA(infilename="/proj/uppstore2017148/b2015284_nobackup/private/lili_6000/SNP/AD_2_MQ_50_MR_75_noncoding_SNP.vcf.gz", 
                  direct = "./")

write.table(rafile,file = "rafile.txt",sep = "\t")

##load RA file to the R
remove_id<-c("UME_081104_P41_WE10","UME_081104_P43_WB12","UME_081104_P53_WA01","UME_081104_P53_WD10",
             "UME_081104_P53_WH10","UME_081104_P65_WF02","UME_081104_P88_WA06","UME_081104_P88_WF10","UME_081104_P90_WD05",
             "UME_081104_P92_WH06")  ##missing genotypes more than 90%

RAdata <- readRA(rafile = "AD_2_MQ_50_MR_75_noncoding_SNP.vcf.gz.ra.tab", excsamp = remove_id) ###excsamp:Specifies IDs of any samples in the RA data set to be discarded
#RAdata <- readRA(rafile = "test.vcf.gz.ra.tab", excsamp = remove_id)

##Creating an Unrelated Population

urpop <- makeUR(RAobj = RAdata, filter = list(MAF = 0,MISS = 0.75,
                                              HW = c(-0.05, Inf),MAXDEPTH = 1000000), nThreads = 10)
##LD
#LDres <- GUSLD(urpop, filename="AD_2_MQ_50_MR_75_SNP_noncodeing_LD.txt", dp = 4)

LDres <- GUSLD(URobj = urpop, nClust = 10,dp=4)
write.table(LDres,"AD_2_MQ_50_MR_75_SNP_noncodeing_LD_3.txt",row.names = F,col.names = T,sep = "\t")
#write.table(LDres,"test_ld_0710.txt",row.names = F,col.names = T,sep = "\t")

rm<-LDres[which(LDres$r2>0.2),]
snp1<-paste(rm$CHROM_SNP1,rm$POS_SNP1,sep="-")
snp2<-paste(rm$CHROM_SNP2,rm$POS_SNP2,sep="-")

ld_sites<-unique(snp1,snp2)
split<-unlist(strsplit(ld_sites,"-"))

chrom<-split[c(TRUE,FALSE)]
pos<-split[c(FALSE,TRUE)]

LD_ID<-as.data.frame(cbind(chrom,pos),stringsAsFactors=FALSE)

write.table(LD_ID,"AD_2_MQ_50_MR_75_noncoding_LD_ID_3.txt",row.names = F,col.names = F,sep = "\t")
#write.table(LD_ID,"test_LD_ID.txt",row.names = F,col.names = F,sep = "\t")












