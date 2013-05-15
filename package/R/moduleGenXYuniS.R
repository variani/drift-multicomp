
##read UNIMANshort only

modulegenXYuniS <- function(data)
{
  
  
  ###Load UNIMANshort, databases de Universidad de Manchester, çposee 200 muestras de 17 sensores.
  ###Posee 8 clases (Amoniaco 0.01,0.02 0.05 - Acido Propanoico 0.01, 0.02, 0.05 - N-buthanol 0.1, 1) (200x3)

  
  #Matriz dat, posee 200 filas y 17 columnas, contiene las señales de estado estable de 17 sensores en respuesta la perfil de concentracion
  
  X <- UNIMANshort$dat
  
  # se extrae la matriz C que es la matriz de concentración 200 filas y 3 columnas
  # se extraen todas las  concentraciones diferentes de cero
  
  conc <- apply(UNIMANshort$C, 1, function(x) x[x != 0])
  
  ind <- apply(UNIMANshort$C, 1, function(x) which(x != 0))
  gas <- LETTERS[ind]
  
  Y0 <- paste(gas, conc)
  Y0<- as.factor(Y0)
  Y<-as.factor(gas)
output <- list(X = X, Y = Y, Y0=Y0)
  ### save
  output <- c(output)  
  
    save(X, Y, Y0, file = "/home/susana/Documents/projetcs/driftout/data/UNIMANshort.XY.RData")
  
  return(output)
  
}

