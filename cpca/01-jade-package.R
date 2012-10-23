# Commuting Matrices: http://mathworld.wolfram.com/CommutingMatrices.html

library(JADE)
library(abind)

library(plyr)

### run example in help section `?djd`
set.seed(1) # for reproducibility of results

Z <- matrix(runif(9), ncol = 3)
U <- eigen(Z %*% t(Z))$vectors

D1 <- diag(runif(3))
D2 <- diag(runif(3))
D3 <- diag(runif(3))
D4 <- diag(runif(3))

X1 <- t(U) %*% D1 %*% U
X2 <- t(U) %*% D2 %*% U
X3 <- t(U) %*% D3 %*% U
X4 <- t(U) %*% D4 %*% U

# check matrices `X1` and `X2` commute
X1 %*% X2
X2 %*% X1

# `X1` and `X2` commute, as their product is like `D2 %*% D1` (D1, D2 are diagonal)
D1 %*% D2
D2 %*% D1

# let's start Joint Diagonalization
X <- abind(X1, X2, X3, X4, along = 3) # a nice way to combine several 2D matricies into one 3D matrix
dim(X) # should be a 3D array

W <- djd(X) 
# W <- djd(X, r = 1)
# W <- djd(X, G = "l")

# Common PC in weight matrix `W` are exactly vectors in transformation matirx `U` (used to generate X1, X2, ...)
round(U %*% W, 4) # should be a signed permutation matrix if W1 is correct.


