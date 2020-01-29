set.seed(101)
x=matrix(rnorm(10000*3),10000,3)
plot(x,pch=19)
which=sample(1:3,10000,replace=TRUE)
plot(x,col=which,pch=19)
xmean=matrix(rnorm(3*3,sd=4),3,3)
xclusterd=x+xmean[which,]
plot(xclusterd,col=which,pch=19)
xclusterd[,3] = which
xclusterd
#write.csv(xclusterd,file="10000-2D-three-classes.csv", row.names=F)

