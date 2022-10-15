library(ggplot2)
library(UsingR)
library(dplyr)
library(RColorBrewer)

setwd("~/Desktop/PM_LL/output/PA")

q <- read.table("Cline_russ_merged_formass_raw_variant_RG0802_diploid_scaffolds_whole_contigs_VarRecalibrate_PASS_and_filtered_biallelic_ind_84_neutral_noSingletons_unlinked05.PA.7.Q")
id<-read.table("../../sample_info/Cline_russ_merged_formass_raw_variant_RG0802_diploid_scaffolds_whole_contigs_VarRecalibrate_PASS_and_filtered_biallelic_ind_84_neutral_noSingletons_unlinked05.PA.fam")
q$ID<-id$V2
colnames(q)<-c("cluster1","cluster2","cluster3","cluster4","cluster5","cluster6","cluster7","Well")
##load sample information
smp<-read.table("../../sample_info/sample_info.txt",header = T,sep="\t")
smp$cline<-as.character(smp$cline)
smp$Source<-as.character(smp$Source)
smp[which(smp$Source=="VYA"),7]<-smp[which(smp$Source=="VYA"),3]
smp[which(smp$Source=="Indigo"),7]<-smp[which(smp$Source=="Indigo"),3]
###subset
df<-merge(q,smp,by="Well")
df7<-df[order(df$Lat,decreasing = F),]

###plot
#pdf("PA_K7.pdf",width=8,height=6)
my_bar=barplot(t(as.matrix(df7[,c(8,3,6,5,2,7,4)])),col=c("#b2df8a","#1f78b4","#fc8d59","#ffeda0","#31a354","#fa9fb5","#bdbdbd"),space = 0,
               border = NA,xlab = "Populations",ylab="Admixture proportions",
               axisnames = F,main = "K = 7",xaxs = "i",font.lab=2,font.main=4)
mean_pos<-tapply(1:nrow(df7),df7[,10],mean)
mean_pos<-mean_pos[order(mean_pos)]
xtick<-cumsum(sapply(unique(df7[,10]),function(x){sum(df7[,10]==x)}))
axis(side=1, at=xtick, labels = FALSE)
text(mean_pos,-0.05,names(mean_pos),xpd=T,srt=300,cex=0.8,font=2)
box(lwd=1.5)

#dev.off()


