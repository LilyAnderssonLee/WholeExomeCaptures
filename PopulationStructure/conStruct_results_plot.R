#!/usr/bin/Rscript --vanilla --default-packages=utils
args = commandArgs(trailingOnly=TRUE) ###input as variables

#library(sp)
library(maptools)
gpclibPermit()
library(maps)
library(ggplot2)
library(conStruct)
require(rworldmap)


#load("../output/results/Pa_k2_conStruct.results.Robj")
#load("../output/results/Pa_k2_data.block.Robj")
load(args[1]) 
load(args[2])

cons=conStruct.results
db=data.block

#plot
#pdf(width = 8,height = 6,file = "Pa_PiePlot_k2.pdf")
pdf(width = 8,height = 6,file = args[3])

map("world",col="white",fill=T,xlim=c(5,100),ylim=c(40,70))
make.admix.pie.plot(cons$chain_1$MAP$admix.proportions, db$coords, 
                    layer.colors = c("#b2182b","#2166ac"),
                    radii = 1.5, add = T, x.lim = NULL, y.lim = NULL)
text(Lat~Long,labels=as.factor(Source)) ###lable pie plot with names of population on the map
map.axes()
dev.off()

##order populations
coord<-as.data.frame(db$coords)
##load the population inforamtion which have same as order as allele frequency file used in conStruct run
pop<-read.table(args[4],header = T) 
rownames(coord)<-pop$Source

pdf(width = 8,height = 6,file = args[5])
barplot(t(cons$chain_1$MAP$admix.proportions),
        col=c("#b2182b","#2166ac"),
        space = 0, xlab = "Populations",
        ylab="Admixture proportions",
        font.lab=2,names=rownames(coord),
        xaxs = "i")
title(main = "K = 2",font.main=4)
dev.off()


