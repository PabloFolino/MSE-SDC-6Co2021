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
N = 80000 # Number of samples

h_canal = [1]
# h_canal = [np.sqrt(2)/2 + (np.sqrt(2)/2)*(1j)]
# N_H = 10 # largo del filtro pasabajos
# h_canal = np.exp(-np.arange(N_H)/4)

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
_, p_mod = filters.rrcosfilter(L_FIR*4, 0.5, Ts, L_FIR / Ts)
p_mod = (p_mod/np.max(p_mod))

discard = (len(p_mod))//2
x = np.convolve(d,p_mod)[discard:]

SIGMA_N_MIN = 0.02
SIGMA_N_MAX = 1.0
SIGMA_N_EXP_MIN = -2
SIGMA_N_EXP_MAX = 3
STEPS = 40
mse = np.zeros(STEPS)
ber = np.zeros(STEPS)
snr = np.zeros(STEPS)

# Filtro del demodulador
t_p_d, p_dem = filters.rrcosfilter(L_FIR*4, 0.5, Ts, L_FIR / Ts)
p_dem = (p_dem/np.max(p_dem))

# sigmas = np.linspace(SIGMA_N_MIN,SIGMA_N_MAX,STEPS)
sigmas = np.logspace(SIGMA_N_EXP_MIN,SIGMA_N_EXP_MAX,STEPS)

# Para el calculo de la energia de la senal hay que considerar al pulso como continuo,
# Una forma de aproximar esto es agregar muchos puntos aumentando la frecuencia de sampleo
OVER_SAMPLING = 10
t_p_c, p_rised = filters.rrcosfilter(OVER_SAMPLING*(L_FIR*4), 0.35, Ts, L_FIR*OVER_SAMPLING / Ts)
p_rised = p_rised/np.max(p_rised)

fig_p = plt.figure()
d_axe = fig_p.add_subplot(2,1,1)
d_axe.set_title("Pulso rrcos discreto")
d_axe.stem(t_p_d,p_mod)
d_axe.set_xlabel("k")
d_axe.set_ylabel("p_disc[k]")
c_axe = fig_p.add_subplot(2,1,2)
c_axe.set_title("Pulso rrcos pseudo cotinuo")
c_axe.stem(t_p_c,p_rised)
c_axe.set_xlabel("k")
c_axe.set_ylabel("p_cont[k]")

# Hago la integral 
Es = np.sum(np.square(np.abs(p_rised))) * Ts / L_FIR / OVER_SAMPLING
Ps = Es / ( (OVER_SAMPLING*(L_FIR*4)) * (Ts / L_FIR / OVER_SAMPLING) )

idx = 0
for sigma in sigmas:
    # ---------------------------
    # Canal
    # ---------------------------
    #discard = (len(h_canal))//2
    #c = np.convolve(x,h_canal)[discard:]
    c = np.convolve(x,h_canal,'same')
    n_i = np.random.normal(0,sigma,len(c))
    n_q = np.random.normal(0,sigma,len(c))
    n = n_i + n_q*(1j) # Ruido del canal
    c = c + n # Salida del canal

    # Escalamiento
    esc = np.max(np.convolve(p_dem, np.convolve(p_dem, h_canal)))

    discard = (len(p_dem))//2
    y = np.convolve(c,p_dem)[discard:]
    y_esc = y / esc # Salida escalada

    # Downsampler
    hat_b = np.zeros(N)*(1j)
    for i in range(N*M):
        if ((i%M) == 0) :
            hat_b[i//M] = y_esc[i] # Senal downsampleada

    Pn = sigma*sigma
    snr[idx] = 10*np.log10(Ps/Pn)
    #print(Ps, " - ", Pn, " - SNR: ", snr[idx])

    mse[idx] = np.mean(np.square(abs(b - hat_b)))

    b_i = np.rint(np.real(b))
    b_q = np.rint(np.imag(b))

    # Method 1
    # hat_b_i = np.rint(np.real(hat_b))
    # hat_b_q = np.rint(np.imag(hat_b))

    # Method 2
    hat_b_i = np.zeros(N)
    hat_b_q = np.zeros(N)
    for i in range(N):
        if (np.real(hat_b[i]) > 0):
            hat_b_i[i] = 1
        else:
            hat_b_i[i] = -1        
        if (np.imag(hat_b[i]) > 0):
            hat_b_q[i] = 1
        else:
            hat_b_q[i] = -1

    err_count = 0
    for j in range(len(b)):
        if (b_i[j]!=hat_b_i[j]): #or b_q[j]!=hat_b_q[j]):
            err_count = err_count + 1
    ber[idx] = err_count / len(b)
    print('SNR: ', snr[idx], ' - MSE: ', mse[idx], ' - BER: ', ber[idx])
    idx = idx + 1

fig = plt.figure()
mse_axe = fig.add_subplot(2,1,1)
mse_axe.set_title("MSE vs SNR")
mse_axe.semilogy(snr,mse)
mse_axe.set_xlabel("SNR [dB]")
mse_axe.set_ylabel("MSE")
ber_axe = fig.add_subplot(2,1,2)
ber_axe.set_title("BER vs SNR")
ber_axe.semilogy(snr,ber)
ber_axe.set_xlabel("SNR [dB]")
ber_axe.set_ylabel("BER")

# Set the spacing between subplots
plt.subplots_adjust(left=0.1,
                    bottom=0.1, 
                    right=0.9, 
                    top=0.9, 
                    wspace=0.4, 
                    hspace=0.4)

plt.show()