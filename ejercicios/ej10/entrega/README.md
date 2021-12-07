# Enunciado Trabajo Práctico 10

Simulación del código RTL del sistema completo.


## Objetivo

Familiarizarse con sistema completo, incluyendo:
- Modem
- Emulador d canal
- Unidad de control
- FIFOs
- UART


## Diagramas en bloque

A continuación se muestra el diagrama en bloques general:

![Diagrama en bloques del sistema](Imagenes/BD-system.jpg)

![Diagrama en bloques del sistema](Imagenes/BD-system_top.jpg)

Las características del sistema son:
Modulación 2_PAM en banda base, sin codificación de línea,frecuencia de 
símbolo de 1MHz y frecuencia de sampleo de 16MHz.
Tipo de pulso es raiz de coseno elevado, con energía constante unitaria.

El sistema se conecta por una UART a 115200 baudios tanto como para transmitir 
como para recibir, sin paridad, con 8 bits de datos y un bot de stop.


### El moden está compuesto por dos bloques(modulador y el demodulador):

![Modem](Imagenes/BD-bb_modem.jpg)

Las señales que controlan al moden provinen del bloque de "Registros de 
configuración y GPIO"

+ La transmisión es asindrónica con un preámbulo de sincronización(setado en **nm1_pre_i=15**) 
y delimitador de trama(seteado para dos bits --> **nm1_sfd_i=1**) configurable.

+ Para poder transmitir se tiene que tener una cierta cantidad de bytes, 
esa cantidad se puede configurar, en la actualidad está configurado 
para 4 bytes(**nm1_bytes_i=3**).


+ La señal **send_i**, indica cuando comienza una transmisión.

+ La señal **tx_rdy_o**, indica cuando el moden está listo para transmitir
con esta entrada en 1 y un flanco ascente en  send_i comienza a Tx(transamitir).

### El canal se conecta con el modem mediante dos interfaces(conversores **ADC** y **DAC**), ambos con 10bits de datos en formato **Q10.8**, con 
 indicación de ***underflow*** y ***overflow***. El **ADC** y el **DAC**
 poseen un clock común.

![Canal](Imagenes/BD-bb_channel.jpg)

+ El canal simula un ruido blanco aproximadamente Gaussiano configurable 
mediante la variable **sigma_i**.
+ La respuesta en frecuencia está implementada mediante un FIR de largo 
configurable.



## Descripción

En este ejercicio se debe simular el sistema completo, para ello:
1. Ya se cuenta con el test creado, se llama `tb_top_edu_bbt`.
2. Se debe simular el sistema completo.
3. Se debe entender el funcionamiento del sistema completo.
4. Se debe realizar una explicación del funcionamiento de cada bloque.
    Para ello ayudarse mediante capturas de las señales necesariar.
5. Se debe realizar una explicación del funcionamiento del sistema completo.
    Para ello ayudarse mediante capturas de las señales necesariar.
6. Se debe incluir una explicación y capturas que muestren los problemas
    que existen en la sincronización, al no estar en presencia de
    cambios en las señales.
    Por ejemplo, comparando como se degradan las señales de sincronización
    en un caso con muchos cambios y en un caso con pocos.
7. Todo el contenido se debe volcar en un informe breve.


## Entrega

La entrega se realiza directamente en la carpeta del repositorio.
El informe puede ser directamente el archivo `README.md` de la carpeta
de entrega o bien un archivo pdf.
Si la entrega es mediante un archivo pdf, entonces se debe incluir un
link al archivo en el `README.md` de la entrega.

**No es necesario que el informe sea una maravilla literaria, ni que su
presentación sea impecable, pero si debe ser claro y fácil de leer.**

Los alumnos son libres de incluir cualquier otro tipo de información que deseen.

