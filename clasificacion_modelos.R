library("mclust") #cargar biblioteca

data = read.table("/Volumes/HDD/Google Drive/wpbc.data",quote="\"", comment.char="|", na.strings="?", sep = ",")

colnames(data) = c("id", "c", "t ","r1", "t1", "p1", "a1", "su1",
                   "com1", "con1", "pc1", "si1", "df1",
                   "r2", "t2", "p2", "a2", "su2",
                   "com2", "con2", "pc2", "si2", "df2",
                   "r3", "t3", "p3", "a3", "su3",
                   "com3", "con3", "pc3", "si3", "df3",
                   "tt", "eg")

# colnames(data) = c("id", "clase", "tiempo ","radio_1", "textura_1", "perimetro_1", "area_1", "suavidad_1",
#                   "compacidad_1", "concavidad_1", "puntos_concavos_1", "simetria_1", "dimension_fractal_1",
#                   "radio_2", "textura_2", "perimetro_2", "area_2", "suavidad_2",
#                   "compacidad_2", "concavidad_2", "puntos_concavos_2", "simetria_2", "dimension_fractal_2",
#                   "radio_3", "textura_3", "perimetro_3", "area_3", "suavidad_3",
#                   "compacidad_3", "concavidad_3", "puntos_concavos_3", "simetria_3", "dimension_fractal_3",
#                   "tam_tumor", "est_ganglios")

#se eliminan registros con error
data <- na.omit(data)

#se modifica la ultima variable a numerica
data$eg = as.numeric(data$eg)

#Best BIC values:
#  EEE,1    EEV,1    VEV,1
#BIC      7406.545 7406.545 7406.545
#BIC diff    0.000    0.000    0.000

class=data$c
BIC=mclustBIC(data[,4:13], prior = priorControl(functionName="defaultPrior", shrinkage=0.1))


#graficar BIC
plot(BIC)

summary(BIC)
#Best BIC values:
#            EEE,1    EEV,1    VEV,1
#BIC      7406.545 7406.545 7406.545
#BIC diff    0.000    0.000    0.000

#            EEE,2    EEV,2    VEV,2
#BIC       7266.63  6103.41  6373.11

##### Nueva metrica
#Best BIC values:
#           VEV,2      EEV,2      VVV,2
#BIC      2050.101 2030.95272 1993.96287
#BIC diff    0.000  -19.14863  -56.13848

#son utilizados 2 grupos dado que en caso contrario no tendria sentido la clasificación
mod_eee=Mclust(data[,4:13], G = 2, modelNames = "EEE")
summary(mod_eee)
#Clustering table:
#  1   2 
#127  67 
table(class,mod_eee$classification)
# class   1   2
#     N 100  48
#     R  27  19
# error 75 casos

mod_eev=Mclust(data[,4:13], G = 2, modelNames = "EEV")
summary(mod_eev)
#Clustering table:
#  1   2 
#118  76 
table(class,mod_eev$classification)
# class  1  2
#     N 96 52
#     R 22 24
# error 74 casos
mod_vev=Mclust(data[,4:13], G = 2, modelNames = "VEV")
summary(mod_vev)
#Clustering table:
# 1   2 
#118  76

###Nueva tabla
#Clustering table:
#  1   2 
#  80 114 
table(class,mod_vev$classification)
# class  1  2
#     N 96 52
#     R 22 24
# error 74 casos

#es graficado un agrupamiento
plot(mod_eee, what = "classification") 
legend("bottomright", legend = 1:2, col = mclust.options("classPlotColors"), pch = mclust.options("classPlotSymbols"),title = "Class labels:")

#ver correlación de cada variable segun componentes principales
data.acp <- prcomp(data[4:35], scale = TRUE)

data.cor <- data.acp$rotation %*% diag(data.acp$sdev)

colors <- c("darkblue", "red", "green")
barplot(t(data.cor[, 1:3]), beside = TRUE, ylim = c(-1, 1), col = colors, xlab = "Variables", ylab = "Correlación", main = "Correlación CP y variables", las = 2)
legend("topright", legend = c("CP 1", "CP 2", "CP 3"), fill = colors)

#comparar metodo de agrupamiento por modelos con K-means
# Las 4 variaciones del algoritmo son: Lloyd, Forgy, MacQueen y Hartigan-Wong. 
# Para compararlas puede usarse la "distancia intracluster", que es la suma 
# de las distancia entre los centroide. El algoritmo que tenga la mayor 
# "distancia intracluster" sería el ganador ya que sería la mejor separación de grupos.

#https://www.youtube.com/watch?v=UwX4Ta78J0U
#algoritmos utilizados
algoritmos = c("Hartigan-Wong","Lloyd","Forgy","MacQueen") 
#cantidad de algorimos
cantidadAlgoritmos = length(Algoritmos) # guarda la cantidad de algoritmos usados
#para guardar las iteraciones de cada algotimo que será corrido 50 veces cada uno
iteraciones = data.frame(intraclase=numeric(),algoritmo=character())

#es corrido cada algorimo 50 veces y almacenado su valor de inercia interclase
#cada algorimo es corrido dado que se parte con puntos escogidos al azar
for (i in 1:cantidadAlgoritmos) 
{
  for (ii in 1:50) 
  {
    modelo      = kmeans(data[4:35],2, algorithm = algoritmos[i]) # 2 corresponde cantidad de grupos
    iteraciones = rbind(iteraciones,
                         data.frame(intraclase = modelo$betweenss,
                                    algoritmo = algoritmos[i]))
  }
}

#son sumados los valores obtenidos por cada algorimo
resultados = tapply(iteraciones$intraclase,iteraciones$algoritmo,mean) 
#son ordenados los promedios de las inercia entre clasesr
resultados = sort(resultados,decreasing = T)
algoritmoGanador = names(resultados[1])

#se ejecuta el algorimo ganador y se le asigna una clase a cada paciente
kmeansOptimizado = kmeans(data[4:35],2, algorithm = algoritmoGanador)

#comprobar funcionamiento del algorimo kmeans
table(class,kmeansOptimizado$cluster)

# class   1   2
#     N  48 100
#     R  23  23
# error en 71 casos
