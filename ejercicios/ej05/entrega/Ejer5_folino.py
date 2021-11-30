###########################################################################
# Materia: Sistemas Digitales para las comuunicaciones
#
# Carrera: MSE-FIUBA
#
# Autor: Pablo D. Folino <pfolino@gmail.com>
#
# Ejercicio 3
#
###########################################################################


import matplotlib.pyplot as plt
import numpy as np
import scipy.signal as sc
from scipy.signal.wavelets import morlet2
import simpleaudio as sa
import os


k=8                     # Cantidad de bits para la codificación
b=[1,0,1,0,1,0,0,1]     # Binario por default paar testear(puede ser randon)
M=2**k                  # Niveles posibes de codificación
Ts=0.0625               # Tiempo de sampling en useg
m_inic=8                # Cantidad de muestras
m=m_inic
Tb=Ts*m                 # Tiempo de símbolo 
amp= 1.0                # Ampitud de la señal
temp=np.zeros(m**2) 

dk=[]                   # Señal d[k]
xk=[]                   # Señal x[k]
nk=[]                   # Señal n[k]

ts=np.arange(m*k)*Ts    # Tiempo de sampling de los bits
tspk=np.arange(m)*Ts    # Tiempo de sampling de la señal p[k]

# Para el coseno elevado
beta=0.5
tspk_c=np.arange(-m*3,m*3)*Ts   # Se adopta 3 lóbulos del coseno elevado



def coseno_elevado():
    global tspk_c,beta,Tb
    fx_temp=np.sinc((tspk_c/Tb))*(np.cos(np.pi*tspk_c*beta/Tb))/(1-(2*beta*tspk_c/Tb)**2)
    
    for i in range(len(fx_temp)):
       if(fx_temp[i]==float("inf")):
            fx_temp[i]=np.pi*np.sinc(1/(2*beta))/(4*Tb)

    return fx_temp  

def raise_coseno_elevado():
    global tspk_c,beta,Tb
    
    a = sin(pi*t/Tsymb*(1-Beta)) + 4*Beta*t/Tsymb.*cos(pi*t/Tsymb*(1+Beta))
    b = pi*t/Tsymb.*(1-(4*Beta*t/Tsymb).^2)
    y = 1/Tsymb*a./b
    y(t==0) = 1/Tsymb*(1+Beta*(4/pi-1))
    y(t==Tsymb/4/Beta) = Beta/Tsymb/sqrt(2)*((1+2/pi)*sin(pi/4/Beta)+(1-2/pi)*cos(pi/4/Beta))
    y(t==-Tsymb/4/Beta) = Beta/Tsymb/sqrt(2)*((1+2/pi)*sin(pi/4/Beta)+(1-2/pi)*cos(pi/4/Beta))
    return fx_temp


def cantidad_bits():
    global k,b,M,m,ts,tspk,Tb,Ts,tspk_c,m_inic
    os.system("clear")
    print("La cantidad de muestras son: {} ".format(m))
    print("Secuencia de bits-> {}".format(b))
    print("Los mensajes posibles son M={}".format(M))
    consulta=input("Seleccione 1->(8 muestras) o 2->(16 muestras): ")
    if (consulta=='1'):
        m=8
    elif (consulta=='2'):
        m=16
    else:
        print("ERROR")
    
    M=2**k
    Tb=Ts*m                                 # Recalculo el tiempo de símbolo
    tspk=np.arange(m)*Ts                    # Recalculo el tiempo de sampling de la señal p[k]
    tspk_c=np.arange(-m*3,m*3)*Ts           # Recalculo, se adopta 3 lóbulos del coseno elevado
    ts=np.arange(m*k)*Ts                    # Recalcualo el tiempo de sampling de los bits
    
    input("Presiona cualquier tecla para continuar")
    os.system("clear")

def senial_dk():
    global b,Ts,dk,m

    dk=np.zeros(m*k)
    for i in range(k):
        if b[i]==1:
            dk[i*m]=1
        else:
            dk[i*m]=-1
    return 0   
 
def ruido(sigma,muestras):
    return np.random.normal(0,sigma,muestras)

