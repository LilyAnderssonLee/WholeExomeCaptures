setwd("~/Desktop/PM_LL/conStruct/x_val/")
#!/usr/bin/Rscript --vanilla --default-packages=utils
args = commandArgs(trailingOnly=TRUE) ###input as variables

library(conStruct)

###cross_validation used to compare the predictive accuracy 
###between spation model (genetic differentiation changes with distance) and non-spation model
#sp<-read.table("All_x_val_sp_xval_results.txt",header = F)
sp<-read.table(args[1],header = F)
colnames(sp)<-c("rep1","rep2","rep3","rep4","rep5")

#nsp<-read.table("All_x_val_nsp_xval_results.txt",header = F)
nsp<-read.table(args[2],header = F)
colnames(nsp)<-c("rep1","rep2","rep3","rep4","rep5")

pdf(args[3],width = 6,height = 8)
plot(rowMeans(sp),
     pch=19,col="#2166ac",
     ylab="predictive accuracy",xlab="values of K",
     ylim=range(sp,nsp),
     main="cross-validation results")
points(rowMeans(nsp),col="#b2182b",pch=19)
legend("bottomright", legend=c("spatial model", "non-spatial model"),
       col=c("#2166ac", "#b2182b"), pch = 19)

dev.off()




