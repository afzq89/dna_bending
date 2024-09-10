#!/bin/sh
#

tleap -s -f - <<_EOF > leap.log &

source leaprc.DNA.OL15
source leaprc.water.tip3p

GGC = loadpdb main_view01.pdb
# 0.15 M NaCL
# total ions XXX added
addions GGC Cl- 23
addions GGC Na+ 0
solvateoct GGC TIP3PBOX 8.0

check 
saveamberparm GGC prmtop inpcrd
savepdb GGC CG-bdna.pdb

quit
_EOF

#N_ions (tot: Cl) = 0.0187 * ionConc * nWater

