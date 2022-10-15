calc_pi<-function(x, cutoff=6){
  
  alleles=c('A','T','G','C','N')
  x.backup<-x
  x<-as.character(x)
  x[is.na(x)]<-'NA'
  num.ind<-length(x)
  num.A<-sum(x=='A')
  num.T<-sum(x=='T')
  num.G<-sum(x=='G')
  num.C<-sum(x=='C')
  num.N<-sum(x=='NA')
  freq<-c(num.A, num.T,num.G, num.C)
  major.allele<-alleles[order(freq,decreasing=T)[1]]
  minor.allele<-alleles[order(freq,decreasing=T)[2]]
  x[x==major.allele]<-1
  x[x==minor.allele]<-0
  x[x=='NA']<-NA
  if(sum(freq>0)>2){stop(paste("More than two alleles found: ",cat(x.backup,sep=''),"\n"))}
  x<-as.numeric(x)
  # if( num.G or num.C !=0) then return(NA), skip
  return(pi(x,cutoff))
}

pi=function(x,cutoff=6){
  x<-x[!is.na(x)]
  if(length(x) < cutoff){
    return(NA)
  }
  x<-sample(x,size=cutoff,rep=F) ## subsampling
  i=sum(x)
  n=length(x)
  pi_site=2*i*(n-i)/(n*(n-1))
  #return(length(x[!is.na(x)]-sum(x,na.rm = T))*sum(x,na.rm = T)*2/(length(x[!is.na(x)])*length(x[!is.na(x)])))
  return(pi_site)
}
