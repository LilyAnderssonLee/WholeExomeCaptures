setwd("~/Desktop/XXX/eems-master/second_version/")
if (file.exists("./rEEMSplots/")) {
  install.packages("rEEMSplots", repos=NULL, type="source")
} else {
  stop("Move to the directory that contains the rEEMSplots source to install the package.")
}

library(rEEMSplots)
library(rworldmap)
library(rgdal)
library(rworldxtra)

#name_figures <- file.path(path.expand("~"), "plot_lilili55")

#####
projection_none <- "+proj=longlat +datum=WGS84"
projection_mercator <- "+proj=merc +datum=WGS84"


eems.plots(mcmcpath = "eems-master/genotype1_10_samples_MT58_CSE_NFE/deme150/chain1/",
           plotpath = "eems-master/genotype1_10_samples_MT58_CSE_NFE/genotype1_10_samples_MT58_CSE_NFE_deme150",
           longlat = T,
           add.grid = T,
           col.grid = "gray90",
           add.outline = F,
           col.outline = "black",
           add.demes = T,
           projection.in = projection_none,
           projection.out = projection_mercator,
           out.png=FALSE,
           min.cex.demes = 0.5,
           max.cex.demes = 1.5,
           col.demes = "blue",
           pch.demes = 5,
           add.r.squared=T,
           add.abline = T,
           remove.singletons = T,
           add.map = T,
           col.map="gray",
           add.title = F
           )

####MCMC unconverged

###can't tell MCMC converged or not. so increase MCMC to 10 million and run three times with different seds
projection_none <- "+proj=longlat +datum=WGS84"
projection_mercator <- "+proj=merc +datum=WGS84"

eems.plots(mcmcpath = "eems-master/plotting/genotype1-10_deme500_MCMC2000000_BurnIn500000_numThinIter4999_chain1",
           plotpath = "eems-master/plotting/deme150_10M",
           longlat = F,
           projection.in = projection_none,
           projection.out = projection_mercator,
           add.demes = T,
           out.png=FALSE,
           min.cex.demes = 0.5,
           max.cex.demes = 1.5,
           add.grid = T,
           add.outline = T,
           lwd.outline = 0.5,
           col.outline = "red",
           add.map = T,
           col.map = "black",
           lwd.map = 0.5,
           )


map_world<-getMap()
map_northernEuro<-map_world[which(map_world@data$ADMIN=="Sweden"| map_world@data$ADMIN=="Finland" |
                                    map_world@data$ADMIN=="Norway" |map_world@data$ADMIN=="Denmark"),]

eems.plots(mcmcpath = "EEMS/genotype1-10/MCMC/deme500/SSF_Plustree_genotype1-10_deme500_MCMC2000000_BurnIn1000000_numThinIter9999_chain1",
           plotpath = "EEMS/genotype1-10/MCMC/deme500/plot/",
           longlat = T,
           m.plot.xy = {plot(map_northernEuro,col=NA,add=T)},
           q.plot.xy = {plot(map_northernEuro,col=NA,add=T)}
)

map_northernEuro<-spTransform(map_northernEuro,CRSobj = CRS(projection_mercator))

eems.plots(mcmcpath = "EEMS/genotype1-10/MCMC/deme500/SSF_Plustree_genotype1-10_deme500_MCMC2000000_BurnIn1000000_numThinIter9999_chain1",
           plotpath = "EEMS/genotype1-10/MCMC/deme500/plot/",
           longlat = T,
           m.plot.xy = {plot(map_northernEuro,col=NA,add=T)},
           q.plot.xy = {plot(map_northernEuro,col=NA,add=T)},
           projection.in = projection_none,
           projection.out = projection_mercator,
           min.cex.demes = 0.5,
           max.cex.demes = 1.5
)

library(deldir)
eems.voronoi.samples(mcmcpath = "EEMS/genotype1-10/MCMC/deme500/SSF_Plustree_genotype1-10_deme500_MCMC2000000_BurnIn1000000_numThinIter9999_chain1",
                     plotpath = "EEMS/genotype1-10/MCMC/deme500/plot/",
                     longlat = TRUE,
                     post.draws = 10)