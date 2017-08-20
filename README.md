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

### Respecto al error de aproximación:
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


### ¿Qué es un Ganglio linfático?: https://es.wikipedia.org/wiki/Ganglio_linf%C3%A1tico

### Cirugía de ganglios linfáticos para el cáncer de seno

Si el cáncer de seno se propaga, a menudo suele hacerlo hacia los ganglios linfáticos cercanos. Saber si el cáncer se ha propagado a los ganglios linfáticos es útil pues esto ayuda a los médicos a determinar el tratamiento más adecuado para tratar la enfermedad.
Si usted ha sido diagnosticada con cáncer de seno, es importante saber hasta qué punto el cáncer se ha propagado. Para ayudar a averiguar si el cáncer se ha propagado fuera del seno, se extrae uno o más de los ganglios linfáticos ubicados debajo del brazo (ganglios linfáticos axilares) para examinarlos al microscopio. Conocer si el cáncer se ha propagado es una parte importante de la clasificación por etapas del cáncer. Además, cuando los ganglios linfáticos contienen células cancerosas, existe una mayor probabilidad de que las células cancerosas se hayan propagado a otras partes del cuerpo. Las decisiones sobre el tratamiento dependerán de si se encontró cáncer en los ganglios linfáticos.

La extirpación de ganglios linfáticos se puede hacer de diferentes maneras, dependiendo de si cualquier ganglio linfático está agrandado, de cuán grande es el tumor del seno y de otros factores.

### Biopsia de un ganglio linfático agrandado

Si cualquiera de los ganglios linfáticos que están debajo del brazo o alrededor de la clavícula está agrandado, se puede examinar directamente mediante una biopsia con aguja para saber si hay propagación del cáncer (ya sea mediante una biopsia por aspiración con aguja fina [FNA] o una biopsia por punción con aguja gruesa). Con menos frecuencia, el ganglio agrandado se extirpa mediante cirugía. Si se encuentra cáncer en el ganglio linfático, será necesario extraer más ganglios durante una disección de los ganglios linfáticos axilares (descrita a continuación).

### Tipos de cirugía de ganglios linfáticos

Aun cuando los ganglios linfáticos cercanos no estén agrandados, será necesario verificar si tienen cáncer. Esto se puede hacer de distintas maneras. La biopsia de ganglio centinela es la forma más común y menos invasiva, pero en algunos casos puede necesitarse una disección de ganglios linfáticos axilares más extensa.

A menudo, la cirugía de los ganglios linfáticos se hace como parte de la cirugía principal para extraer el cáncer de seno, aunque en algunos casos se puede hacer como una operación separada.

### Biopsia del ganglio linfático centinela

En una biopsia de ganglio centinela, el cirujano identifica y extrae el primer ganglio linfático a donde probablemente se propagó el cáncer (a este se le conoce como ganglio centinela). Para hacer esto, el cirujano inyecta una sustancia radiactiva y/o un colorante azul en el tumor, el área alrededor del tumor o el área alrededor del pezón. Los vasos linfáticos llevarán estas sustancias por la misma vía que el cáncer probablemente va a tomar. El ganglio centinela será aquel ganglio linfático al que primero llegue el colorante o la sustancia radiactiva.

Después de inyectar la sustancia, el ganglio centinela se puede encontrar mediante el uso de un dispositivo especial para detectar radiactividad en los ganglios o mediante la identificación de los ganglios que se tornaron azules. A menudo se usan ambos métodos para hacer una revisión. El cirujano corta la piel sobre el área y extirpa el ganglio (o los ganglios) que contienen el colorante o la radiación.

Luego un médico (patólogo) examina minuciosamente los ganglios linfáticos que se extrajeron (a menudo 2 o 3 ganglios) para saber si tienen células cancerosas.  A veces esto se hace durante la cirugía. De esta manera, si el cáncer se encuentra en el ganglio centinela, el cirujano puede hacer una disección axilar completa para extirpar más ganglios linfáticos. Por otro lado, si no se observan células cancerosas en los ganglios linfáticos al momento de la cirugía, o si el ganglio centinela (o ganglios centinelas) no fue examinado por el patólogo al hacer la cirugía, se examinarán más detenidamente durante los próximos días.

