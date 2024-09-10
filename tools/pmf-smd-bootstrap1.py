#!/usr/bin/env python

import numpy as np
import math

# Set the below
kb=0.001986 # in kcal
T=303  # in kelvin
kbt=kb*T
n=10  # number of replicas
m=10000 # sample size
col=4  # work column in the smd-%d.txt
boots=2000  # number of bootstrap samples

result=np.zeros((m,3))
average=np.zeros((m,2))
free_energy=np.zeros((m,n))

average[:,0]=np.loadtxt("smd-1.txt", usecols=[1])
std=np.zeros((m,2))
work=np.zeros((m,n))

for i in range(1,n+1,1):
    free_energy[:,i-1]=np.loadtxt(f"smd-{i}.txt", usecols=[col])
    for j in range(m):
        free_energy[j,i-1]=np.exp(-free_energy[j,i-1]/kbt)
    work[:,i-1] = np.loadtxt(f"smd-{i}.txt", usecols=[col])

for k in range(m):
    av_bs = 0
    std_bs = 0
    bootstrap_sum_f=np.zeros(boots)

    for j in range(boots):
        Sum_f = 0
        Sum_w = 0
        Sumsq = 0
        for i in range(n):
            x = free_energy[k,np.random.randint(0,n)]
            Sum_f += x
            y=work[k,np.random.randint(0, n)]
            Sum_w += y
            Sumsq += y**2
        bootstrap_sum_f[j]=Sum_f / n
    av_bs=np.sum(bootstrap_sum_f) / boots
    var_bs=np.sum((bootstrap_sum_f-av_bs)**2) / (boots-1)
    #Errors (std_bs)
    std_bs = math.sqrt(var_bs/boots)
    # Free energy
    average[k,1]=-kbt*math.log(av_bs)

# Set minima to zero for free energy
average[:, 1] = average[:, 1] - np.min(average[:, 1])
# Save the results
result[:, 0] = average[:, 0]
result[:, 1] = average[:, 1]
result[:, 2] = std[:, 1]
np.savetxt("free_energy_bs.txt", result)
