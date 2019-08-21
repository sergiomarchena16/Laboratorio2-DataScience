# LABORATORIO 2 DE DATA SCIENCE
# SERGIO MARCHENA 16387


# -------------------------------------------------- AVANCE ----------------------------------------------------
install.packages("caret")
library(caret)
library(dplyr)
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

#--- SIMPLE

#Generacion del Modelo Lineal
modeloLinealSimple<-lm(SalePrice~OverallQual,GarageArea,GrLivArea, data = trainSet)
# Aqui comparamos la variable de SalePrice contra OverallQual que segun el Analisis Exploratorio, 
# es una de las variables con mas correlacion. 
summary(modeloLinealSimple)

#Prediccion
prediccion<-predict(modeloLinealSimple, newdata = testSet[2:80])
# La prediccion se hace con el modelo creado anteriormente y el nuevo data para probar son
# las columnas de la 1-80, y no a la 81, que es la que se quiere predecir. 

prediccion

# Se agrega la prediccion al conjunto de test
testSet$SalePred<-prediccion
View(testSet[81:82])

#Ver la diferencia entre lo real y lo predicho
dif<-abs(testSet$SalePred-testSet$SalePrice)
View(dif)

promedioError<- mean(dif)
summary(dif)
promedioError

# Matriz de Confusion

real<-as.factor(testSet$SalePrice)
str(real)
prede<-as.factor(testSet$SalePred)
str(prede)
cfm<-confusionMatrix(real,prede)
cfm

testSet$SalePred <-NULL

#--- MULTIVARIADA

#Generacion del Modelo Lineal Multivariado
nums<-dplyr::select_if(trainSet, is.numeric)   #SOLO VARIABLES NUMERICAS
# primero se separan las variables numericas, ya que no funciona para variables con muchos 
# niveles. 
modeloLinealMulti<-lm(SalePrice~., data = nums)
# Luego, se trata de comparar la variable de SalePrice contra todas las demas variables numericas
# para ver si hay regresion multivariada.
View(modeloLinealMulti)

#Prediccion
prediccion<-predict(modeloLinealMulti,newdata = testSet[1:80])
# Se hace la comparacion usando el modelo multivariado en el testSet y se seleccionan todas las
# variables menos la ultima, que es la que se quiere predecir. 

prediccion

# Se agrega la prediccion al conjunto de test
testSet$SalePred<-prediccion
View(testSet[81:82])

#Ver la diferencia entre lo real y lo predicho
dif<-abs(testSet$SalePred-testSet$SalePrice)
View(dif)

promedioError<- mean(dif)
promedioError

# Matriz de Confusion

real<-as.integer(testSet$SalePrice)
str(real)

prede<-as.integer(testSet$SalePred)
str(prede)
cfm<-confusionMatrix(as.factor(real),as.factor(prede))
cfm

testSet$SalePred <-NULL

# ---------------------------------------------- FIN DE AVANCE ----------------------------------------------------

