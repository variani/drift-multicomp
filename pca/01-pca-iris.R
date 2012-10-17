### include
library(pls)
library(reshape) 
library(ggplot2)

### data
data(iris)

str(iris)

table(iris$Species)

### plot iris data
# credits: http://blog.echen.me/2012/01/17/quick-introduction-to-ggplot2/
qplot(Sepal.Length, Petal.Length, data = iris)

# add class labels with colors
qplot(Sepal.Length, Petal.Length, data = iris, color = Species) 

# add 3rd dimension with points' size
qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width)
# -> that makes sense

# improve the last plot with alpha (try to cope with overplotting)
qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width, alpha = I(0.7))

### PCA model (see `?prcomp` for more details)
mod <- prcomp(iris[, 1:4], center = TRUE, scale = TRUE)

# captured variance by PCs
mod$sdev

qplot(paste("PC", 1:4), mod$sdev / sum(mod$sdev), geom = "bar") + ggtitle("PCA: Captured Variance")

# loadings
loadings <- data.frame(x = rownames(mod$rotation), mod$rotation)
mf <- melt(loadings)

qplot(x, value, data = mf, group = variable, color = variable, geom = "line") + ggtitle("PCA: Loadings")

# scores
scores <- as.data.frame(mod$x)

qplot(PC1, PC2, data = scores, color = iris$Species) + ggtitle("PCA: Scores")

qplot(PC1, PC2, data = scores, size = PC3, color = iris$Species) + ggtitle("PCA: Scores (3D)")
