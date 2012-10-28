


#samples=c('emotions','yeast','scene','enron','medical','toy10','toy50')
samples=c('toy10')

pdf(sprintf('../plots/plot.pdf'),height=4*length(samples),width=20)
par(mfrow=c(length(samples),5))

for(sample in samples)
{
    d=c()
    tmp=as.matrix(read.table(sprintf('../results/%s_perfSVM',sample),sep=','))   
    d=rbind(d,tmp[2,])
    tmp=as.matrix(read.table(sprintf('../results/%s_perfBagSVM',sample),sep=','))   
    d=rbind(d,tmp[2,])
    tmp=as.matrix(read.table(sprintf('../results/%s_perfAda',sample),sep=','))   
    d=rbind(d,tmp[2,])
    tmp=as.matrix(read.table(sprintf('../results/%s_perfMTL',sample),sep=','))   
    d=rbind(d,tmp[2,])
    tmp=as.matrix(read.table(sprintf('../results/%s_perfPairEns',sample),sep=','))   
    d=rbind(d,tmp[-1,])
    tmp=as.matrix(read.table(sprintf('../results/%s_perfTreeEns',sample),sep=','))   
    d=rbind(d,tmp[-1,])
    rownames(d)=c('SVM','Bag','Ada','MTL','PairRand','PairBin','PairVal','PairMad','TreeRand','TreeBin','TreeVal','TreeMad') 
    colnames(d)=c('Acc','Vec','Pre','Rec','F1','AUC1','AUC2')

    for(i in c(1,2,5,6,7))
    {plot(d[,i],main=sprintf("%s",sample),ylab=sprintf('%s',colnames(d)[i]))}
}

dev.off()