def prueba_gauss():

    sigma=0.2
    muestras=10000
    vector=[]
    
    os.system("clear")
    print("La cantidad de muestras son: {} ".format(muestras))
    print("El sigma es-> {}".format(sigma))
    #print("Los mensajes posibles son M={}".format(M))
    consulta=input("Desea cambiar la cantidad los valores? S o N[Enter] :")
    if consulta=='S' or consulta =='s':
        muestras=int(input("Ingrese la cantidad de muestras: "))
        sigma=float(input("Ingrese el sigma: "))
    
    #conta=np.arange(0,muestras,1)
    #for i in conta:
    #    vector[i]=ruido(sigma,muestras)
    vector=ruido(sigma,muestras)
    hist,rango=np.histogram(vector)
   
    minimmo=np.amin(vector)
    maximo=np.amax(vector)
    varianza=np.var(vector)
    desv_std=np.std(vector)
    media=np.mean(vector)

    x_max=np.amax(hist)         # se usa para graficar

    fig3 = plt.figure(3)
    encabezado=" Distribución Gaussiana -->"+str(muestras)+" muestras"+", con un sigma(desviación estandar)="+str(sigma)
    plt.suptitle(encabezado)
    plt.subplots_adjust(left=0.08, bottom=0.08, right=0.98, top=0.9, wspace=0.2, hspace=0.34)

    # Señal coseno elevado
    s1 = fig3.add_subplot(1,1,1)
    plt.text(varianza,x_max, 'máximo='+str(maximo), fontsize=12, color='red')
    plt.text(varianza,x_max-x_max/10, 'mínimo='+str(minimmo), fontsize=12, color='green')
    plt.text(varianza,x_max-2*x_max/10, 'varianza='+str(varianza), fontsize=12, color='black')
    plt.text(varianza,x_max-3*x_max/10, 'desv_std='+str(desv_std), fontsize=12, color='black')
    plt.text(varianza,x_max-4*x_max/10, 'media='+str(media), fontsize=12, color='black')

    plt.xlabel("sigma")
    plt.ylabel("Cantidad")
    s1.grid(True)
    plt.bar(rango[:-1],hist,width =sigma/3,color='#0504aa',alpha=0.7)

    plt.show()
    return 0

