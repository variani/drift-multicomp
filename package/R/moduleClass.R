
moduleClass.train <- function(input)
{
  ### input
  stopifnot(all(c("X", "Y", "trainInd", "testInd", "methodClass") %in% names(input)))
  Xt <- input$X[input$trainInd, ]
  Yt <- input$Y[input$trainInd]
  methodClass <- input$methodClass
  
  stopifnot(class(Xt) %in% c("data.frame", "matrix"))
  stopifnot(class(Yt) == "factor")
  stopifnot(class(methodClass) == "character")

  Xt <- as.matrix(Xt) # requirement by caret
    
  stopifnot(nrow(Xt) == length(Yt))
  
  ### train
  library(caret)
  model <- train(Xt, Yt, method = methodClass)
  
  ### evaluate the model
  Yp <- predict(model, Xt)
  trainTab <- table(Yp, Yt) # confusion matrix 
  trainAcc <- sum(diag(trainTab)) / sum(trainTab)

  ### return output
  output <- list(model = model, trainTab = trainTab, trainAcc = trainAcc)
  stopifnot(!any(names(input) %in% names(output)))
  
  output <- c(input, output) 
  return(output)
}
