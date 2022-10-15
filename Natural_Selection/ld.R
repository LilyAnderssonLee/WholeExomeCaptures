setwd("~/Desktop/Desktop/copy_20171001/Picea_obovata/analysis/arlequin_LD/LD")
library(ggplot2)
data<-read.table("all_loci_LD.csv",header=T,sep=" ",fill=TRUE)
head(data)
model<-nls(r_square~(10+A*distance)*(1+(3+A*distance)*(12+12*A*distance+A*A*distance^2)/(62*(2+A*distance)*(11+A*distance)))/((2+A*distance)*(11+A*distance)),data=data,start=list(A=0.02),control=list(maxiter=500))
summary(model)
head(data)
dim(data)

###control loci: 1: 1892,
control_ld<-data[1:1892,]
candi_ld<-data[1893:3356,]

model_control<-nls(r_square~(10+A*distance)*(1+(3+A*distance)*(12+12*A*distance+A*A*distance^2)/
                                               (62*(2+A*distance)*(11+A*distance)))/((2+A*distance)*(11+A*distance)),
                   data=control_ld,start=list(A=0.02),control=list(maxiter=500))

model_candit<-nls(r_square~(10+A*distance)*(1+(3+A*distance)*(12+12*A*distance+A*A*distance^2)/
                                               (68*(2+A*distance)*(11+A*distance)))/((2+A*distance)*(11+A*distance)),
                   data=candi_ld,start=list(A=0.02),control=list(maxiter=500))

summary(model_control)
summary(model_candit)
A=0.22289
A=0.075049 #recomnination rate

C=A*control_ld$distance
C=A*candi_ld$distance
#n=individuals
n=62
n=68

p1=(10+C)/((2+C)*(11+C))
p2_upp=(3+C)*(12+12*C+C^2)
p2_low=n*(2+C)*(11+C)
Er<-p1*(1+p2_upp/p2_low)
#par(mar=c(5,10,4,2)+0.5)
test_control<-as.data.frame(cbind(Er[order(control_ld$distance,decreasing=F)],sort(control_ld$distance,decreasing=F)))

test_candi<-as.data.frame(cbind(Er[order(candi_ld$distance,decreasing=F)],sort(candi_ld$distance,decreasing=F)))



#setEPS()
#postscript("Fig2.eps",width =6.8, height = 5,paper = 'special',horizontal = FALSE)
#plot(data$r_square~data$distance,
#    xlab="Distance (bp)",ylab=expression(bold("LD " (r^2))),
#     pch=19,cex=0.5,cex.lab=1.5,cex.axis=1.5,font.lab=2)
#     #pch=19,cex=0.5,cex.lab=1.5,cex.axis=1.5)
#lines(Er[order(data$distance,decreasing=F)]~sort(data$distance,decreasing=F),lwd=2,col='red')

#dev.off()
p_control<-ggplot(control_ld,aes(x=distance,y=r_square))+
  geom_point(size=1.5)+
  geom_line(data=test_control,aes(x=V2,y=V1),color='red',size=1)+
  ggtitle(label = 'Control loci')+
  theme(axis.text.x = element_text(size = 10,face = "bold",hjust = 0.5),
        axis.text.y = element_text(size=10,face = "bold"),
        axis.title=element_text(size=12,face = "bold"))+
  xlab("Distance (bp)")+
  ylab(expression(bold("LD "(r^2))))



p<-ggplot(candi_ld,aes(x=distance,y=r_square))+
  geom_point(size=1.5)+
  geom_line(data=test_candi,aes(x=V2,y=V1),color='red',size=1)+
  ggtitle(label = 'Candidate loci')+
  theme(axis.text.x = element_text(size = 10,face = "bold",hjust = 0.5),
        axis.text.y = element_text(size=10,face = "bold"),
        axis.title=element_text(size=12,face = "bold"))+
  xlab("Distance (bp)")+
  ylab(expression(bold("LD "(r^2))))

multiplot(p_control,p,cols = 2)


cairo_ps(filename = "Fig2.eps",
         width = 6.8,height = 5)
print(p)
dev.off()

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
