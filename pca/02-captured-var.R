### include
library(pls)

### parameters
pc <- 1:2 # let's comput variance for just first 2 PCs

### data
data(iris)
X <- iris[, 1:4] # data matrix

### PCA model
mod <- prcomp(X, center = TRUE, scale = FALSE)

### Option 1: captured variance via method `summary` of package `pls`
smod <- summary(mod)
var.pls <- smod$importance["Proportion of Variance", pc]

### PCA numbers by manual computation
X <- as.matrix(X) # needed to be a matrix
E <- as.matrix(mod$rotation[, pc]) # `E` is a sub-space defined by PCs `pc`

# scale 'X' according to the model `mod`
X.scaled <- X
if(mod$center[1]) X.scaled <- as.matrix(sweep(X.scaled, 2, mod$center))  
if(mod$scale[1])  X.scaled <- as.matrix(sweep(X.scaled, 2, mod$scale, "/"))

var.projected <- apply(E, 2, function(e) sum((X.scaled %*% e)^2))
var.total <- sum(apply(X.scaled, 2, function(x) sum((x)^2)))

var.pc <- var.projected / var.total

### compare numbers of proportion of projected variance
cat(" * variance computed by package `pls`:", var.pls, "\n")
cat(" * variance computed by hand:", var.pc, "\n")
