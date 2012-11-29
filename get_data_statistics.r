


#samples=c('emotions','yeast','scene','enron','cal500','fp','cancer','medical','toy10','toy50')
samples=c('toy10')


for(sam in samples)
{
    #Y=as.matrix(read.table(sprintf('/fs/group/urenzyme/workspace/data/%s_targets',sam)))
    Y=as.matrix(read.table(sprintf('../shared_scripts/test_data/%s_targets',sam)))
    Y[Y>0]=1
    Y[Y!=1]=0
    d=sprintf("%s & $%.0f$ & $%.0f$ & $%.2f$ & $%.2f$ & $%.2f$\\",sam,dim(Y)[1],dim(Y)[2],mean(rowSums(Y)),mean(rowSums(Y))/dim(Y)[2],mean(pmin(rowSums(Y)/dim(Y)[2],1-rowSums(Y)/dim(Y)[2])),mean(upper.tri(cor(Y)))) 
print(d)


}
