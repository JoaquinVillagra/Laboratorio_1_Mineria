# Laboratorio 1: Taller Minería de datos avanzada

## Integrantes
- Ignacio Ibáñez Aliaga
- Joaquín Villagra Pacheco

## Descripción de la experiencia
### Objetivos:
- Definir el problema a resolver mediante el conjunto de datos seleccionado
- Estudiar e interpretar los datos correspondientes a cada base de datos.
o Para ello es necesario explicar de forma detallada el significado de clases,
atributos y sus instancias, lo que permitirá obtener el correcto análisis del
problema planteado.
- Brindar una solución mediante el uso de métodos de agrupamientos basados en modelos
(Mcluster)

## Características del DataSet

- Número de instancias: 198

- Número de atributos: 34 (ID, resultado, 32 características de entrada real)

### Variables
- Número de identificación
- Resultado (R = recurrente, N = no recurrente)
- Tiempo (tiempo de recurrencia si campo 2 = R, tiempo libre de enfermedad si
Campo 2 = N)
- Se calculan diez características de valor real para cada núcleo de célula:
	- radio (media de las distancias desde el centro hasta los puntos del perímetro)
	- textura (desviación estándar de los valores de la escala de grises)
	- perímetro
	- área
	- suavidad (variación local en longitudes de radio)
	- compacidad (perímetro ^ 2 / área - 1,0)
	- concavidad (gravedad de las partes cóncavas del contorno)
	- puntos cóncavos (número de partes cóncavas del contorno)
	- simetría
	- dimensión fractal ("aproximación de la costa" - 1)

La media, error estándar, y "peor" o más grande (media de los tres valores más grandes) de estas características se calcularon para cada imagen, resultando en 30 características. Por ejemplo, el campo 4 es Mean Radius, campo 14 es el radio SE, el campo 24 es e peor Radio.


### Respecto al error de aproximación:
- Los valores de características 4 - 33 son recodificados con cuatro dígitos significativos.

### Definiciones faltantes
34) El tamaño del tumor - diámetro del tumor extirpado en centímetros.
35) El estado de los ganglios linfáticos - número de ganglios linfáticos axilares positivos observado en el momento de la cirugía.

### Valores de atributos que faltan: 

Estado de los ganglios linfáticos (V35) no se encuentra en 4 casos.


### Información relevante del contexto del dataset
Cada registro representa datos de seguimiento de un caso de cáncer de mama. 
Estos pacientes han sido vistos consecutivamente por el Dr. Wolberg desde 1984, e incluyen sólo aquellos casos que presentan
Cáncer de mama y ninguna evidencia de metástasis a distancia al momento del diagnóstico.

Las primeras 30 características se calculan a partir de una imagen digitalizada de una
aspiración con aguja fina (FNA) de una masa mamaria. Ellos describen características de los núcleos celulares presentes en la imagen.
Algunas de las imágenes se pueden encontrar en Http://www.cs.wisc.edu/~street/images/

La separación descrita anteriormente se obtuvo usando
Múltiples superficies Método-Árbol (MSM-T) [K. P. Bennett, "Árbol de decisión
Construcción a través de la programación lineal ".
Midwest Inteligencia Artificial y Sociedad de Ciencia Cognitiva,
Pp. 97-101, 1992], un método de clasificación que utiliza
Programación para construir un árbol de decisión. Características relevantes
Fueron seleccionados utilizando una búsqueda exhaustiva en el espacio de 1-4
Características y 1-3 planos de separación.

El programa lineal real utilizado para obtener el plano de separación
En el espacio tridimensional es la descrita en: 
[K. P. Bennett y O. L. Mangasarian: "Robust Linear
Programación de la discriminación de dos conjuntos linealmente inseparables ",
Optimization Methods and Software 1, 1992, 23 - 34].

El método de aproximación de superficie de recurrencia (RSA) es un método lineal
Modelo de programación que predice el tiempo de recurrencia utilizando ambos tipos de cancer Recurrentes y no recurrentes. 

