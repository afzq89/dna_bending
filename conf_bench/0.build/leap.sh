#!/bin/bash
#Solvate the system in water box with ions

tleap -s -f - <<_EOF > leap.log &

source leaprc.DNA.OL15
source leaprc.water.tip3p

GC = loadpdb main_view01.pdb
# 0.15 M NaCL
# total ions XXX added
addions GC Cl- 17
addions GC Na+ 0
solvateoct GGC TIP3PBOX 8.0

check 
saveamberparm GC prmtop inpcrd.rst7
savepdb GC GC-bdna.pdb

quit
_EOF

#N_ions (tot: Cl) = 0.0187 * ionConc * nWater

