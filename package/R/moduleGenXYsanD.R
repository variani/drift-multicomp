
moduleGenXYsanD <- function(path, batch)
{
  #establece el path
  fichero<-path
  files=file.path(fichero, list.files(fichero))
  
  stopifnot(class(batch)=="numeric")
 
  ## matriz X, Y vacía
  X<- matrix(nrow=0, ncol=128)
  Y<- matrix(nrow=0, ncol=1)
  
  ### leer los datos
  
  
  for(i in 1:batch)
      {
    data <- read.matrix.csr(files[i])
    X0<-(as.matrix(data$x))
    X<-rbind(X,X0)
    
    Y0<-as.matrix(data$y)
    Y<-rbind(Y,Y0)
      }
  output<-list(X=X, Y=Y)
  return(output)
  }
  



