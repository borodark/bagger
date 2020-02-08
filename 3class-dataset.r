set.seed(101)
x=matrix(rnorm(1000*2),1000,2)
plot(x,pch=19)
which=sample(1:2,1000,replace=TRUE)
plot(x,col=which,pch=19)
xmean=matrix(rnorm(2*2,sd=3),2,2)
xclusterd=x+xmean[which,]
plot(xclusterd,col=which,pch=19)
#write.csv(xclusterd,file="1000-2D-2-x1x2.csv", row.names=F)
#write.csv(data.frame(which), file="1000-2D-2-y.csv", row.names=F)

out <- cbind(xclusterd, (data.frame(which) - 1))
write.csv(out, file="1000-6D-2.csv", row.names=F)
# [a,b,c] = [-0.2, 0.77004,0.86541  ]
#
#
r1 <- read.csv(file = "1000-2D-2-x1x2.csv", col.names = c('X1','X2'))
which <- read.csv(file = "1000-2D-2-y.csv", col.names = 'which')
r <- cbind(r1,which)
#r['which'] = which
#r <- read.csv(file = "1000-2D-2.csv")
# for -0.2 + 0.77004 * x1 + 0.86541 *x2 = 0
# for a + b * x1 + c *x2 = 0
# a+b*x1 = -c * x2
# x2 = (a/-c) + (b/-c) *x1
# 
a <- -0.2
b <- 0.83188
c <- 0.75637
#eq = function(x){0.2311043320507043-0.8897978992616216*x}
eq = function(x){a/(-c) + (b/-c)*x }
par(pch=22, col="red") # plotting symbol and color
par(mfrow=c(1,1)) # all plots on one page
# plot 
with(r,{ 
  curve(eq, -5, 5, xlab = 'X1', ylab = 'X2')
  points(x=X1, y=X2, pch=20, col = which +1)
})
#r <- read.csv(file = "sonar.csv", header = F)
#with(r, plot(x=V50, y=V1, col = V61 +1))
