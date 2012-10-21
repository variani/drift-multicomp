# Example of multivariate correction of drift in data
# @ http://doi.wiley.com/10.1002/1099-128X(200009/12)14:5/63.0.CO;2-4
# Notation for PCA: X = T t(P) + E
#  - X: data matrix
#  - T: scores matrix
#  - P: loadings matrix
#  - E: error matrix

### include
library(pls)
library(reshape) 
library(ggplot2)
library(grid) 

### parameters
ref <- "setosa" # reference class

### data
data(iris)

X <- iris[, 1:2]
Y <- iris[, 5]

### center/scale data
X <- scale(X, center = TRUE, scale = TRUE) # See `attributes(X)`

p1 <- qplot(Sepal.Length, Sepal.Width, data = as.data.frame(X), color = Y) + 
  ggtitle("PCA on Original Data")
p1

### PCA model #0: original data
M <- prcomp(X, center = FALSE, scale = FALSE) # `X` are already scaled
T <- M$x

p2 <- qplot(PC1, PC2, data = as.data.frame(T), color = Y) + ggtitle("PCA: Scores")
p2

## PCA model #1: reference class
ind <- which(Y == ref)
Xr <- X[ind, ] # note: we the data are scaled, but for all three classes

Xr <- scale(Xr, center = TRUE, scale = FALSE) # we do centering (to capture PC1, 
# the major variance direction), but we do not do scaling

p3 <- qplot(Sepal.Length, Sepal.Width, data = as.data.frame(Xr), color = ref)
p3

Mr <- prcomp(Xr, center = FALSE, scale = FALSE) 
Tr <- Mr$x

p4 <- qplot(PC1, PC2, data = as.data.frame(Tr), color = ref)
p4

E <- Mr$rotation 
# centering is not necessary, as that doesn't change the directions of PCs
  
p5 <- qplot(Sepal.Length, Sepal.Width, data = as.data.frame(Xr), color = ref) + 
  geom_segment(data = as.data.frame(t(E)), aes(x = 0, xend = Sepal.Length, y = 0, yend = Sepal.Width), arrow = arrow())
p5

# columns of `E` orthogonal?
E[, 1] %*% E[, 2]

# let's plot properly to see orthogonality of `E`
p5 + xlim(c(-3, 3)) + ylim(c(-3, 3)) + theme(legend.position = "none")

# select just one PC
E1 <- E[, 1, drop = FALSE]

p1 + geom_segment(data = as.data.frame(t(E1)), aes(x = 0, xend = Sepal.Length, y = 0, yend = Sepal.Width, color = ref), arrow = arrow())

## Component Correction
Xc <- X - (X %*% E1) %*% t(E1)

p6 <- qplot(Sepal.Length, Sepal.Width, data = as.data.frame(Xc), color = Y)  
p6

## Let's repeat everything for `iris[, 1:4]`
X <- iris[, 1:4]
Y <- iris[, 5]

X <- scale(X, center = TRUE, scale = TRUE) # See `attributes(X)`
M <- prcomp(X, center = FALSE, scale = FALSE)
T <- M$x

p7 <- qplot(PC1, PC2, data = as.data.frame(T), color = Y) + ggtitle("PCA on Original Data")
p7

ind <- which(Y == ref)
Xr <- X[ind, ]

Xr <- scale(Xr, center = TRUE, scale = FALSE) 
Mr <- prcomp(Xr, center = FALSE, scale = FALSE) 

E <- Mr$rotation 
E1 <- E[, 1, drop = FALSE]

Xc <- X - (X %*% E1) %*% t(E1)

Mc <- prcomp(Xc, center = TRUE, scale = TRUE)
Tc <- Mc$x

p8 <- qplot(PC1, PC2, data = as.data.frame(Tc), color = Y) + ggtitle("PCA on Corrected Data")
p8
# compare plots `p7` and `p8`. Where is better class-separaility?

## The last (not the least) step: un-scale data
Xcenter <- attr(X, "scaled:center")
Xscale <- attr(X, "scaled:scale")

if(!is.null(Xscale[1])) Xc <- sweep(Xc, 2, Xscale, "*")
if(!is.null(Xcenter[1])) Xc <- sweep(Xc, 2, Xcenter, "+")

head(Xc)
