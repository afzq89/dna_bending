#!/bin/bash
# Run ABMD in cycles

module load gcc/7.2.1
module load cuda/11.6

/bin/sudo /usr/bin/nvidia-smi -c 0
export CUDA_VISIBLE_DEVICES=0,1,2,3
source /home/afakhar/src/amber21-mpich/amber20/amber.sh

# Change the cycles 
rm -rf 1
mkdir -p 1
cd 1
cp ../abmd.in.* ./
cp ../*.in ./
cp ../groups ./
cp ../systems/prmtop ./
cp ../systems/RST ./
cp ../systems/inpcrd.rst7 ./

j=1
while [ $j -le 8 ]
do
   cp ../systems/abmd.ncrst.$j ./pre.ncrst.$j
   j=$(( $j + 1 ))
done
if [ -f "../systems/nfe-abmd-umbrella-001.nc" ]; then
      cp ../systems/nfe-abmd-umbrella-00*.nc ./
      cp ../systems/nfe-abmd-wt-umbrella-00*.nc ./
fi

mpirun -np 8 pmemd.cuda_SPFP.MPI -O -ng 8 -groupfile groups

k=1
while [ $k -le 8 ]
do
   cpptraj -i recenter$k.in
   cp recenter.ncrst.$k ../systems/abmd.ncrst.$k
   rm recenter$k.in
   cp nfe-abmd-umbrella-00$k.nc ../systems/ 
   cp nfe-abmd-wt-umbrella-00$k.nc ../systems/
   k=$(( $k + 1 ))
done
cd ../
