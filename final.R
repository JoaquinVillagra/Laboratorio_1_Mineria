library("rgl")

data = read.table("wpbc.data", sep = ",")

colnames(data) = c("id", "c", "t","r1", "t1", "p1", "a1", "su1",
                   "com1", "con1", "pc1", "si1", "df1",
                   "r2", "t2", "p2", "a2", "su2",
                   "com2", "con2", "pc2", "si2", "df2",
                   "r3", "t3", "p3", "a3", "su3",
                   "com3", "con3", "pc3", "si3", "df3",
                   "tt", "eg")

#se elimina la columnas estimadores ganclios que no aporta al proceso de clasificación
data$eg = NULL

#se transforma la clase a una variable numerica
data$c = ifelse(data$c == "N", 1, data$c)
data[3] <- lapply(data[3], as.numeric)

#Es necesario obtener el promedio de los pacientes que recaen en el cancer
promedio = mean(subset(data$t, data$c == 2))
#por lo tanto son filtrados aquellos pacientes que estan sobre el promedio de tiempo
#dado que de lo contrario no existe un suficiente seguimiento para poder catagorizar
#y del mismo modo se obtiene a los pacientes que recayeron en el cancer que estan sobre 
#ese periodo de tiempo, para poder comparar pacientes que se encuentran frente a similares
#circunstancias
data_1 = subset(data, (c == 1 & t > promedio) | (c == 2))
#es calculada la cantidad de pacientes que pertenecen a cada grupo
N = sum(data_1$c == 1)
R = sum(data_1$c == 2)

#realizamos un shapiro-test para comprobar normalidad pero diferenciando entre los pacientes 
#recurrentes y normales

p_value_test = data.frame(Variable = character() ,N=numeric(),R=numeric(), normal = numeric())

for (i in 1:31)
{
  n = shapiro.test(subset(data_1[,4:34][,i], data_1$c == 1))
  r = shapiro.test(subset(data_1[,4:34][,i], data_1$c == 2))
  p_value_test = rbind(p_value_test, data.frame(Variable = names(data_1[,4:34][i]), N = as.numeric(n[2]), R = as.numeric(r[2]), normal = ifelse(as.numeric(n[2])>=0.05 & as.numeric(r[2])>=0.05,1,0)))
}

#con los datos obtenimos antes realizamos 2 pruebas unas parametricas y otras no parametricas
#para identificar si existen diferencias significativas entre las medias

#Lo que acabamos de hacer es ver las caracteristicas en donde existen diferencias 
#significativas en cuanto a los diferentes tipos de pacientes

#ahora aplicamos t-student en caso de ser variables normales o
#wilcox.test en caso de correspoder a no normales
p_rangos = data.frame(Variable = character() ,p = numeric(), distinta = numeric())

for (i in 1:31)
{
  if(p_value_test[i,4] == 1){
    p = t.test(subset(data_1[,4:34][,i], data_1$c == 1), subset(data_1[,4:34][,i], data_1$c == 2))[3]
  }else{
    p = wilcox.test(subset(data_1[,4:34][,i], data_1$c == 1), subset(data_1[,4:34][,i], data_1$c == 2))[3]
  }
  if(p < 0.05){
     p_rangos = rbind(p_rangos, data.frame(Variable = names(data_1[,4:34][i]), p = as.numeric(p), distinta = 1))
  }
}

#p_rangos se encuentran todas las variables que presentan una variación con respecto a su
#media comparando personas sin recurrencia y con recurrencia obteniendo las siguientes:
#'r1','p1','a1','df1','r2','p2','a2','r3','p3','a3','tt'

########################
# ANALISIS DE CP
########################
cor(data_1[,4:24])

#se colocan enuna escala los datos
scale_datos = scale(data_1[4:34])

#son obtenidas las componentes principales
acp = prcomp(scale_datos)

# Importance of components%s:
#                           PC1    PC2    PC3    
# Standard deviation     3.0201 2.9371 1.8526
# Proportion of Variance 0.2942 0.2783 0.1107
# Cumulative Proportion  0.2942 0.5725 0.6832

#################################################################################
#Al analizar las componentes principales son extraidas la o las caracteristicas
#mas representativas de cada componente
#es decir que tenga una magnitud alta en la CP que representa y un valor bajo en 
#el resto de CP
#################################################################################

