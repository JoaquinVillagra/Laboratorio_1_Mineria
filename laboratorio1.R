#ESTADISTICA BASICA AL CONJUNTO DE DATOS EN ANEXO
#PAPER DE 6 HOJAS
#PRESENTACIÓN 

#ALUMNOS:
  ### IGNACIO IBÁÑEZ ALIAGA
  ### JOAQUÍN VILLAGRA PACHECO

######DESARROLLO DE ACTIVIDAD
### Análisis estadístico

Datos <- read.table("/Volumes/HDD/Google Drive/wpbc.data",quote="\"", comment.char="|", na.strings="?", sep = ",")

colnames(Datos)<- c("ID","Resultado","Tiempo(Resultado)","Radio1","Textura1","Perimetro1","Area1","Suavidad1","Compacidad1","Concavidad1","PuntosConcavos1","Simetria1","DimensionFractal1", "Radio2",
                    "Textura2","Perimetro2","Area2","Suavidad2","Compacidad2","Concavidad2","PuntosConcavos2","Simetria2","DimensionFractal2","Radio3","Textura3","Perimetro3","Area3","Suavidad3","Compacidad3",
                    "Concavidad3","PuntosConcavos3","Simetria3","DimensionFractal3","TamanoTumor", "GangliosLifanticos")
DatosSinID<- Datos[,-1] 
#DatosSinClase<- DatosSinClase[,-1] 
#Summary(DatosSinClase)

#Funcion para dibujar histogramas y los resumenes de los datos numericos
histogramMaker <- function(title, datos){
  mypath <- file.path("/Volumes/HDD/Google Drive/","SAVEHERE",paste("myplot_", title, ".jpg", sep = ""))
  print(title)
  print(summary(datos))
  jpeg(file=mypath)
  plot(table(datos),type = "h",xlab = title, ylab = "Frecuencia")
  hist(datos, col=colors,include.lowest = TRUE,breaks=20,main = paste("Histograma de" , title),density = 40)
  dev.off()
}

DatosSinID$Resultado<- as.character(DatosSinID$Resultado)
DatosSinID$Resultado[DatosSinID$Resultado=="R"] <- "Recurrente"
DatosSinID$Resultado[DatosSinID$Resultado=="N"] <- "No_Recurrente"

#Tests de normalidad
normRadio1 <- ks.test((Datos$Radio1), 
                   "pnorm",
                   mean(Datos$Radio1),
                   sd(Datos$Radio1))
