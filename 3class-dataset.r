set.seed(101)
x=matrix(rnorm(1000*6),1000,6)
plot(x,pch=19)
which=sample(1:2,1000,replace=TRUE)
plot(x,col=which,pch=19)
xmean=matrix(rnorm(2*6,sd=2),2,6)
xclusterd=x+xmean[which,]
plot(xclusterd,col=which,pch=19)
#write.csv(xclusterd,file="1000-2D-2-x1x2.csv", row.names=F)
#write.csv(data.frame(which), file="1000-2D-2-y.csv", row.names=F)

out <- cbind(xclusterd, (data.frame(which) - 1))
write.csv(out, file="1000-6D-2.csv", row.names=F)

r <- read.csv(file = "1000-6D-2.csv")
with(r, plot(x=X1, y=X2, col = which +1))
