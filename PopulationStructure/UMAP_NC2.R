setwd("~/Desktop/PM_LL/UMPA/project/")
library(gtools)
library(ggplot2)
library(randomcoloR)

df<-read.table("all_PC5s_UMAP_PC5_NC2_NN5_MD0.1_euclidean_20200618_121825.txt",header = F)

pca<-read.table("../../PCA/Cline_russ_merged_formass_raw_variant_RG0802_diploid_scaffolds_whole_contigs_VarRecalibrate_PASS_and_filtered_biallelic_ind_84_neutral_woSingletons_unlinked05_rmOutliers_rmNonVar_All.ind")
df$Well<-pca$V1

smp<-read.table("../../sample_info/sample_info.txt",header = T)

merg_df<-merge(df,smp,by="Well")

merg_df<-merg_df[order(merg_df$cline,merg_df$Lat),]

library(plyr)
##random sample one individual from each population
rand_df<-ddply(merg_df,.(Source),function(x)x[sample(nrow(x),1),])


###plot
df_pch=c(1,15,3,4,17)
cline_col=c("#cb181d","#7fcdbb","#fdcc8a","#6a51a3","#3182bd")

pdf("../Plot/PC5_NC2_NN5_MD01/2DUMAP.pdf",width = 8,height = 6)
p<-ggplot(merg_df,aes(V1,V2,shape=cline,colour=cline))+
  geom_point(size=1)+labs(x="",y="")+
  scale_shape_manual(values=c(1,15,3,4,17))+
  scale_colour_manual(values = cline_col)+
  ggtitle("PC5_NC2_NN5_MD0.1")+
  theme(plot.title = element_text(lineheight=.8, face="bold",hjust = 0.5),
        panel.background = element_rect(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
p<-p+geom_text(data = rand_df,aes(x=V1,y=V2,label=Source),size=2,hjust=-0.5)

print(p)
dev.off()


