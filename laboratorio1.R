#ESTADISTICA BASICA AL CONJUNTO DE datos EN ANEXO
#PAPER DE 6 HOJAS
#PRESENTACIÓN 

#ALUMNOS:
  ### IGNACIO IBÁÑEZ ALIAGA
  ### JOAQUÍN VILLAGRA PACHECO

######DESARROLLO DE ACTIVIDAD
### Análisis estadístico
require(cluster)
require(stats)
library(factoextra)
library(NbClust)
library(fpc)

datos <- read.table("/Volumes/HDD/Google Drive/wpbc.data",quote="\"", comment.char="|", na.strings="?", sep = ",")
#datos <- read.table("/home/joaqunv/Escritorio/Laboratorio_1_Mineria/wpbc.data",quote="\"", comment.char="|", na.strings="?", sep = ",")

colnames(datos)<- c("ID","Resultado","Tiempo(Resultado)","Radio1","Textura1","Perimetro1","Area1","Suavidad1","Compacidad1","Concavidad1","PuntosConcavos1","Simetria1","DimensionFractal1", "Radio2",
                    "Textura2","Perimetro2","Area2","Suavidad2","Compacidad2","Concavidad2","PuntosConcavos2","Simetria2","DimensionFractal2","Radio3","Textura3","Perimetro3","Area3","Suavidad3","Compacidad3",
                    "Concavidad3","PuntosConcavos3","Simetria3","DimensionFractal3","TamanoTumor", "GangliosLifanticos")
datosSinID<- datos[,-1]
#datosSinClase<- datosSinClase[,-1] 
#Summary(datosSinClase)

#Funcion para dibujar histogramas y los resumenes de los datos numericos
histogramMaker <- function(title, datos){
  mypath <- file.path("//","SAVEHERE",paste("myplot_", title, ".jpg", sep = ""))
  print(title)
  print(summary(datos))
  jpeg(file=mypath)
  plot(table(datos),type = "h",xlab = title, ylab = "Frecuencia")
  hist(datos, col=colors,include.lowest = TRUE,breaks=20,main = paste("Histograma de" , title),density = 40)
  dev.off()
}

datosSinID$Resultado<- as.character(datosSinID$Resultado)
datosSinID$Resultado[datosSinID$Resultado=="R"] <- "Recurrente"
datosSinID$Resultado[datosSinID$Resultado=="N"] <- "No_Recurrente"

#Tests de normalidad
normRadio1 <- ks.test((datos$Radio1), 
                   "pnorm", 
                   mean(datos$Radio1),
                   sd(datos$Radio1))

recurrentes = datos$Resultado == 'N'
datos = datos[!recurrentes,]

recurrentes = datos$ID == '?'
datos = datos[!recurrentes,]
datos = datos[,!recurrentes]

resumen <- summary(datos$`Tiempo(Resultado)`)
print(resumen)
boxplot(resumen, main="Pacientes Recurrentes", ylab="Tiempo [Meses]")

#Para No recurrentes
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#1.00   21.50   55.00   53.47   76.00  125.00 

#Para recurrentes
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#1.00    9.00   16.00   25.09   36.50   78.00 
datos.numericos<-datosSinID[,-1]
str(datos.numericos)
scale.datos.filtrados<- scale(datos.numericos) # Estandarizando variables
mydata<-scale.datos.filtrados

##Algoritmo usando pam para obtener el mejor numero de cluster (Silueta)
asw <- numeric(18)
for (k in 2:18)
  asw[k] <- pam(mydata, k) $silinfo $widths
k.elegido <- which.max(asw)
cat("numero de cluster determinado por silhouette-anchura:", k.elegido, "\n")
plot(2:18, asw, type="b")

matriz_distance<-dist(datosSinID, method = "euclidean", diag = FALSE, upper = FALSE, p = 2)

#Gráfica en dimensiones
importantdata<-cmdscale(matriz_distance, eig=TRUE, k=k.elegido)

fit <- kmeans(mydata, 2) # cluster solution
# get cluster means 
aggregate(mydata,by=list(fit$cluster),FUN=mean)
# append cluster assignment
mydata<- data.frame(mydata, fit$cluster)
clusplot(mydata, fit$cluster, color=TRUE, shade=TRUE, lines=0, main="Cluster", xlab="Componente 1", ylab="Componente 2")

grupo<-fit$cluster[which(fit$cluster== 1)]
nombre <- nombres(grupo)
grupo.data<-data.frame(datos[strtoi(nombre), ])
cat("\n\n########## GROUP :", 1, "##########\n")
print(summary(grupo.data))

grupo<-fit$cluster[which(fit$cluster== 2)]
nombre <- nombres(grupo)
grupo.data<-data.frame(datos[strtoi(nombre), ])
cat("\n\n########## GROUP :", 2, "##########\n")
print(summary(grupo.data))

