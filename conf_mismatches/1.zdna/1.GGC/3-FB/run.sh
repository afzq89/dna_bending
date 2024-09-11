#!/bin/bash
# SMD simualtions
rm -rf nohup.out tmp run.log
set -e

# Change the below seq.
ar=(`seq 2 3`)
ar2=(`seq 1 2`)
pids=( )


cp ../2-extract/RST ./
cp ../2-extract/prmtop ./

i=0
while [ $i -lt ${#ar[*]} ]; do
   rm -rf ${ar[$i]}
   mkdir ${ar[$i]}
   cd ${ar[$i]} 
   cp ../2-extract/cv-inpcrd$j.in ./cv-inpcrd$j.in
   cp ../2-extract/c${ar[$i]}.rst ./inpcrd.rst7
   sed "s/GPU/${ar2[$i]}/g" ./README-smd-explicit-cblab-tmp > README-smd-explicit-cblab
   chmod +x README-smd-explicit-cblab
   ./README-smd-explicit-cblab
   cd ../
   i=$(( $i + 1));
done

#pids came form README-smd-explicit-cblab copied to tmp file 
readarray -t pids < tmp
for pid in "${pids[@]}"; do
while [ -e /proc/$pid ]
do
    echo "Process: $pid is still running" >> ./run.log
    sleep .9
done
echo 
echo "Process $pid has finished" >> ./run.log
done
rm tmp

ar=(`seq 4 5`)
ar2=(`seq 1 2`)

i=0
while [ $i -lt ${#ar[*]} ]; do
   rm -rf ${ar[$i]}
   mkdir ${ar[$i]}
   cd ${ar[$i]}
   cp ../2-extract/cv-inpcrd$j.in ./cv-inpcrd$j.in
   cp ../2-extract/c${ar[$i]}.rst ./inpcrd.rst7
   sed "s/GPU/${ar2[$i]}/g;s/HERE/c${ar[$i]}/g" ../README-smd-explicit-cblab > README-smd-explicit-cblab
   chmod +x README-smd-explicit-cblab
   ./README-smd-explicit-cblab
   cd ../
   i=$(( $i + 1));
done

#pids came form README-smd-explicit-cblab copied to tmp file
readarray -t pids < tmp
for pid in "${pids[@]}"; do
while [ -e /proc/$pid ]
do
    echo "Process: $pid is still running" >> ./run.log
    sleep .9
done
echo
echo "Process $pid has finished" >> ./run.log
done
rm tmp

ar=(`seq 6 7`)
ar2=(`seq 1 2`)

i=0
while [ $i -lt ${#ar[*]} ]; do
   rm -rf ${ar[$i]}
   mkdir ${ar[$i]}
   cd ${ar[$i]}
   cp ../2-extract/cv-inpcrd$j.in ./cv-inpcrd$j.in
   cp ../2-extract/c${ar[$i]}.rst ./inpcrd.rst7
   sed "s/GPU/${ar2[$i]}/g;s/HERE/c${ar[$i]}/g" ../README-smd-explicit-cblab > README-smd-explicit-cblab
   chmod +x README-smd-explicit-cblab
   ./README-smd-explicit-cblab
   cd ../
   i=$(( $i + 1));
done

#pids came form README-smd-explicit-cblab copied to tmp file
readarray -t pids < tmp
for pid in "${pids[@]}"; do
while [ -e /proc/$pid ]
do
    echo "Process: $pid is still running" >> ./run.log
    sleep .9
done
echo
echo "Process $pid has finished" >> ./run.log
done
rm tmp

ar=(`seq 8 9`)
ar2=(`seq 1 2`)

i=0
while [ $i -lt ${#ar[*]} ]; do
   rm -rf ${ar[$i]}
   mkdir ${ar[$i]}
   cd ${ar[$i]}
   cp ../2-extract/cv-inpcrd$j.in ./cv-inpcrd$j.in
   cp ../2-extract/c${ar[$i]}.rst ./inpcrd.rst7
   sed "s/GPU/${ar2[$i]}/g;s/HERE/c${ar[$i]}/g" ../README-smd-explicit-cblab > README-smd-explicit-cblab
   chmod +x README-smd-explicit-cblab
   ./README-smd-explicit-cblab
   cd ../
   i=$(( $i + 1));
done

#pids came form README-smd-explicit-cblab copied to tmp file
readarray -t pids < tmp
for pid in "${pids[@]}"; do
while [ -e /proc/$pid ]
do
    echo "Process: $pid is still running" >> ./run.log
    sleep .9
done
echo
echo "Process $pid has finished" >> ./run.log
done
rm tmp
