#!/usr/bin/Rscript --vanilla --default-packages=utils
args = commandArgs(trailingOnly=TRUE) ###input as variables

library(conStruct)
library(fields)
library(rdist)

allele_frequency<-as.matrix(read.table(args[1],header = F)) ###args[1]: populations allele frequency file
coord<-read.table(args[2],header = T) ###args[2]: pops coordinates 
coord<-as.matrix(coord[,c(2,3)]) ###select longitude and latitude columns
geoDist<-rdist.earth(coord,coord,miles = F)

conStruct_list<-list(allele_frequency,coord,geoDist)

names(conStruct_list)<-c("allele.frequencies","coords","geoDist")

my.xvals <- x.validation(train.prop = 0.9,
                         n.reps = 5, ###basically 5-fold us is enough to cross validate.  
                         K = 2,
                         freqs = conStruct_list$allele.frequencies,
                         data.partitions = NULL,
                         geoDist = conStruct_list$geoDist,
                         coords = conStruct_list$coords,
                         prefix = args[3],
                         n.iter = 1e6,
                         save.files = TRUE,
                         parallel = TRUE,
                         control=list(adapt_delta=0.95,max_treedepth = 15),
                         n.nodes = 2 ###the number of cores, bigger is better, but it won't help if more than 6 cores in my case
                         )
###suggestions for big genome sequences, for instance spruce exome captures
###1:set n.reps=1, run five times.
###2:run each K separately

