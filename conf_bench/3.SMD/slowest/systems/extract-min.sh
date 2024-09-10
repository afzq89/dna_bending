#!/bin/bash
# Extract 100 replicas 

cat> relax.mdin <<EOF
&cntrl
 imin = 1,
 ntx = 1, irest = 0,
 ntpr = 100, ntwr = 100, iwrap = 1, ntwx = 0,
 ntr = 0,
 maxcyc = 5000, ncyc = 2500,
 ntp = 0,
 ntc = 2,
 ntf = 2, ntb = 1, cut = 9.0, igb = 0
/
EOF
   
cp ../../../1-equ/prmtop ./
cp ../../../1-equ/RST ./
arr=(`seq 5 50 500`)
for i in "${!arr[@]}"; do
cpptraj <<EOF
parm prmtop
trajin ../../../1-equ/step.19.equ.nc ${arr[i]} ${arr[i]}
autoimage
trajout ${i}.rst restart
go
EOF

mpirun -np 16 pmemd.MPI -O -c ${i}.rst -ref ${i}.rst -i relax.mdin -p prmtop -r traj${i}.rst
rm -rf ${i}.rst
cpptraj<<EOF
parm prmtop
trajin traj${i}.rst
autoimage
trajout c$((i+1)).rst
trajout ref$((i+1)).pdb
EOF
rm traj${i}.rst
done
