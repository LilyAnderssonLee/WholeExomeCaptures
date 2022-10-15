setwd("~/Desktop/PM_LL/eems/output/")

if (file.exists("./rEEMSplots/")) {
  install.packages("rEEMSplots", repos=NULL, type="source")
} else {
  stop("Move to the directory that contains the rEEMSplots source to install the package.")
}

library(dplyr,warn.conflicts=FALSE)
library(rEEMSplots)
library(rworldmap)
library(rgdal)
library(rworldxtra)


eems.output = list.dirs("./PO_YEN",recursive = FALSE) ##output of different deme sizes of PO_YEN

projection_none <- "+proj=longlat +datum=WGS84"
projection_mercator <- "+proj=merc +datum=WGS84"

##plot migration surface for each deme size separately
for (run in c(1:length(eems.output))) {
  eems.plots(mcmcpath = eems.output[run],
             plotpath = plot/eems.output[run],
             plot.width=8,
             plot.height=5,
             longlat = T,
             add.grid = F,
             add.demes = T,
             projection.in = projection_none,
             projection.out = projection_mercator,
             out.png=FALSE,
             min.cex.demes = 1,
             max.cex.demes = 2,
             col.demes = "#525252",
             pch.demes = 16,
             add.r.squared=F,
             add.abline = T,
             remove.singletons = T,
             add.map = T,
             col.map="black",
             lwd.map=0.2,
             add.title = F)
}

###combine migration surface over differeent deme size
combined.mcmcpath = eems.output
combined.plotpath ="./combine_demes_plot/deme30_50_80_100_NFE"

eems.plots(mcmcpath = combined.mcmcpath,
           plotpath = combined.plotpath,
           plot.width=8,
           plot.height=5,
           longlat = T,
           add.grid = F,
           add.demes = T,
           projection.in = projection_none,
           projection.out = projection_mercator,
           out.png=FALSE,
           min.cex.demes = 1,
           max.cex.demes = 2,
           col.demes = "#525252",
           pch.demes = 16,
           add.r.squared=F,
           add.abline = T,
           remove.singletons = T,
           add.map = T,
           col.map="black",
           lwd.map=0.2,
           add.title = F
)
