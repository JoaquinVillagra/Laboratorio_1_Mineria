import pandas as pd #para realizar la lectura de los archivos
from sklearn.ensemble import RandomForestClassifier #para implementar el random forest

train  = pd.read_csv("train.csv") #se realiza la lectura del set de entrenamiento y el de test
test = pd.read_csv("test.csv")

train.head() #para visualizar tan solo el inicio de los datos

cols = ["t","r1", "t1", "p1", "a1", "su1",  "com1", "con1", "pc1", "si1", "df1", "r2", "t2", "p2", "a2", "su2", "com2", "con2", "pc2", "si2", "df2","r3", "t3", "p3", "a3", "su3", "com3", "con3", "pc3", "si3", "df3","tt", "eg"] 
colsRes = ["c"]

trainArr = train.as_matrix(cols) #variables involucradas
trainRes = train.as_matrix(colsRes) #variable de respuesta

rf = RandomForestClassifier(n_jobs=2) #se inicializa el clasificador
rf.fit(trainArr, trainRes) #se ajusta el algoritmo con el set de datos de entrenamiento


#una vez el algoritmo ya ajustado es momento de ingresar el set de datos para que clasifique
testArr = test.as_matrix(cols)
results = rf.predict(testArr)

#test['predictions'] = results #se anade una nueva columna con los resultados obtenidos

pd.crosstab(test['c'], results, rownames=['Actual Species'], colnames=['Predicted Species'])

#print test
list(zip(train[cols], rf.feature_importances_))