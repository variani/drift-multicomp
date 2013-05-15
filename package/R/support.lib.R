addList <- function(out, add)
{
  stopifnot(class(out) == "list")
  stopifnot(class(add) == "list")  
  stopifnot(!any(names(add) %in% names(out)))
  
  out <- c(out, add) 
  return(out)  
}

defaulInput <- function()
{
  list(trainSize = 50, methodClass = "knn")
}  
  