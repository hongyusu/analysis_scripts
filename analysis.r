


samples=c('emotions','yeast','enron','cal500','fp','cancer','medical','toy10','toy50')
#samples=c('toy10')

pdf(sprintf('../plots/plot.pdf'),height=4*length(samples),width=12)
par(mfrow=c(length(samples),3))

for(sam in samples)
{
    d=c()
    tmp=as.matrix(read.table(sprintf('../results/%s_perfSVM',sam),sep=','))   
    d=rbind(d,tmp[2,])
    tmp=as.matrix(read.table(sprintf('../results/%s_perfBagSVM',sam),sep=','))   
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
    colnames(d)=c('Acc','Vec','Pre','Rec','F1','AUC1','AUC2')

    for(i in c(1,2,5))
    {
        plot(d[,i],main=sprintf("%s",sam),ylab=sprintf('%s',colnames(d)[i]))
        text(d[,i],rownames(d),pos=1)
    }
}

dev.off()
