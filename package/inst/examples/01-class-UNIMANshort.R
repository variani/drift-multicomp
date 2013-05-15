### par
sensors <- 1:2

### data
library(chemosensors)
data(UNIMANshort)

X <- UNIMANshort$dat[, sensors]
Y <- as.factor(apply(UNIMANshort$C, 1, function(x) LETTERS[which(x != 0)]))

input <- defaulInput()
input$X <- X
input$Y <- Y
input$methodClass <- "lda"

### moduleSplit
out <- moduleSplit.split(input)

### moduleClass
out <- moduleClass.train(out)
