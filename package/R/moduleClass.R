
moduleClass.train <- function(Xt, Yt, method = "knn")
{
  ### check input parameters
  stopifnot(class(Xt) == "matrix")
  stopifnot(class(Yt) == "factor")
  
  stopifnot(nrow(Xt) == length(Yt))
  
  ### train
  library(caret)
  model <- train(Xt, Yt, method = method)
  
  ### evaluate the model
  Yp <- predict(model, Xt)
  tab <- table(Yp, Yt) # confusion matrix 
  trainAcc <- sum(diag(tab)) / sum(tab)


  ### return output
  out <- list(model = model, trainAcc = trainAcc)
  
  return(out)
}
