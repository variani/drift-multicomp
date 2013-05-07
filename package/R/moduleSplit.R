
moduleSplit.split <- function(X, Y, trainSize)
{
  trainInd <- 1:trainSize
  testInd <- seq(trainSize + 1, nrow(X))
  
  ### return output
  out <- list(trainInd = trainInd, testInd = testInd)

  return(out)
}
