import numpy as np
import matplotlib.pyplot as plt
import scipy.signal as sc
from commpy import filters

# Parameters
Fs = 16e6
Ts = 1/Fs
M = 16 # Upsampler rate
Tsymb = Ts * M
L_FIR = 15 # Filter length
N = 2048 # Number of samples

SIGMA_N = 0.0

# Input signal
b_i = np.random.randint(0,2,size=N)
for i in range(N):
    if (b_i[i]):
        b_i[i] = 1
    else:
        b_i[i] = -1
b_q = np.random.randint(0,2,size=N)
for i in range(N):
    if (b_q[i]):
        b_q[i] = 1
    else:
        b_q[i] = -1
b = b_i + b_q*(1j)

# Upsampler
d = np.zeros(N*M)*(1j)
for i in range(N):
    d[i*M] = b[i]

# ---------------------------
# Pulso raiz de coseno elevado
# ---------------------------
_, p_mod = filters.rrcosfilter(L_FIR*4, 0.35, Ts, L_FIR / Ts)
p_mod = (p_mod/np.max(p_mod))

discard = (len(p_mod))//2
x = np.convolve(d,p_mod)[discard:]

# ---------------------------
# Canales
# ---------------------------
# Delta unitaria fase 0
h1 = [1]
discard = (len(h1))//2
c1 = np.convolve(x,h1)[discard:]
n_i = np.random.normal(0,SIGMA_N,len(c1))
n_q = np.random.normal(0,SIGMA_N,len(c1))
n = n_i + n_q*(1j) # Ruido del canal
c1 = c1 + n # Salida del canal 1

# Delta unitaria fase distinta de 0
h2 = [np.sqrt(2)/2 + (np.sqrt(2)/2)*(1j)]
discard = (len(h2)+1)//2 # The '+1' is because filter lenght is odd
c2 = np.convolve(x,h2)[discard:]
n_i = np.random.normal(0,SIGMA_N,len(c2))
n_q = np.random.normal(0,SIGMA_N,len(c2))
n = n_i + n_q*(1j) # Ruido del canal
c2 = c2 + n # Salida del canal 2

# Pasabajos
N_H = 10 # largo del filtro
h3 = np.exp(-np.arange(N_H)/4)
c3 = np.convolve(x,h3,'same')
n_i = np.random.normal(0,SIGMA_N,len(c3))
n_q = np.random.normal(0,SIGMA_N,len(c3))
n = n_i + n_q*(1j) # Ruido del canal
c3 = c3 + n # Salida del canal 3

# Filtro del demodulador
_, p_dem = filters.rrcosfilter(L_FIR*4, 0.35, Ts, L_FIR / Ts)
p_dem = (p_dem/np.max(p_dem))

# Escalamiento: Se escala para cada canal
esc1 = np.max(np.convolve(p_dem, np.convolve(p_dem, h1)))
esc2 = np.max(np.convolve(p_dem, np.convolve(p_dem, h2)))
esc3 = np.max(np.convolve(p_dem, np.convolve(p_dem, h3)))

discard = (len(p_dem))//2
y1 = np.convolve(c1,p_dem)[discard:] / esc1 # Señal escalada canal 1
y2 = np.convolve(c2,p_dem)[discard:] / esc2 # Señal escalada canal 2
y3 = np.convolve(c3,p_dem)[discard:] / esc3 # Señal escalada canal 3

