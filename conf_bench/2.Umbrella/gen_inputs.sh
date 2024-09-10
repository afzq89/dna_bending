#!/bin/bash
w=`seq 0.0 2.0 150.0`
arr=($w)

for i in "${!arr[@]}"; do

sed "s/HERE/${arr[i]}/g" cv-tmp.in > cv-inpcrd.in
sed "s/HERE/${i}/g" pmd.in > pmd${i}.in

done
