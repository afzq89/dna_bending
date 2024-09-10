#!/bin/bash
# A script to make w-c and torsion angle restraints 
set -e 
rm -rf *.wc RST
pdb=GC-bdna.pdb

# just the termini bases
array1=(1 15) 
array=(30 16)
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
lib=$AMBERHOME/AmberTools/src/nmr_aux/prepare_input/tordef.lib
makeDIST_RST -ual 8col.wc -pdb $pdb.pdb -rst rst

cat rst > RST
rm rst 

echo " "
echo "Now set the force in RST"

