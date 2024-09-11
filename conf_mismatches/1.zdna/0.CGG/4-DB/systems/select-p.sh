#!/bin/bash

j=0
# Change this seq.
#w=`seq 1 5; seq 26 30`
w=`seq 11 20`

vmd -nt -dispdev text <<EOF
set outDataFile [open tmp w]

mol new ../../2-extract/ref$j.pdb

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
