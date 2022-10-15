setwd("~/Desktop/Fst_outliers")
#!/usr/bin/env Rscript --vanilla --default-packages=utils
args = commandArgs(trailingOnly=TRUE)
df=read.table(args[1],header = T) ###bayeScan fst output
snp<-read.table(args[2],header = F) ###snp_list
df$Chrom<-snp$V1
df$pos<-snp$V2

###outliers
FDR1=0.05
FDR2=0.001

outliers1<-df[which(log10(df$qval)<log10(FDR1)),]
outliers2<-df[which(log10(df$qval)<log10(FDR2)),]

write.table(outliers1,args[3],row.names = F,col.names = T,sep = "\t")
write.table(outliers2,args[4],row.names = F,col.names = T,sep = "\t")

##plot
pdf(args[5],width = 6,height = 8)
##xlim
plot(log10(df$qval),df$fst,xlab="log10(q value)",ylab=expression(italic('F'['ST'])))
lines(c(log10(FDR1),log10(FDR1)),c(-1,1),lwd=2,lty=2,col="red")
lines(c(log10(FDR2),log10(FDR2)),c(-1,1),lwd=2,lty=2,col="red")
text(x=log10(FDR1),y=0.11,labels = "FDR=0.05")
text(x=log10(FDR2),y=0.11,labels = "FDR=0.001")
dev.off()





df<-read.table("CSE_bayeScan_input_fst.txt",header = T)
###load snp list
snp<-read.table("CSE_snp_list.txt",header = F)
df$Chrom<-snp$V1
df$pos<-snp$V2

###outliers
FDR1=0.05
FDR2=0.001
outliers1<-df[which(log10(df$qval)<log10(FDR1)),]
outliers2<-df[which(log10(df$qval)<log10(FDR2)),]

write.table(outliers1,"CSE_prior1000_FDR05.txt",row.names = F,col.names = T,sep = "\t")
write.table(outliers2,"CSE_prior1000_FDR001.txt",row.names = F,col.names = T,sep = "\t")
##plot
pdf("CSE_prior1000.pdf")
##xlim
plot(log10(df$qval),df$fst,xlab="log10(q value)",ylab=expression(italic('F'['ST'])))
lines(c(log10(FDR1),log10(FDR1)),c(-1,1),lwd=2,lty=2,col="red")
lines(c(log10(FDR2),log10(FDR2)),c(-1,1),lwd=2,lty=2,col="red")
text(x=log10(FDR1),y=0.11,labels = "FDR=0.05")
text(x=log10(FDR2),y=0.11,labels = "FDR=0.001")
dev.off()










