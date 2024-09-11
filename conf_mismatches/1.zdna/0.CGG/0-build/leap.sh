#!/bin/sh
#

tleap -s -f - <<_EOF > leap.log &

source leaprc.DNA.OL15
source leaprc.water.tip3p

GGC = loadpdb main_view02.pdb
# 5 M NaCL
# total ions XXX added
addions GGC Cl- 691
addions GGC Na+ 0
solvateoct GGC TIP3PBOX 8.0

check 
saveamberparm GGC prmtop inpcrd
savepdb GGC CGG-zdna.pdb

quit
_EOF

#N_ions (tot: Cl) = 0.0187 * ionConc * nWater
