library(JADE)
library(abind)

library(plyr)
library(ggplot2)
library(grid)

### data
data(iris)

X <- iris[, 1:4]
Y <- iris[, 5]

### prepare corr. matrices
# scale data
X <- scale(X, center = TRUE, scale = TRUE) # See `attributes(X)`

# compute corr. matricies `C`
C <- daply(data.frame(X, Y), "Y", function(x) cor(x[, -ncol(x)]))
dimnames(C) # order of dimensions is not the same as `djd` requires

C <- aperm(C, c(2, 3, 1)) # put the 1st dimension to the end
dimnames(C)

E <- djd(C) 
rownames(E) <- colnames(X)
colnames(E) <- paste("CPC", 1:ncol(E), sep = "")

# closer look to `E`
E

var.projected <- apply(E, 2, function(e) sum((X %*% e)^2))
var.total <- sum(apply(X, 2, function(x) sum((x)^2)))

var.projected / var.total

### plot results
# PCA model
M <- prcomp(X, center = FALSE, scale = FALSE)
T <- M$x
P <- M$rotation

p1 <- qplot(PC1, PC2, data = as.data.frame(T), color = Y) + ggtitle("PCA on Original Data")

Et <- t(E) %*% P # `E` in space of model `M`, i.e. scores of `E`

# select just first two CPC
Et <- Et[1:2, ]

p2 <- qplot(PC1, PC2, data = as.data.frame(T), color = Y) +
  geom_segment(data = as.data.frame(Et), aes(x = 0, xend = PC1, 
    y = 0, yend = PC2, color = rownames(Et)), arrow = arrow())
p2

# let's replot to ensure that commom components CPC1 and CPC2 are orhtogonal
p2 + xlim(c(-4, 4)) + ylim(c(-4, 4)) + theme(legend.position = "none")

### Component Correction
# common-subspace matrix `E` has been computed before by `djd`
# data matrix `X` has been scaled
E1 <- E[, 1, drop = FALSE]

Xc <- X - (X %*% E1) %*% t(E1)

Mc <- prcomp(Xc, center = TRUE, scale = TRUE)
Tc <- Mc$x

p3 <- qplot(PC1, PC2, data = as.data.frame(Tc), color = Y) + ggtitle("PCA on Corrected Data")
p3
# compare plots `p1` and `p3`. Where is better class-separaility?

## The last (not the least) step: un-scale data
Xcenter <- attr(X, "scaled:center")
Xscale <- attr(X, "scaled:scale")

if(!is.null(Xscale[1])) Xc <- sweep(Xc, 2, Xscale, "*")
if(!is.null(Xcenter[1])) Xc <- sweep(Xc, 2, Xcenter, "+")

head(Xc)


