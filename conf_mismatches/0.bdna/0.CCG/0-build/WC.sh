#!/bin/bash
# A script to make w-c and torsion angle restraints 
set -e 
rm -rf *.wc RST
pdb=CCG-bdna-nw

# w-c for all GC and edges 
array1=(1 4  7  10 13 16) 
array=(30 27 24 21 18 15)
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


#proposed H-bonds for CC: N3–N4:H41 and N4:H41–N4 (Feng)
i=0
array2=(2  5  8  11 14)
array3=(29 26 23 20 17)
while [ $i -lt ${#array2[*]} ]; do
cat >> 8col.wc << EOF
${array2[$i]} DC   N3     ${array3[$i]}   DC   H41    1.9    1.9
${array2[$i]} DC   N3     ${array3[$i]}   DC   N4     2.9    2.9
${array2[$i]} DC   N4     ${array3[$i]}   DC   H41    1.9    1.9
${array2[$i]} DC   N4     ${array3[$i]}   DC   N4     2.9    2.9
EOF
i=$(( $i + 1));
done

# Chi angles for w-c
#anti
array1=(1 4  7  10 13 16)
for i in ${array[@]};do
cat >> 5col.wc << EOF
$i  DC CHI 95.0 265.0
EOF
done
array=(30 27 24 21 18 15)
for i in ${array[@]};do
cat >> 5col.wc << EOF
$i  DG CHI 95.0 265.0
EOF
done
# Chi angles for CC
#anti-anti
array2=(2 5 8 11 14)
for i in ${array2[@]};do
cat >> 5col.wc << EOF
$i  DC CHI 95.0 265.0
EOF
done
array3=(29 26 23 20 17)
for i in ${array3[@]};do
cat >> 5col.wc << EOF
$i  DC CHI 95.0 265.0
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

