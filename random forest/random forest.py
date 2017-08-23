import pandas as pd #para realizar la lectura de los archivos
from sklearn.ensemble import RandomForestClassifier #para implementar el random forest

################################################################
#considerando todas las variables
#train  = pd.read_csv("train.csv") #se realiza la lectura del set de entrenamiento y el de test
#test = pd.read_csv("test.csv")
################################################################
#considerando tan solo ciertas variables
train  = pd.read_csv("train2.csv") #se realiza la lectura del set de entrenamiento y el de test
test = pd.read_csv("test2.csv")
################################################################
train.head() #para visualizar tan solo el inicio de los datos

#todas las columnas
#cols = ["r1", "t1", "p1", "a1", "su1",  "com1", "con1", "pc1", "si1", "df1", "r2", "t2", "p2", "a2", "su2", "com2", "con2", "pc2", "si2", "df2","r3", "t3", "p3", "a3", "su3", "com3", "con3", "pc3", "si3", "df3","tt", "eg"] 
#considerando tan solo las columnas importantes
cols = ['r1','p1','a1','r2','p2','a2','r3','p3','a3','tt', 'su1','t2','df1','pc1']
colsRes = ["c"]


trainArr = train.as_matrix(cols) #variables involucradas
trainRes = train.as_matrix(colsRes) #variable de respuesta

rf = RandomForestClassifier(n_jobs=2) #se inicializa el clasificador
rf.fit(trainArr, trainRes) #se ajusta el algoritmo con el set de datos de entrenamiento


#una vez el algoritmo ya ajustado es momento de ingresar el set de datos para que clasifique
testArr = test.as_matrix(cols)
results = rf.predict(testArr)

#test['predictions'] = results #se anade una nueva columna con los resultados obtenidos

pd.crosstab(test['c'], results, rownames=['Actual clase'], colnames=['Prediccion clase'])

#print test
list(zip(train[cols], rf.feature_importances_))

#####################################
#Resultados considerando la totalidad de variables
"""
Prediccion clase   N  R
Actual clase           
N                 35  5
R                  7  1
"""

#####################################
#resultados considerando variables importantes
"""
Prediccion clase   1  2
Actual clase           
1                 15  3
2                 11  1

"""