# Downsampler
hat_b1 = np.zeros(N+1)*(1j)
hat_b2 = np.zeros(N+1)*(1j)
hat_b3 = np.zeros(N+1)*(1j)
for i in range(N*M):
    if ((i%M) == 0) :
        hat_b1[i//M] = y1[i] # Señal downsampleada canal 1
        hat_b2[i//M] = y2[i] # Señal downsampleada canal 2
        hat_b3[i//M] = y3[i] # Señal downsampleada canal 3

fig_p = plt.figure()
p_axe = fig_p.add_subplot(1,1,1)
p_axe.set_title("Pulso raiz de coseno elevado")
p_axe.stem(p_mod)
p_axe.set_xlabel("k")
p_axe.set_ylabel("p[k]")

fig_1 = plt.figure()
real_axe_1 = fig_1.add_subplot(2,1,1)
real_axe_1.set_title("Pulso raiz de coseno elevado - Canal 1: Delta fase cero - Sigma_N: %f" % SIGMA_N)
real_axe_1.stem(d.real[M:16*M], markerfmt='o', use_line_collection=False)
real_axe_1.plot(c1.real[M:16*M], 'r', linewidth=5, alpha=0.3)
real_axe_1.plot(y1.real[M:16*M], 'g')
real_axe_1.legend(["c(k)","y(k)","d(k)"])
real_axe_1.set_xlabel("k")
real_axe_1.set_ylabel("Parte real")
imag_axe_1 = fig_1.add_subplot(2,1,2)
imag_axe_1.stem(d.imag[M:16*M], markerfmt='o', use_line_collection=False)
imag_axe_1.plot(c1.imag[M:16*M], 'r', linewidth=5, alpha=0.3)
imag_axe_1.plot(y1.imag[M:16*M], 'g')
imag_axe_1.legend(["c(k)","y(k)","d(k)"])
imag_axe_1.set_xlabel("k")
imag_axe_1.set_ylabel("Parte imaginaria")

fig_2 = plt.figure()
real_axe_2 = fig_2.add_subplot(2,1,1)
real_axe_2.set_title("Pulso raiz de coseno elevado - Canal 2: Delta fase distina de cero - Sigma_N: %f" % SIGMA_N)
real_axe_2.stem(d.real[M:16*M], markerfmt='o', use_line_collection=False)
real_axe_2.plot(c2.real[M:16*M], 'r', linewidth=5, alpha=0.3)
real_axe_2.plot(y2.real[M:16*M], 'g')
real_axe_2.legend(["c(k)","y(k)","d(k)"])
real_axe_2.set_xlabel("k")
real_axe_2.set_ylabel("Parte real")
imag_axe_2 = fig_2.add_subplot(2,1,2)
imag_axe_2.stem(d.imag[M:16*M], markerfmt='o', use_line_collection=False)
imag_axe_2.plot(c2.imag[M:16*M], 'r', linewidth=5, alpha=0.3)
imag_axe_2.plot(y2.imag[M:16*M], 'g')
imag_axe_2.legend(["c(k)","y(k)","d(k)"])
imag_axe_2.set_xlabel("k")
imag_axe_2.set_ylabel("Parte imaginaria")

fig_3 = plt.figure()
real_axe_3 = fig_3.add_subplot(2,1,1)
real_axe_3.set_title("Pulso raiz de coseno elevado - Canal 3: Pasabajos - Sigma_N: %f" % SIGMA_N)
real_axe_3.stem(d.real[M:16*M], markerfmt='o', use_line_collection=False)
real_axe_3.plot(c3.real[M-2:16*M-2], 'r', linewidth=5, alpha=0.3)
real_axe_3.plot(y3.real[M-2:16*M-2], 'g')
real_axe_3.legend(["c(k)","y(k)","d(k)"])
real_axe_3.set_xlabel("k")
real_axe_3.set_ylabel("Parte real")
imag_axe_3 = fig_3.add_subplot(2,1,2)
imag_axe_3.stem(d.imag[M:16*M], markerfmt='o', use_line_collection=False)
imag_axe_3.plot(c3.imag[M-2:16*M-2], 'r', linewidth=5, alpha=0.3)
imag_axe_3.plot(y3.imag[M-2:16*M-2], 'g')
imag_axe_3.legend(["c(k)","y(k)","d(k)"])
imag_axe_3.set_xlabel("k")
imag_axe_3.set_ylabel("Parte imaginaria")

const = plt.figure()
const_axe_1 = const.add_subplot(1,1,1)
const_axe_1.set_title("Constelacion - Sigma_N: %f" % SIGMA_N)
const_axe_1.set_xlim(-2, 2)
const_axe_1.set_ylim(-2, 2)
const_axe_1.scatter(hat_b1[M:-M].real, hat_b1[M:-M].imag, c="blue", alpha=0.4, label = 'canal_1')
const_axe_1.scatter(hat_b2[M:-M].real, hat_b2[M:-M].imag, c="green", alpha=0.4, label = 'canal_2')
const_axe_1.scatter(hat_b3[M:-M].real, hat_b3[M:-M].imag, c="red", alpha=0.4, label = 'canal_3')
const_axe_1.scatter([1, -1, -1, 1], [1, 1, -1, -1], c="orange", label = 'ideal')
const_axe_1.legend()
const_axe_1.set_xlabel("Real")
const_axe_1.set_ylabel("Imag")

# Set the spacing between subplots
plt.subplots_adjust(left=0.1,
                    bottom=0.1, 
                    right=0.9, 
                    top=0.9, 
                    wspace=0.4, 
                    hspace=0.4)

plt.show()