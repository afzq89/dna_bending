#!/bin/sh
#

tleap -s -f - <<_EOF > leap.log &

source leaprc.DNA.OL15
source leaprc.water.tip3p

GGC = loadpdb inital.pdb
# 5 M NaCL
# 2 mM NICL2 # They diffused away; no need to be included 
# total ions XXX added
addions GGC Cl- 1580
addions GGC NI 63
addions GGC Na+ 0
solvateoct GGC TIP3PBOX 8.0

check 
saveamberparm GGC prmtop inpcrd
savepdb GGC GGC-zz-out-ol15.pdb

quit
_EOF

#N_ions (tot: Cl) = 0.0187 * ionConc * nWater
