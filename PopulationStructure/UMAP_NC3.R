setwd("~/Desktop/PM_LL/UMPA/project/")
library(gtools)
library(ggplot2)
library(randomcoloR)

df<-read.table("all_PC5s_UMAP_PC5_NC3_NN10_MD0.1_euclidean_20200611_152221.txt",header = F)

pca<-read.table("../../PCA/Cline_russ_merged_formass_raw_variant_RG0802_diploid_scaffolds_whole_contigs_VarRecalibrate_PASS_and_filtered_biallelic_ind_84_neutral_woSingletons_unlinked05_rmOutliers_rmNonVar_All.ind")
df$Well<-pca$V1

smp<-read.table("../../sample_info/sample_info.txt",header = T)

merg_df<-merge(df,smp,by="Well")

merg_df<-merg_df[order(merg_df$cline,merg_df$Lat),]

#merg_df<-merg_df[which(merg_df$Source!="BER"),]
#merg_df$Source<-factor(merg_df$Source,levels = as.character(unique(merg_df$Source)))

df1<-merg_df
V1<-(df1$V1-min(df1$V1))/(max(df1$V1)-min(df1$V1))
V2<-(df1$V2-min(df1$V2))/(max(df1$V2)-min(df1$V2))
V3<-(df1$V3-min(df1$V3))/(max(df1$V3)-min(df1$V3))

color<-rgb(V1,V2,V3)

merg_df$color=color
merg_df<-merg_df[order(merg_df$V3),]
library(plyr)
##random sample one individual from each population
rand_df<-ddply(merg_df,.(Source),function(x)x[sample(nrow(x),1),])

###3D UMAP coordinates as colors

p<-ggplot(df1,aes(x=Long,y=Lat,shape=cline))+
  geom_point(colour=color,size=2)+
  #scale_shape_manual(values=c(5,1,3,4,6))+
  scale_shape_manual(values=c(1,15,3,4,17))+
  ggtitle("PC5_NC3_NN10_MD0.1")+
  theme(plot.title = element_text(hjust = 0.5))+
  geom_text(data = rand_df,aes(x=Long,y=Lat,label=Source),size=1.5,hjust=-0.5)


x1<-1:406
y1<-rep(1,406)
z<-as.data.frame(cbind(x1,y1))

c<-ggplot(z,aes(x=x1,y=y1),fill=factor(x1))+
  geom_bar(width=1,color=color,stat = "identity",position=position_dodge())+
  scale_fill_manual(values=color)+theme_minimal()+
  theme(axis.title=element_blank(),
        axis.text.x =element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank())
  #geom_vline(xintercept=c(181,200,336,356),col=1,lwd=1.5)+
  #scale_x_discrete(limits=c('1',"181", "200","336","356","406"))
  
library(grid)
pdf("../Plot/PC5_NC3_NN10_MD01/3DUMAP_coordinated_color.pdf",width = 6,height = 8)
pushViewport(viewport(layout = grid.layout(6, 1)))
vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
print(p, vp = vplayout(1:5, 1))
print(c, vp = vplayout(6, 1))

dev.off()

###scatter3D
library(plot3D)
#library(scatterplot3d)
#library(rgl)
df_pch=c(1,15,3,4,17)
cline_col=c("#cb181d","#7fcdbb","#fdcc8a","#6a51a3","#3182bd")

pdf("../Plot/PC5_NC3_NN10_MD01/scatter3D_PC5_NC3_NN10_MD0.1.pdf",width = 8,height = 6)
scatter3D(merg_df$V1,merg_df$V2,merg_df$V3,
          colvar = as.integer(merg_df$cline),cex=0.5,
          col =c("#cb181d","#7fcdbb","#fdcc8a","#6a51a3","#3182bd"),
          bty="g",pch=df_pch[as.numeric(merg_df$cline)],
          #phi=40,theta = 40,pch=df_pch,cex=0.5,d=2,pch=df_pch[as.factor(merg_df$cline)],
          colkey = list(at=c(1,2,3,4,5),
                        length = 0.5, width = 0.8, cex.clab = 0.75,
                        labels=c("PA","Indigo","OUR","VYA","YEN")),
          main="PC5_NC3_NN10_MD0.1")

legend(legend = c("PA","Indigo","OUR","VYA","YEN"),pch=c(1,15,3,4,17),x=0.4,y=0,cex = 0.8,
      col = c("#cb181d","#7fcdbb","#fdcc8a","#6a51a3","#3182bd"))
with(rand_df,text3D(V1,V2,V3,labels=as.factor(Source),add=T,cex=0.4,plot = T))

dev.off()






