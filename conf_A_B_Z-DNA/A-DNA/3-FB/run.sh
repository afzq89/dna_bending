#!/bin/bash
# SMD simualtions
rm -rf nohup.out
set -e
w=`seq 0 1 2`
arr=($w)
for i in "${!arr[@]}"; do
   rm -rf $i
   mkdir $i
   cd $i 
   cp ../2-extract/cv-inpcrd$i.in ./cv-inpcrd.in
   sed "s/GPU/$i/g;s/HERE/c$i/g" ../README-smd-explicit-cblab > README-smd-explicit-cblab
   chmod +x README-smd-explicit-cblab
   ./README-smd-explicit-cblab &
   cd ../
done


