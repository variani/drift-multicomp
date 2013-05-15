
moduleSplit.split <- function(input)
{
  ### input
  stopifnot(all(c("X", "Y", "trainSize") %in% names(input)))
  
  ### do splitting
  trainInd <- 1:input$trainSize
  testInd <- seq(input$trainSize + 1, nrow(input$X))
  
  ### return output
  output <- list(trainInd = trainInd, testInd = testInd)
  stopifnot(!any(names(input) %in% names(output)))
  
  output <- c(input, output) 
  return(output)
}
