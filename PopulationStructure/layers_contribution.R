setwd("~/Desktop/PM_LL/conStruct/output")

##layers.contribution used to decide the 'best' number of layers 
layer.contributions <- matrix(NA,nrow=7,ncol=7) ###

load("Pa_k1_conStruct.results.Robj")
load("Pa_k1_data.block.Robj")

# calculate layer contributions
layer.contributions[,1] <- c(calculate.layer.contribution(conStruct.results[[1]],data.block),rep(0,6))
tmp <- conStruct.results[[1]]$MAP$admix.proportions

for(i in 2:7){ ##k=c(1,2,3,4,5,6,7)
  # load the conStruct.results.Robj and data.block.Robj
  #	files saved at the end of a conStruct run
  load(sprintf("Pa_k%s_conStruct.results.Robj",i)) ##pass the variables in the string
  load(sprintf("Pa_k%s_data.block.Robj",i))
  
  # match layers up across runs to keep plotting colors consistent
  #	for the same layers in different runs
  tmp.order <- match.layers.x.runs(tmp,conStruct.results[[1]]$MAP$admix.proportions)
  
  # calculate layer contributions
  layer.contributions[,i] <- c(calculate.layer.contribution(conStruct.results=conStruct.results[[1]],
                                                            data.block=data.block,
                                                            layer.order=tmp.order),
                               rep(0,7-i))
  tmp <- conStruct.results[[1]]$MAP$admix.proportions[,tmp.order]
}

row.names(layer.contributions) <- paste0("Layer_",1:7)
knitr::kable(layer.contributions,row.names=TRUE,col.names=paste0("K=",1:7),
             caption="the layer contribution from K=1 to K=7")

barplot(layer.contributions,
        col=c("#b2182b","#2166ac","#ef8a62",
              "#fddbc7","#67a9cf","#d1e5f0","#8c510a"),
        xlab="",
        ylab="Layer contributions",
        names.arg=paste0("K=",1:7),
        main = "Spruce")



