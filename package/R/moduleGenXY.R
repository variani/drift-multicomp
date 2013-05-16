## Esté módulo toma como referencia dos posibles bases de batos: San Diego y UNIMANshort,
## en caso de tener una base de datos diferente se debe generar aparte la matriz
## X y el factor Y. 

## La función se llama moduleGenXY, la entrada "input" es uan lista que contiene
## parámetro de entrada DataBase= "UNIMANshort" "SanDiego" "other".

## return: en el caso de SanDiego y UNIMANshort -->  X, Y, name of "DataBAse",
## conc (éste último solo para UNIMANshort). Ouput es una lista. en el caso de
## DataBase="other", imprime el mensaje "Se deber generar la matriz X y el 
## factor Y.



moduleGenXY <- function(input)
{
  stopifnot("DataBase" %in% names(input) )
  DataBase <- input$DataBase
  
  output <- switch(DataBase,
                   "UNIMANshort" = GenerateXY.uniS(input),
                   "SanDiego" = GenerateXY.sanD(input),
                   "other"=print("Genere X (as matrix) y Y (as factor)"),
                    stop("Error in switch"))
  
  output <- c(input, output) 
  return(output)
}



##CASE 1: DataBase= "UNIMANshort", return X, Y, conc

GenerateXY.uniS <- function(input)
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
output <- list(X = X, Y = Y, conc=conc)
  ### save
  output <- c(output)  
  
    save(X, Y, conc, file = "/home/susana/Documents/projetcs/driftout/data/UNIMANshort.XY.RData")
  
  return(output)
  
}


##CASE 2: DataBase= "SanDiego", return X, Y

GenerateXY.sanD <- function(input)
{
  
  batch<-input$batch
  output <- switch(batch,
                   "to" = Read.to.batch(input),
                   "this" = Read.only.batch(input),
                    stop("Error in switch"))
 
   return(output)
}


## CASE 2.1 Lee San Diego hasta el batch = num

Read.to.batch<- function(input)
{
  fichero<-"/home/susana/Documents/projetcs/driftout/data/data bases UCI"
  files=file.path(fichero, list.files(fichero))
  fin<-input$fin
  
  
  stopifnot(class(fin)=="numeric")
  
  ## matriz X, Y vacía
  X<- matrix(nrow=0, ncol=128)
  Y<- matrix(nrow=0, ncol=1)
  
  ### leer los datos
  
  
  for(i in 1:fin)
  {
    data <- read.matrix.csr(files[i])
    X0<-(as.matrix(data$x))
    X<-rbind(X,X0)
    
    Y0<-as.matrix(data$y)
    Y<-rbind(Y,Y0)
  }
  
  output<-list(X=X, Y=Y)
  
  save(X, Y, file = "/home/susana/Documents/projetcs/driftout/data/SanDiego.XY.RData")
  
  return(output)
} 


## CASE 2.2 Lee San Diego desde el batch = ini hasta el batch = fin

Read.only.batch<- function(input)
{
  fichero<-"/home/susana/Documents/projetcs/driftout/data/data bases UCI"
  files=file.path(fichero, list.files(fichero))
  ini<-input$ini
  fin<-input$fin
  
  stopifnot(class(ini)=="numeric", class(fin)=="numeric")
  
  ## matriz X, Y vacía
  X<- matrix(nrow=0, ncol=128)
  Y<- matrix(nrow=0, ncol=1)
  
  ### leer los datos
  
  
  for(i in ini:fin)
  {
    data <- read.matrix.csr(files[i])
    X0<-(as.matrix(data$x))
    X<-rbind(X,X0)
    
    Y0<-as.matrix(data$y)
    Y<-rbind(Y,Y0)
  }
  
  output<-list(X=X, Y=Y)
  
  save(X, Y, file = "/home/susana/Documents/projetcs/driftout/data/SanDiego.XY.RData")
  
  return(output)
  
}


  
  
  