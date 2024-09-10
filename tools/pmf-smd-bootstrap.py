#!/usr/bin/env python

import numpy as np
import math

# Set the below
kb=0.001986 # in kcal
T=303 # in kelvin  
kbt=kb*T
n=10 # number of replicas 
m=10000 # sample_size 
col=4 # work column in the smd-%d.txt
boots=2000

result=np.zeros((m,3))
average=np.zeros((m,2))
free_energy=np.zeros((m,n))

average[:,0]=np.loadtxt("smd-1.txt", usecols=[1])
std=np.zeros((m,2))
work=np.zeros((m,n))
std[:,0]= np.loadtxt("smd-1.txt", usecols=[1])

for i in range(1,n+1,1):
    free_energy[:,i-1] = np.loadtxt("smd-%d.txt"%i, usecols=[col])
    for j in range(m):
        free_energy[j,i-1]=np.exp(-free_energy[j,i-1]/(kbt))
    work[:,i-1] = np.loadtxt("smd-%d.txt"%i, usecols=[col])

for k in range(m):
    av_bs = 0
    std_bs = 0
    for j in range(boots) :
        Sum_f = 0
        Sum_w = 0
        Sumsq = 0
        var = 0
        for i in range(10) :
            x = free_energy[k,np.random.randint(0,n)]
            Sum_f = Sum_f + x

            y = work[k,np.random.randint(0,n)]
            Sum_w = Sum_w + y 
            Sumsq = Sumsq + y*y
        av_bs = av_bs + Sum_f / n
        var = (n/(n-1))*(Sumsq / n - (Sum_w / n)*(Sum_w / n))
        #errors (std_bs)
        std_bs = std_bs + math.sqrt(var / n)

    average[k,1] = av_bs / boots
    # Free energy
    average[k,1]=-kbt*math.log(average[k,1])
    # STD
    std[k,1] = std_bs / boots

#Set minima to Zero
average[:,1]=average[:,1]-np.min(average[:,1])
#Save the result
result[:,0]=average[:,0]
result[:,1]=average[:,1]
result[:,2]=std[:,1]
np.savetxt("free_energy_bs.txt",result)