#         PC1 =pc1    PC2 = su1   PC3 = t2 
#                     PC2 = df1      
# r1   -0.230022970 -0.22139866  0.05677311 
# t1   -0.005856311 -0.02788850 -0.03562143 
# p1   -0.245858511 -0.20362128  0.06029680 
# a1   -0.233398962 -0.22096355  0.06391996
# su1  -0.095742265  0.22913751  0.05838447
# com1 -0.226029073  0.21631297  0.07926230
# con1 -0.280776457  0.11641229  0.05885263
# pc1  -0.295294678  0.01309505  0.08570744
# si1  -0.114981525  0.20528853  0.07883374
# df1  -0.071711942  0.29956455  0.04765962
# r2   -0.243276339 -0.11159317 -0.18467411 
# t2   -0.025936431  0.05592720 -0.32442886
# p2   -0.251067829 -0.09064348 -0.19758318
# a2   -0.252643718 -0.15168215 -0.09712582
# su2  -0.053284771  0.10035603 -0.39784885
# com2 -0.157991169  0.20964926 -0.18475209
# con2 -0.167535135  0.17059907 -0.26349981
# pc2  -0.178884559  0.08299739 -0.38239319
# si2  -0.095556094  0.12982984 -0.21115110
# df2  -0.135323376  0.22895608 -0.19559324
# r3   -0.241894486 -0.20866130  0.12204162
# t3    0.033096167  0.01976332  0.06688590
# p3   -0.258380105 -0.18739869  0.12086025
# a3   -0.236220924 -0.20763751  0.12319662
# su3  -0.019039802  0.22438233  0.16607681
# com3 -0.122480399  0.24404364  0.19858526
# con3 -0.158281175  0.20855370  0.19372694
# pc3  -0.242126496  0.10303631  0.21827645
# si3  -0.038936859  0.19914097  0.19249340
# df3  -0.043455160  0.28162400  0.18517497
# tt   -0.028865225 -0.06142160  0.08581912

#graficar componentes principales
colors <- c("black", "gray", "White")
barplot(t(acp[[2]][,1:3]), beside = TRUE, ylim = c(-1, 1), col = colors, xlab = "Variables", ylab = "Covarianza", main = "Covarianza CP y variables", las = 2)
legend("topright", legend = c("CP 1", "CP 2", "CP 3"), fill = colors)

#con variables relevantes ya claras es posible aplicar el metodo de agrupamiento 
#segun modelos
BIC=mclustBIC(data_1[,c('r1','p1','a1','r2','p2','a2','r3','p3','a3','tt', 'su1','t2','df1','pc1')], prior = priorControl(functionName="defaultPrior", shrinkage=0.1))
mod=Mclust(data_1[,c('r1','p1','a1','r2','p2','a2','r3','p3','a3','tt', 'su1','t2','df1','pc1')], G = 2, x=BIC)
plot(BIC)
# Best BIC values:
#             VEV,2       EEV,2      VVV,2
# BIC      -1310.748 -1402.03341 -1453.9144
# BIC diff     0.000   -91.28547  -143.1665
tabla = table(data_1$c,mod$classification)
print(tabla)
#    1  2
# 1 73 38
# 2 17 30



#se realiza la comparativa con el algoritmo de las k-means
data_kmeans <- kmeans(data_1[,c('r1','p1','a1','r2','p2','a2','r3','p3','a3','tt', 'su1','t2','df1','pc1')], 2, nstart = 20)
tabla = table(scale_datos$c,data_kmeans$cluster)
print(tabla)
#    1  2
# 1 77 34
# 2 23 24

#graficar k-means
pc = princomp(data_1[,4:34], cor=TRUE, scores=TRUE)
data_kmeans_3d$cluster = as.factor(data_kmeans$cluster)
plot3d(pc$scores[,1:3], col=data_kmeans$cluster, main="K-Means")

#graficar especies actual
plot3d(pc$scores[,1:3], col=data_1[,2], main="Actual clasificación")

#graficar agrupamiento por modelos
plot3d(pc$scores[,1:3], col=mod$classification, main="Clasificación por modelos VEV")
