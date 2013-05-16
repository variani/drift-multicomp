## example for read and generate X, Y from DataBases UNIMANshort y San Diego
#### función moduleGenXY(input), genera X , Y de las bases de datos 
####UNIMANshort y SanDiego, para el caso de SanDiego permite cargar toda la base
####de datos o sólo los batchs que nos interesen.
####input :  es una lista que puede contener lo siguiente
####    * DataBase=   "UNIMANshort"
####                  "SanDiego"
####                  "other"  en este caso genera solo un mensaje
####    * batch= se debe definir en la entrada solo si DataBase="SanDiego"
####                  "to"  se usa para leer desde el batch 1 hasta el batch="fin"
####                  "this" se usa si se requiere leer desde una batch="ini"
####                  hasta un batch="fin"
####    * ini= es un número entre 1 y 10, se requiere solo si el batch="this"
####    * fin= es un número entre 1 y 10, se requiere solo si el batch="this"
####output: retorna una lista que contiene input, X, Y y conc en caso de haber
####    seleccionado la base de datos de UNIMANshort


### for San Diego, enter  batch and ini, fin


rm(A)
a<-list(DataBase="SanDiego", batch="to", ini=1, fin=3)
A<-moduleGenXY(a)
summary(A)

### for UNIMANshort, enter name DataBase

rm(A)
a<-list(DataBase="UNIMANshort")
a
A<-moduleGenXY(a)
summary(A)

