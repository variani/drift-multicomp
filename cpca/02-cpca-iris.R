library(JADE)
library(abind)

library(ggplot2)
library(grid)

### data
data(iris)

X <- iris[, 1:2]
Y <- iris[, 5]

### prepare corr. matrices

# check scaling does not affect corr.
cor(X)
cor(scale(X))

# scale data
X <- scale(X, center = TRUE, scale = TRUE) # See `attributes(X)`

# compute corr. matricies `C`
names(cbind(X, Y))

C <- daply(data.frame(X, Y), "Y", function(x) cor(x[, -ncol(x)]))
dimnames(C) # order of dimensions is not the same as `djd` requires

C <- aperm(C, c(2, 3, 1)) # put the 1st dimension to the end
dimnames(C)

P <- djd(C) 
rownames(P) <- colnames(X)
colnames(P) <- paste("CPC", 1:ncol(P), sep = "")
P

### plot results
# PCA model
M <- prcomp(X, center = FALSE, scale = FALSE)
T <- M$x

p1 <- qplot(Sepal.Length, Sepal.Width, data = as.data.frame(X), color = Y) +
  geom_segment(data = as.data.frame(t(P)), aes(x = 0, xend = Sepal.Length, 
    y = 0, yend = Sepal.Width, color = colnames(P)), arrow = arrow())
p1


