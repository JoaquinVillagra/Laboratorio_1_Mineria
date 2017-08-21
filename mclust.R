library("mclust") #cargar biblioteca

data = read.table("wpbc.data", sep = ",")

#colnames(data) = c("id", "clase", "tiempo ","radio_1", "textura_1", "perimetro_1", "area_1", "suavidad_1", 
#                   "compacidad_1", "concavidad_1", "puntos_concavos_1", "simetria_1", "dimension_fractal_1", 
#                   "radio_2", "textura_2", "perimetro_2", "area_2", "suavidad_2", 
#                   "compacidad_2", "concavidad_2", "puntos_concavos_2", "simetria_2", "dimension_fractal_2",
#                   "radio_3", "textura_3", "perimetro_3", "area_3", "suavidad_3", 
#                   "compacidad_3", "concavidad_3", "puntos_concavos_3", "simetria_3", "dimension_fractal_3",
#                   "tam_tumor", "est_ganglios")

colnames(data) = c("id", "c", "t ","r1", "t1", "p1", "a1", "su1", 
                   "com1", "con1", "pc1", "si1", "df1", 
                   "r2", "t2", "p2", "a2", "su2", 
                   "com2", "con2", "pc2", "si2", "df2",
                   "r3", "t3", "p3", "a3", "su3", 
                   "com3", "con3", "pc3", "si3", "df3",
                   "tt", "eg")

#data$perimetro_1 = NULL
#data$area_1 = NULL
#data$compacidad_1 = NULL
#data$concavidad_1 = NULL
#data$puntos_concavos_1 = NULL
#data$simetria_1 = NULL
#data$dimension_fractal_1 = NULL

#data$perimetro_2 = NULL
#data$area_2 = NULL
#data$compacidad_2 = NULL
#data$concavidad_2 = NULL
#data$puntos_concavos_2 = NULL
#data$simetria_2 = NULL
#data$dimension_fractal_2 = NULL

#data$perimetro_3 = NULL
#data$area_3 = NULL
#data$compacidad_3 = NULL
#data$concavidad_3 = NULL
#data$puntos_concavos_3 = NULL
#data$simetria_3 = NULL
#data$dimension_fractal_3 = NULL

#se eliminan registros con error
error = data$eg == '?'
data = data[!error,]

#se calcula la cantidad de pacientes que pertenecen a cada clase
N = sum(data$clase == 'N')
R = sum(data$clase == 'R')

#se modifica la ultima variable a numerica
data$eg = as.numeric(data$eg)

#comprobar que las variables sigan una distribucion normal
radio_1.test = shapiro.test(data$radio_1)
textura_1.test = shapiro.test(data$textura_1)
perimetro_1.test = shapiro.test(data$perimetro_1)
area_1.test = shapiro.test(data$area_1)
suavidad_1.test = shapiro.test(data$suavidad_1)
compacidad_1.test = shapiro.test(data$compacidad_1)
concavidad_1.test = shapiro.test(data$concavidad_1)
puntos_concavos_1.test = shapiro.test(data$puntos_concavos_1)
simetria_1.test = shapiro.test(data$simetria_1)
dimension_fractal_1.test = shapiro.test(data$dimension_fractal_1)

radio_2.test = shapiro.test(data$radio_2)
textura_2.test = shapiro.test(data$textura_2)
perimetro_2.test = shapiro.test(data$perimetro_2)
area_2.test = shapiro.test(data$area_2)
suavidad_2.test = shapiro.test(data$suavidad_2)
compacidad_2.test = shapiro.test(data$compacidad_2)
concavidad_2.test = shapiro.test(data$concavidad_2)
puntos_concavos_2.test = shapiro.test(data$puntos_concavos_2)
simetria_2.test = shapiro.test(data$simetria_2)
dimension_fractal_2.test = shapiro.test(data$dimension_fractal_2)

radio_3.test = shapiro.test(data$radio_3)
textura_3.test = shapiro.test(data$textura_3)
perimetro_3.test = shapiro.test(data$perimetro_3)
area_3.test = shapiro.test(data$area_3)
suavidad_3.test = shapiro.test(data$suavidad_3)
compacidad_3.test = shapiro.test(data$compacidad_3)
concavidad_3.test = shapiro.test(data$concavidad_3)
puntos_concavos_3.test = shapiro.test(data$puntos_concavos_3)
simetria_3.test = shapiro.test(data$simetria_3)
dimension_fractal_3.test = shapiro.test(data$dimension_fractal_3)


#estandarizar los datos
rangos = sapply(data[4:35], range)
maxMin = rangos[2,]-rangos[1,]
data2 = scale(data[4:35], rangos[1,], ifelse(maxMin>0, maxMin, 1))
mod_1 = Mclust(data2, G = 2, modelNames = 'EEE') 

#son cambiadas las clases asignadas con un numero por una letra
mod1$classification = ifelse(mod1$classification == 1, 'N', mod1$classification)
mod1$classification = ifelse(mod1$classification == 2, 'R', mod1$classification)
print(sum(mod1$classification == data[2])) #se obtiene la cantidad de casos categorizados correctamente

#serán calculadas las componentes principales
#cor(data[,4:35]) #verificamos que la matriz de correlación cotenga correlaciones altas
#pcal#obtenemos las componentes principales
#summary(pcal)
#pca2 = pcal$x[,1:3] #usamos los primeros 3 componentes principales
###########################################################################
#########################COMPONENTES PRINCIPALES###########################
###########################################################################
acp.cov = prcomp(data2[,1:32]) #matriz de covarianzas
diag(1/sqrt(diag(cov(data2[,1:32])))) %*% acp.cov$rotation %*% diag(acp.cov$sdev) #correlacion entre variables y componentes

acp = prcomp(data2[,1:32], scale = TRUE) #matriz de correlación
summary(acp) #visualizar significancia de cada componnete principal
#se puede notar que considerando las 9 primeras componentes se obtiene un valor de 0.91411

corvar = acp$rotation %*% diag(acp$sdev) #correlación entre variables y componentes

#graficos
#grafico de barras para correlación CP y variables
barplot(t(corvar[, 1:3]), beside = TRUE, ylim = c(-1, 1))

#con los datos obtenidos antes
#variables a eliminar son
#t1,t2,t3,tt,eg

data$t1 = NULL
data$t2 = NULL
data$t2 = NULL
#data$tt = NULL
data$eg = NULL

mod_2 = Mclust(data[,4:32], G = 2, modelNames = 'EEE') 
#son cambiadas las clases asignadas con un numero por una letra
mod_2$classification = ifelse(mod_2$classification == 1, 'N', mod_2$classification)
mod_2$classification = ifelse(mod_2$classification == 2, 'R', mod_2$classification)
print(sum(mod_2$classification == data[2])) #se obtiene la cantidad de casos categorizados correctamente