Si luego se encuentra cáncer en el ganglio linfático, el cirujano puede recomendar una disección de los ganglios linfáticos axilares completa en una fecha posterior para saber si hay cáncer en otros ganglios. Recientemente, sin embargo, algunos estudios muestran que en algunos casos, puede que sea igualmente seguro no extirpar el resto de los ganglios linfáticos. Esto se basa en ciertos factores, tal como el tamaño del tumor del seno, el tipo de cirugía que se empleó para extraer el tumor, y el tratamiento que se planeó para después de la cirugía. Basándose en los estudios que se han hecho sobre esto, omitir la disección de ganglios linfáticos axilares es solo una opción para mujeres con tumores que miden 5 cm (2 pulgadas) o menos que se someten a una cirugía de conservación de seno seguida de radiación. Debido a que este asunto no se ha estudiado bien en mujeres que se han sometido a mastectomía, no está claro si omitir la disección de ganglios linfáticos axilares sería seguro para ellas.

Si no hay cáncer en los ganglios centinelas, es muy poco probable que el cáncer se haya propagado a otros ganglios linfáticos.  Por lo tanto, no es necesario realizar más cirugía de los ganglios linfáticos.

Aunque la biopsia del ganglio linfático centinela se ha convertido en un procedimiento común, esta requiere de mucha destreza. Sólo debe hacerse por un cirujano que tenga experiencia en esta técnica. Si usted está considerando este tipo de biopsia, pregúntele a los miembros de su equipo de atención médica si es un procedimiento que ellos hacen

### Disección de ganglios linfáticos axilares

En este procedimiento, se extirpan entre 10 y 40 (aunque usualmente menos de 20) ganglios linfáticos del área debajo del brazo (axila) y se examinan para determinar si existe propagación del cáncer. Por lo general, la disección de ganglios linfáticos axilares se puede hacer al mismo tiempo que la mastectomía o la cirugía con conservación del seno, aunque también se puede realizar en una segunda operación. En el pasado, ésta era la manera más común de verificar si había propagación del cáncer de seno a los ganglios linfáticos adyacentes, y aún puede que se necesite en algunas ocasiones. Por ejemplo, se puede hacer una disección de ganglios linfáticos axilares si una biopsia previa mostró que uno o más de los ganglios linfáticos axilares tiene células cancerosas.

### Efectos secundarios de la cirugía de los ganglios linfáticos

Como en cualquier operación, es posible que se presente dolor, sangrado, hinchazón, coágulos sanguíneos e infecciones.

- Linfedema

	Un posible efecto secundario a largo plazo de una cirugía de ganglios linfáticos es la hinchazón en el brazo o el pecho, llamado linfedema. Debido a que cualquier exceso de líquido en los brazos normalmente regresa al torrente sanguíneo a través del sistema linfático, la extirpación de los ganglios linfáticos algunas veces bloquea el drenaje del brazo, lo que causa la acumulación de este líquido.


	Esto es menos común después de una biopsia del ganglio linfático centinela que de una disección de ganglios linfáticos axilares.

	Hasta el 30% de las mujeres a quienes se les hace una disección de ganglios linfáticos axilares padece linfedema. Además, también ocurre en hasta el 3% de las mujeres sometidas a una biopsia de ganglio centinela. Puede que sea más común si la radiación se administra después de la cirugía. Algunas veces se presenta una hinchazón que dura sólo unas pocas semanas y luego desaparece. Pero en algunas mujeres, la hinchazón puede durar por mucho tiempo. Si su brazo está hinchado, o se siente oprimido o duele después de la cirugía de los ganglios linfáticos, asegúrese de notificarlo inmediatamente a algún miembro de su equipo de atención médica contra el cáncer.

- Movimiento limitado del brazo y del hombro

	Es posible que también tenga limitaciones en el movimiento del brazo y el hombro después de la cirugía. Esto es más común después de una disección de ganglios linfáticos axilares que después de una biopsia del ganglio linfático centinela. Puede que su médico le aconseje hacer ejercicios para ayudar a evitar que presente problemas permanentes (un hombro “congelado”).

	Algunas mujeres notan una estructura parecida a una cuerda que comienza debajo del brazo y se puede extender hasta el codo, lo que a veces se conoce como adherencia cicatrizal o cordones linfáticos.    Esto es más común después de una disección de ganglios linfáticos axilares que una biopsia del ganglio linfático centinela. Es posible que los síntomas no aparezcan por semanas o incluso meses después de la cirugía. Puede causar dolor y limitar el movimiento del brazo y hombro. A menudo, este problema desaparece sin necesidad de tratamiento, aunque algunas mujeres podrían beneficiarse de la terapia física.

- Adormecimiento

	El adormecimiento de la piel en la porción superior interna del brazo es un efecto secundario común, ya que los nervios que controlan esta sensación en este lugar viajan a través del área de los ganglios linfáticos

