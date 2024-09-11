#!/bin/bash
# A script to make w-c and torsion angle restraints 
set -e 
rm -rf *.wc RST
pdb=CGG-bdna-nw

# w-c for all GC and edges 
array1=(1 4  7  10 13 16 19 22 25 28) 
array=(30 27 24 21 18 15 12 9  6  3 )
i=0
while [ $i -lt ${#array[*]} ]; do
cat >> 8col.wc << EOF
${array1[$i]}  DC   H41    ${array[$i]}   DG   O6      1.9    1.9
${array1[$i]}  DC   N4     ${array[$i]}   DG   O6      2.9    2.9
${array1[$i]}  DC   N3     ${array[$i]}   DG   H1      1.9    1.9
${array1[$i]}  DC   N3     ${array[$i]}   DG   N1      2.9    2.9
${array1[$i]}  DC   O2     ${array[$i]}   DG   H21     1.9    1.9
${array1[$i]}  DC   O2     ${array[$i]}   DG   N2      2.9    2.9
EOF
i=$(( $i + 1));
done 


#proposed H-bonds for GG: (syn)N7–N2:H21(anti) and (syn)O6-N1:H1(anti) (Feng)
i=0
array3=(2  8  14 20 26) #anti
array2=(29 23 17 11 5) #syn
while [ $i -lt ${#array2[*]} ]; do
cat >> 8col.wc << EOF
${array2[$i]} DG   N7     ${array3[$i]}   DG   H21   1.9    1.9
${array2[$i]} DG   N7     ${array3[$i]}   DG   N2    2.9    2.9
${array2[$i]} DG   O6     ${array3[$i]}   DG   H1    1.9    1.9
${array2[$i]} DG   O6     ${array3[$i]}   DG   N1    2.9    2.9
EOF
i=$(( $i + 1));
done
#proposed H-bond (internal) for syn G
i=0
array4=(29 23 17 11 5) #syn
while [ $i -lt ${#array4[*]} ]; do
cat >> 8col.wc << EOF
${array4[$i]} DG   OP2     ${array4[$i]}   DG   H22  1.9   1.9
${array4[$i]} DG   OP2     ${array4[$i]}   DG   N2   2.9   2.9
EOF
i=$(( $i + 1));
done

# Chi angles for w-c
#anti
i=0
array1=(1 4  7  10 13 16 19 22 25 28)
for i in ${array1[@]};do
cat >> 5col.wc << EOF
$i  DC CHI 95.0 265.0
EOF
done
array=(30 27 24 21 18 15 12 9 6 3)
for i in ${array[@]};do
cat >> 5col.wc << EOF
$i  DG CHI 95.0 265.0
EOF
done
# Chi angles for GG,
# base on Feng's command, it should be
# anti-syn in a zig-zag pattern
#anti-syn
i=0
array2=(2 8 14 20 26) #anti
for i in ${array2[@]};do
cat >> 5col.wc << EOF
$i  DG CHI 95.0 265.0
EOF
done
array3=(29 23 17 11 5) #syn
for i in ${array3[@]};do
cat >> 5col.wc << EOF
$i  DG CHI -85.0 85.0
EOF
done

# make RST
lib=/home/afakhar/src/amber20_src/AmberTools/src/nmr_aux/prepare_input/tordef.lib
makeANG_RST -pdb $pdb.pdb -con 5col.wc -lib $lib > rst
makeDIST_RST -ual 8col.wc -pdb $pdb.pdb -rst rst1

cat rst rst1 > RST
rm rst rst1

echo " "
echo "Now set the force in RST"

