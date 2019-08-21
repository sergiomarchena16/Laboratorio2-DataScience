# LABORATORIO 2 DE DATA SCIENCE
# SERGIO MARCHENA 16387


# -------------------------------------------------- AVANCE ----------------------------------------------------

datos<-read.csv("train.csv")


# 1. DIVIDIR EL DATASET EN CONJUNTOS DE ENTRANAMIENTO Y DE PRUEBA 


set.seed(123)

#Porciento en el que se partirán los datos
porcentaje <- 60/100 

#Muestra aleatoria de numeros de un vector
muestra<-sample(1:nrow(datos),porcentaje*nrow(datos))

#Obtengo las filas de los elementos que estan en el sector de muestra
trainSet<-datos[muestra,]

#Obtengo las filas de los elementos que no están en el vector de muestra
testSet<-datos[-muestra,] 


# 2. MODELO DE REGRESION LINEAL


