#!/bin/bash
# SMD simualtions
# This is a setup for a machine with 3 GPU cards
rm -rf nohup.out tmp run.log
set -e

ar=(`seq 0 2`)
ar2=(`seq 0 2`)
pids=( )

i=0
while [ $i -lt ${#ar[*]} ]; do
   rm -rf ${ar[$i]}
   mkdir ${ar[$i]}
   cd ${ar[$i]} 
   cp ./system/cv-inpcrd${ar[$i]}.in ./cv-inpcrd.in
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

ar=(`seq 3 5`)
ar2=(`seq 0 2`)

i=0
while [ $i -lt ${#ar[*]} ]; do
   rm -rf ${ar[$i]}
   mkdir ${ar[$i]}
   cd ${ar[$i]}
   cp ./system/cv-inpcrd${ar[$i]}.in ./cv-inpcrd.in
   sed "s/GPU/${ar2[$i]}/g;s/HERE/c${ar[$i]}/g" ../README-smd-explicit-cblab > README-smd-explicit-cblab
   chmod +x README-smd-explicit-cblab
   ./README-smd-explicit-cblab
   cd ../
   i=$(( $i + 1));
done

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

ar=(`seq 6 8`)
ar2=(`seq 0 2`)

i=0
while [ $i -lt ${#ar[*]} ]; do
   rm -rf ${ar[$i]}
   mkdir ${ar[$i]}
   cd ${ar[$i]}
   cp ../system/cv-inpcrd${ar[$i]}.in ./cv-inpcrd.in
   sed "s/GPU/${ar2[$i]}/g;s/HERE/c${ar[$i]}/g" ../README-smd-explicit-cblab > README-smd-explicit-cblab
   chmod +x README-smd-explicit-cblab
   ./README-smd-explicit-cblab
   cd ../
   i=$(( $i + 1));
done

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
