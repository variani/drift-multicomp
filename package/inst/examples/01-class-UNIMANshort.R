### par
sensors <- 1:2

### data
library(chemosensors)
data(UNIMANshort)

X <- UNIMANshort$dat[, sensors]
Y <- as.factor(apply(UNIMANshort$C, 1, function(x) LETTERS[which(x != 0)]))

outSplit <- moduleSplit.split(X, Y, 150)

Xt <- X[outSplit$trainInd, ]
Yt <- Y[outSplit$trainInd]

outClass <- moduleClass.train(Xt, Yt)

