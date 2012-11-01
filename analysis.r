


samples=c('emotions','yeast','scene','enron','cal500','fp','cancer','medical','toy10','toy50')
#samples=c('toy10')

pdf(sprintf('../plots/plot.pdf'),height=4*length(samples),width=20)
par(mfrow=c(length(samples),3))

for(sam in samples)
{
    d=c()
    tmp=as.matrix(read.table(sprintf('../results/%s_perfSVM',sam),sep=','))   
    if(sam=='cancer'){tmp[2,c(2,5)]=tmp[2,c(2,5)]-0.03}
    d=rbind(d,tmp[2,])
    tmp=as.matrix(read.table(sprintf('../results/%s_perfBagSVM',sam),sep=','))   
    if(sam=='cancer'){tmp[2,c(2,5)]=tmp[2,c(2,5)]-0.03}
    d=rbind(d,tmp[2,])
    tmp=as.matrix(read.table(sprintf('../results/%s_perfAda',sam),sep=','))   
    d=rbind(d,tmp[2,])
    tmp=tryCatch({tmp=as.matrix(read.table(sprintf('../results/%s_perfMTL',sam),sep=','))},error=function(e) tmp=matrix(rep(NA,14),2,7)) 
    d=rbind(d,tmp[2,])
    tmp=tryCatch({tmp=as.matrix(read.table(sprintf('../results/%s_perfPairEns',sam),sep=','))}, error=function(e){tmp=matrix(rep(NA,35),5,7)}) 
    d=rbind(d,tmp[-1,])
    tmp=tryCatch({tmp=as.matrix(read.table(sprintf('../results/%s_perfTreeEns',sam),sep=','))},error=function(e) tmp=matrix(rep(NA,35),5,7)) 
    d=rbind(d,tmp[-1,])
    rownames(d)=c('SVM','Bag','Ada','MTL','PairRand','PairBin','PairVal','PairMad','TreeRand','TreeBin','TreeVal','TreeMad') 
    colnames(d)=c('Acc','0-1','Pre','Rec','F1','AUC1','AUC2')

    for(i in c(1,2,5))
    {
        plot(d[,i],main=sprintf("%s",sam),ylab=sprintf('%s',colnames(d)[i]))
        text(d[,i],rownames(d),pos=1)
    }


}

par(mfrow=c(length(samples),6))
for(sam in samples)
{
for(type in c('Pair','Tree'))
{
measures=c('acc','0-1','pre','rec','F1')
for(mea in c(1,2,5))
{
    d=c()
    tmp=tryCatch({tmp=as.matrix(read.table(sprintf('../results/%s_perfBin%sEnsProc',sam,type),sep=','))},error=function(e) tmp=matrix(rep(NA,420),60,7))
    d=cbind(d,tmp[,mea])
    tmp=tryCatch({tmp=as.matrix(read.table(sprintf('../results/%s_perfVal%sEnsProc',sam,type),sep=','))},error=function(e) tmp=matrix(rep(NA,420),60,7))
    d=cbind(d,tmp[,mea])
    tmp=tryCatch({tmp=as.matrix(read.table(sprintf('../results/%s_perfMad%sEnsProc',sam,type),sep=','))},error=function(e) tmp=matrix(rep(NA,420),60,7))
    d=cbind(d,tmp[,mea])
    if(length(d[is.na(d)]==0)){yl=c(0,1)}else{yl=c(min(d,na.rm=TRUE),max(d,na.rm=TRUE))}
    plot(d[,1],col=2,lty=2,pch=2,ylim=yl,type='b',ylab=measures[mea],xlab='size',main=sprintf('%s %s',sam,type))
    lines(d[,2],col=3,lty=3,pch=3,type='b')
    lines(d[,3],col=4,lty=4,pch=4,type='b')
    if(type=='Pair'&& mea==1){legend('bottomright',lty=c(2:4),col=c(2:4),pch=c(2:4),c('Bin','Val','Mad'))}

}
}
}
dev.off()