def coseno_elevado_plot():
    global b,Ts,dk,m,k

    senial_dk()

    senial_cos_elevado=coseno_elevado()  
    xk_cos_elevado=np.convolve(senial_cos_elevado,dk)
    tsxk_c=np.arange(len(xk_cos_elevado))*Ts   
        
    fig = plt.figure(2)
    encabezado=" Señal de entrada -->"+str(b)+"bits"+"  Con un beta="+str(beta)+"  Cantidad de muestras="+str(m)
    plt.suptitle(encabezado)
    plt.subplots_adjust(left=0.08, bottom=0.08, right=0.98, top=0.9, wspace=0.2, hspace=0.34)

    # Señal coseno elevado
    s2 = fig.add_subplot(2,1,1)
    plt.title("Coseno elvado")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s2.grid(True)
    s2.stem(tspk_c,senial_cos_elevado,'b-o')
    s2.plot(tspk_c,senial_cos_elevado,'b-o')

    s3 = fig.add_subplot(2,1,2)
    plt.title("Señal x[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s3.grid(True)
    s3.plot(tsxk_c-Tb*3,xk_cos_elevado,'b-')
    s3.stem(ts,dk,'or')
    
    plt.show()

    os.system("clear")




def transmision():
    global Ts,Tb,m,dk,xk,nk,temp
    global xk_seno,xk_cuadrada,xk_triangular,xk_cos_elevado
    global tsxk,tsxk_c,tsfk,tsfk_c
    global ck_seno,ck_cuadrada,ck_triangular,ck_cos_elevado
    global senial_seno

    # Se genera la señal d[k]
    senial_dk()

    # Se genera la señales p[k]
    senial_seno=np.sin(np.pi*(1/Tb)*(tspk))          #senial_seno=np.sin(2*np.pi*(2*Tb)*(tspk))                          
    senial_cuadrada=sc.square(np.pi*(1/Tb)*tspk)          
    senial_triangular=(sc.sawtooth(np.pi*(2/Tb)*tspk,width = 0.5)+1)/2  
    senial_cos_elevado=coseno_elevado()  
  
    # Se generan las señales x[k]
    xk_seno=np.convolve(dk,senial_seno)
    xk_cuadrada=np.convolve(senial_cuadrada,dk)
    xk_triangular=np.convolve(senial_triangular,dk)
    xk_cos_elevado=np.convolve(senial_cos_elevado,dk)
    tsxk=np.arange(len(xk_seno))*Ts             # Tiempo de sampling de x[k] --> convolución M+N-1
    tsxk_c=np.arange(len(xk_cos_elevado))*Ts 
   
    # Se modeliza el canal
    h=1         # Canal ideal
    fk_seno=np.convolve(xk_seno,h)
    fk_cuadrada=np.convolve(xk_cuadrada,h)
    fk_triangular=np.convolve(xk_triangular,h)
    fk_cos_elevado=np.convolve(xk_cos_elevado,h)
    tsfk=np.arange(len(fk_seno))*Ts             # Tiempo de sampling de f[k] --> convolución M+N-1
    tsfk_c=np.arange(len(fk_cos_elevado))*Ts 


    # Se modeliza el ruido Gaussiano
    nk=ruido(0.1,len(fk_seno))
    nk_c=ruido(0.1,len(fk_cos_elevado))    

    # Señales C[k]=x[k]+n[k]
    ck_seno=fk_seno+nk
    ck_cuadrada=fk_cuadrada+nk
    ck_triangular=fk_triangular+nk
    ck_cos_elevado=fk_cos_elevado+nk_c


    fig = plt.figure(1)
    encabezado=" Señal de entrada -->"+str(b)+"bits"
    plt.suptitle(encabezado)
    plt.subplots_adjust(left=0.08, bottom=0.08, right=0.98, top=0.9, wspace=0.2, hspace=1.2)

    # Señal binaria
    s1 = fig.add_subplot(5,2,1)
    plt.title("Señal d[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    plt.xlim(-Ts,m*k*Ts+Ts)
    s1.grid(True)
    s1.stem(ts,dk,'or')

    # Señal de ruido
    s2 = fig.add_subplot(5,2,2)
    plt.title("Señal de ruido del canal n[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    #plt.xlim(-Ts,m*k*Ts+Ts)
    s2.grid(True)
    s2.stem(tsfk,nk,'or')


    # Señal senoidal
    s2 = fig.add_subplot(5,3,4)
    plt.title("Senoidal")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s2.grid(True)
    s2.plot(tspk,senial_seno,'b-o')

    s3 = fig.add_subplot(5,3,5)
    plt.title("Señal x[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s3.grid(True)
    s3.plot(tsxk-(m/2)*Ts,xk_seno,'b-')
    s3.stem(ts,dk,'or')

    s3 = fig.add_subplot(5,3,6)
    plt.title("Señal c[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s3.grid(True)
    s3.plot(tsfk-(m/2)*Ts,ck_seno,'b-')
    s3.stem(ts,dk,'or')



    # Señal Cuadrada
    s4 = fig.add_subplot(5,3,7)
    plt.title("Cuadrada")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s4.grid(True)
    s4.plot(tspk,senial_cuadrada,'b-o')

    s3 = fig.add_subplot(5,3,8)
    plt.title("Señal x[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s3.grid(True)
    s3.plot(tsxk-(m/2)*Ts,xk_cuadrada,'b-')
    s3.stem(ts,dk,'or')

    s3 = fig.add_subplot(5,3,9)
    plt.title("Señal c[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s3.grid(True)
    s3.plot(tsfk-(m/2)*Ts,ck_cuadrada,'b-')
    s3.stem(ts,dk,'or')


    # Señal Triangular
    s2 = fig.add_subplot(5,3,10)
    plt.title("Triangular")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s2.grid(True)
    s2.plot(tspk,senial_triangular,'b-o')

    s3 = fig.add_subplot(5,3,11)
    plt.title("Señal x[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s3.grid(True)
    s3.plot(tsxk-(m/2)*Ts,xk_triangular,'b-')
    s3.stem(ts,dk,'or')

    s3 = fig.add_subplot(5,3,12)
    plt.title("Señal c[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s3.grid(True)
    s3.plot(tsfk-(m/2)*Ts,ck_triangular,'b-')
    s3.stem(ts,dk,'or')


    # Señal coseno elvado
    s2 = fig.add_subplot(5,3,13)
    plt.title("Coseno elevado")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s2.grid(True)
    s2.plot(tspk_c,senial_cos_elevado,'b-o')

    s3 = fig.add_subplot(5,3,14)
    plt.title("Señal x[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s3.grid(True)
    s3.plot(tsxk_c-Tb*3,xk_cos_elevado,'b-')
    s3.stem(ts,dk,'or')
 
    s3 = fig.add_subplot(5,3,15)
    plt.title("Señal x[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s3.grid(True)
    s3.plot(tsfk_c-Tb*3,ck_cos_elevado,'b-')
    s3.stem(ts,dk,'or')

    plt.show()

    #input("Presiona cualquier tecla para continuar")
    os.system("clear")

    return 0

def generar_bits():
    global b,Ts,dk,m

    b=np.array(np.round(np.random.rand(8),0),dtype=int)    
    print(b)

    senial_dk()
    
    input("Presiona cualquier tecla para continuar")
    os.system("clear")
    
    return 0

def densidad():
    global Ts,Tb,m,dk,xk,nk
    global xk_seno,xk_cuadrada,xk_triangular,xk_cos_elevado
    global tsxk,tsxk_c,tsfk,tsfk_c
    global ck_seno,ck_cuadrada,ck_triangular,ck_cos_elevado
    global senial_seno
  
    ######### Prueba de la función pds de Matplotlib ###########
    #tn=np.arange(50)*Ts
    #senoidal=np.sin(np.pi*(1/Tb)*(tn))+np.sin(np.pi*(4/Tb)*(tn))
    ############################################################
 
    fig = plt.figure(4)
    encabezado=" Señal de entrada -->"+str(b)+"bits"
    plt.suptitle(encabezado)
    plt.subplots_adjust(left=0.08, bottom=0.08, right=0.98, top=0.9, wspace=0.360, hspace=1.2)

    # Señal senoidal
    s1 = fig.add_subplot(4,3,1)
    plt.title("Señal x[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s1.grid(True)
    s1.plot(tsxk-(m/2)*Ts,xk_seno,'b-')
    s1.stem(ts,dk,'or')
    #s1.plot(tn,senoidal,'r-')                                             # Se usa para probar la función pds de Matplotlib

    s2 = fig.add_subplot(4,3,2)
    plt.title("Densidad espectral sin ruido de x[k]")
    plt.yscale("symlog")
    s2.grid(True)
    s2.psd(xk_seno,NFFT = len(tsxk),pad_to=len(tsxk), Fs = 1/Ts)
    #s2.psd(senoidal,NFFT = len(tn),pad_to=len(tn),Fs = 1/Ts)              # Se usa para probar la función pds de Matplotlib
    plt.xlabel("Frecuencia[MHz]")
    plt.ylabel("")

    s2 = fig.add_subplot(4,3,3)
    plt.title("Densidad espectral con ruido de c[k]")
    plt.yscale("symlog")
    s2.grid(True)
    s2.psd(ck_seno,NFFT = len(tsfk),pad_to=len(tsfk), Fs = 1/Ts)
    plt.xlabel("Frecuencia[MHz]")
    plt.ylabel("")    

    # Señal Cuadrada
    s1 = fig.add_subplot(4,3,4)
    plt.title("Señal x[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s1.grid(True)
    s1.plot(tsxk-(m/2)*Ts,xk_cuadrada,'b-')
    s1.stem(ts,dk,'or')

    s2 = fig.add_subplot(4,3,5)
    plt.title("Densidad espectral sin ruido de x[k]")
    plt.yscale("symlog")
    s2.grid(True)
    s2.psd(xk_cuadrada,NFFT = len(tsxk),pad_to=len(tsxk), Fs = 1/Ts)
    plt.xlabel("Frecuencia[MHz]")
    plt.ylabel("")

    s3 = fig.add_subplot(4,3,6)
    plt.title("Densidad espectral con ruido de c[k]")
    plt.yscale("symlog")
    s3.grid(True)
    s3.psd(ck_cuadrada,NFFT = len(tsxk),pad_to=len(tsxk), Fs = 1/Ts)
    plt.xlabel("Frecuencia[MHz]")
    plt.ylabel("")


    # Señal Triangular
    s1 = fig.add_subplot(4,3,7)
    plt.title("Señal x[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s1.grid(True)
    s1.plot(tsxk-(m/2)*Ts,xk_triangular,'b-')
    s1.stem(ts,dk,'or')

    s2 = fig.add_subplot(4,3,8)
    plt.title("Densidad espectral sin ruido de x[k]")
    plt.yscale("symlog")
    s2.grid(True)
    s2.psd(xk_triangular,NFFT = len(tsxk),pad_to=len(tsxk), Fs = 1/Ts)
    plt.xlabel("Frecuencia[MHz]")
    plt.ylabel("")     

    s3 = fig.add_subplot(4,3,9)
    plt.title("Densidad espectral con ruido de c[k]")
    plt.yscale("symlog")
    s3.grid(True)
    s3.psd(ck_triangular,NFFT = len(tsxk),pad_to=len(tsxk), Fs = 1/Ts)
    plt.xlabel("Frecuencia[MHz]")
    plt.ylabel("")

    # Señal coseno elevado
    s1 = fig.add_subplot(4,3,10)
    plt.title("Señal x[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s1.grid(True)
    s1.plot(tsxk_c-Tb*3,xk_cos_elevado,'b-')
    s1.stem(ts,dk,'or')
 
    s2 = fig.add_subplot(4,3,11)
    plt.title("Densidad espectral sin ruido de x[k]")
    plt.yscale("symlog")
    s2.grid(True)
    s2.psd(xk_cos_elevado,NFFT = len(tsxk_c),pad_to=len(tsxk_c), Fs = 1/Ts)
    plt.xlabel("Frecuencia[MHz]")
    plt.ylabel("")  

    s3 = fig.add_subplot(4,3,12)
    plt.title("Densidad espectral con ruido de c[k]")
    plt.yscale("symlog", linthreshy=0.1)
    s3.grid(True)
    s3.psd(ck_cos_elevado,NFFT = len(tsxk_c),pad_to=len(tsxk_c), Fs = 1/Ts)
    plt.xlabel("Frecuencia[MHz]")
    plt.ylabel("")

    plt.show()


    return 0

def densidad_c():
    fig = plt.figure(4)
    encabezado=" Señal de entrada -->"+str(b)+"bits"
    plt.suptitle(encabezado)
    plt.subplots_adjust(left=0.08, bottom=0.08, right=0.98, top=0.9, wspace=0.360, hspace=1.2) 

    # Señal coseno elevado
    """ s1 = fig.add_subplot(2,3,1)
    plt.title("Señal x[k]")
    plt.xlabel("Tiempo(useg)")
    plt.ylabel("Amplitud")
    s1.grid(True)
    s1.plot(tsxk_c-Tb*3,xk_cos_elevado,'b-')
    s1.stem(ts,dk,'or')
 
    s2 = fig.add_subplot(2,3,2)
    plt.title("Densidad espectral sin ruido de x[k]")
    plt.yscale('symlog')
    s2.grid(True)
    s2.psd(xk_cos_elevado,NFFT = len(tsxk_c),pad_to=len(tsxk_c), Fs = 1/Ts)
    plt.xlim(0,10)
    plt.axhline(0,color = "red", linewidth = 1, linestyle = "dashed")
    plt.ylim(-200,20)
    plt.xlabel("Frecuencia[MHz]")
    plt.ylabel("") """

    s3 = fig.add_subplot(1,1,1)
    plt.title("Densidad espectral con ruido de c[k]")
    plt.yscale('symlog')
    s3.grid(True)
    s3.psd(ck_cos_elevado,NFFT = len(tsxk_c),pad_to=len(tsxk_c), Fs = 1/Ts)
    s3.psd(ck_cuadrada,NFFT = len(tsxk),pad_to=len(tsxk_c), Fs = 1/Ts)
    #s3.psd(ck_triangular,NFFT = len(tsxk),pad_to=len(tsxk_c), Fs = 1/Ts)
    #s3.psd(ck_seno,NFFT = len(tsxk),pad_to=len(tsxk_c), Fs = 1/Ts)
    plt.xlim(0,10)
    plt.axhline(0,color = "red", linewidth = 1, linestyle = "dashed")
    plt.axhline(1,color = "blue", linewidth = 1, linestyle = "dashed")
    plt.axhline(-1,color = "blue", linewidth = 1, linestyle = "dashed")
    plt.ylim(-200,20)
    plt.xlabel("Frecuencia[MHz]")
    #plt.legend(('Coseno elevado', 'Cuadrada', 'Triangular','Seno'),prop = {'size': 10}, loc='upper right')
    plt.legend(('Coseno elevado', 'Cuadrada'),prop = {'size': 10}, loc='upper right')

    plt.show()

    return 0




#================================================================
# Inicio del programa principal
#================================================================
menu="""
Ejercicio 3 de la materia Sistemas Digitales para las Comunicaciones

[1] Generar 8 bits de datos aleatorios 
[2] Configurar la cantidad de muestras por bit
[3] Prueba de la función coseno elevado
[4] Prueba de la distribución Gaussiana
[5] Transmisión
[6] Densidad espectral de potencia
    (correr primero el item 5--> Transmisión)
[7] Densidad espectral de potencia del
    coseno elevado (correr primero el ítem 5)
[8] 
[9] Salir
"""

while(True):
    os.system("clear")
    print(menu)

    opcion=input("Elija una opción: ")

    if opcion== '1':
        generar_bits()
    elif opcion== '2':
        cantidad_bits()
    elif opcion== '3':
        coseno_elevado_plot()
    elif opcion== '4':
        prueba_gauss()
    elif opcion== '5':
        transmision()
    elif opcion== '6':
        densidad()
    elif opcion== '7':
        densidad_c()
    elif opcion== '8':
        pass
    elif opcion== '9':
        os.system("clear")
        print("Gracias por usar el programa !!!")
        exit (0)
    else:
        print("No selecionó una opción válida\n\r")
