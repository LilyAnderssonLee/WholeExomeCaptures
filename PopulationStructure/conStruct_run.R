#!/usr/bin/Rscript --vanilla --default-packages=utils
args = commandArgs(trailingOnly=TRUE) ###input as variables

library(conStruct)
library(fields)
library(rdist)

allele_frequency<-as.matrix(read.table(args[1],header = F)) ###args[1]: populaton allele frequency 
coord<-read.table(args[2],header = T) ###args[2]: population coordinates
coord<-as.matrix(coord[,c(2,3)])  ###subset Longitude and Latitude columns
geoDist<-rdist.earth(coord,coord,miles = F) ##distance between each pair of populations

conStruct_list<-list(allele_frequency,coord,geoDist)

names(conStruct_list)<-c("allele.frequencies","coords","geoDist")

my.run <- conStruct(spatial = TRUE,
                    K = 2, ###the number of layers
                    freqs = conStruct_list$allele.frequencies,
                    geoDist =conStruct_list$geoDist,
                    coords = conStruct_list$coords,
                    prefix = args[3], ##prefic of output names
                    n.chains = 1,
                    n.iter = 1e6, 
                    save.files=T,
                    make.figs=F
                    control=list(adapt_delta=0.95,max_treedepth = 15) ##adjust these two values based on warning message of the output
                    )
