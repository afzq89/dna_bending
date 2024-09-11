#!/bin/bash
# A script to make w-c and torsion angle restraints 
set -e 
rm -rf *.wc RST
pdb=GGC-zz-out-ol15-nw

# w-c for all GC and edges 
array1=(1 27) 
array=(52 26)
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


# make RST
lib=/home/afakhar/src/amber20_src/AmberTools/src/nmr_aux/prepare_input/tordef.lib
makeDIST_RST -ual 8col.wc -pdb $pdb.pdb -rst rst1

cat rst1 > RST
rm -rf rst rst1

echo " "
echo "Now set the force in RST"
