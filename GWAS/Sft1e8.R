# R Code to create Manhattan plots - H. Wang (Joy)
yyy1 = read.table("chrsnp")
yyy  = yyy1[order(yyy1$V4),]
zzz  = yyy[ which(yyy$V1==1 & yyy$V2==8), ]
n    = nrow(zzz)
y    = zzz[,4]
x    = zzz[,3]
chr1 = zzz[,5]
chr  = NULL
pos  = NULL
for (i in unique(yyy$V5)) {
    zz     = yyy[yyy$V5==i,]
    key    = zz$V4 
    medio  = round(nrow(zz)/2,0)
    z      = key[medio]
    pos    = c(pos,z)
}
chrn       = unique(yyy$V5)
one        = which(chr1%%4==0) 
two        = which(chr1%%4==1) 
three      = which(chr1%%4==2) 
four       = which(chr1%%4==3) 
chr[one]   = "darkgoldenrod"
chr[two]   = "darkorchid"
chr[three] = "blue"
chr[four]  = "forestgreen"
pdf(file="Sft1e8_manplot.pdf",family="sans",height=27.8,width=50,pointsize=20,bg="white")
par(mfrow=c(1,1),family="sans",cex=1.5,font=2)
plot(y,x,xaxt="n",main="Manhattan Plot SNP Solution - Trait: 1 Effect: 8",xlab="",ylab="SNP solution   ",pch=20,xlim=c(1,n),ylim=c(0,max(x)),col=chr)
axis(1,at=pos,labels=chrn)
dev.off()
