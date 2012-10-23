library(JADE)
library(abind)

### data
data(iris)

X <- iris[, 1:2]
Y <- iris[, 5]

### prepare corr. matrices

# check scaling does not affect corr.
cor(X)
cor(scale(X))

# compute corr. matricies `C`
names(cbind(X, Y))

C <- daply(cbind(X, Y), "Y", function(x) cor(x[, -ncol(x)]))
dimnames(C) # order of dimensions is not the same as `djd` requires

C <- aperm(C, c(2, 3, 1)) # put the 1st dimension to the end
dimnames(C)

stop()
# See correlations

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

dim(X) # should be a 3D array

W <- djd(X) 
# W <- djd(X, r = 1)
# W <- djd(X, G = "l")

# Common PC in weight matrix `W` are exactly vectors in transformation matirx `U` (used to generate X1, X2, ...)
round(U %*% W, 4) # should be a signed permutation matrix if W1 is correct.


