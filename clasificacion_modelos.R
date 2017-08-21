library("mclust") #cargar biblioteca

data = read.table("wpbc.data", sep = ",")

colnames(data) = c("id", "c", "t ","r1", "t1", "p1", "a1", "su1", 
                   "com1", "con1", "pc1", "si1", "df1", 
                   "r2", "t2", "p2", "a2", "su2", 
                   "com2", "con2", "pc2", "si2", "df2",
                   "r3", "t3", "p3", "a3", "su3", 
                   "com3", "con3", "pc3", "si3", "df3",
                   "tt", "eg")

#se eliminan registros con error
error = data$eg == '?'
data = data[!error,]

#se modifica la ultima variable a numerica
data$eg = as.numeric(data$eg)

#Best BIC values:
#  EEE,1    EEV,1    VEV,1
#BIC      7406.545 7406.545 7406.545
#BIC diff    0.000    0.000    0.000

class=data$c
BIC=mclustBIC(data[,4:35], prior = priorControl(functionName="defaultPrior", shrinkage=0.1))

#graficar BIC
plot(BIC)

#>>>summary(BIC)
#Best BIC values:
#            EEE,1    EEV,1    VEV,1
#BIC      7406.545 7406.545 7406.545
#BIC diff    0.000    0.000    0.000

#            EEE,2    EEV,2    VEV,2
#BIC       7266.63  6103.41  6373.11

#son utilizados 2 grupos dado que en caso contrario no tendria sentido la clasificación
mod_eee=Mclust(data[,4:35], G = 2, modelNames = "EEE")
#>>>summary(mod_eee)
#Clustering table:
#  1   2 
#127  67 
table(class,mod_eee$classification)
# class   1   2
#     N 100  48
#     R  27  19
# error 75 casos

mod_eev=Mclust(data[,4:35], G = 2, modelNames = "EEV")
#>>>summary(mod_eev)
#Clustering table:
#  1   2 
#118  76 
table(class,mod_eev$classification)
# class  1  2
#     N 96 52
#     R 22 24
# error 74 casos
mod_vev=Mclust(data[,4:35], G = 2, modelNames = "VEV")
#>>>summary(mod_vev)
#Clustering table:
# 1   2 
#118  76 
table(class,mod_vev$classification)
# class  1  2
#     N 96 52
#     R 22 24
# error 74 casos

#es graficado un agrupamiento
plot(mod_eee, what = "classification") 
legend("bottomright", legend = 1:2, col = mclust.options("classPlotColors"), pch = mclust.options("classPlotSymbols"),title = "Class labels:")
