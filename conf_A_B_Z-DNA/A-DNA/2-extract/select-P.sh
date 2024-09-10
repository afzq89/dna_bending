#!/bin/bash
# The below script gets atom number and coordinates of P atoms in
# termini bases --  This is the same for all replicas

# Change the below seq.
j=10
#w=`seq 1 5; seq 26 30`
w=`seq 11 20`

vmd -nt -dispdev text <<EOF
set outDataFile [open tmp w]

mol new ./ref$j.pdb

set res { $w }
foreach i \$res {
 set bb [atomselect top "resid \$i and name P"]
 set ind [\$bb get index]
 foreach n \$ind {
  puts -nonewline stderr "[expr \$n+1], "
 }
}

puts stderr " "

foreach i \$res {
 set bb [atomselect top "resid \$i and name P"]
 set coord [\$bb get {x y z}]
 foreach n \$coord {
  puts \$outDataFile "\$n, "
 }
}

quit
EOF
