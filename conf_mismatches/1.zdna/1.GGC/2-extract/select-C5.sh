#!/bin/bash


for j in `seq 0 19`;do

w=`seq 1 5; seq 48 52`
w1=`seq 22 31`

vmd -nt -dispdev text <<EOF
set outDataFile [open tmp w]

mol new ../2-extract/ref$j.pdb

set res { $w }
foreach i \$res {
 set bb [atomselect top "resid \$i and name C5'"]
 set ind [\$bb get index]
 foreach n \$ind {
  puts -nonewline stderr "[expr \$n+1], "
 }
}

puts stderr " "

foreach i \$res {
 set bb [atomselect top "resid \$i and name C5'"]
 set coord [\$bb get {x y z}]
 foreach n \$coord {
  puts \$outDataFile "\$n, "
 }
}

quit
EOF

vmd -nt -dispdev text <<EOF
set outDataFile [open tmp1 w]

mol new ../2-extract/ref$j.pdb

set res { $w1 }
foreach i \$res {
 set bb [atomselect top "resid \$i and name C5'"]
 set ind [\$bb get index]
 foreach n \$ind {
  puts -nonewline stderr "[expr \$n+1], "
 }
}

puts stderr " "

foreach i \$res {
 set bb [atomselect top "resid \$i and name C5'"]
 set coord [\$bb get {x y z}]
 foreach n \$coord {
  puts \$outDataFile "\$n, "
 }
}

quit
EOF


# only two decimal, in three columns 
#awk '{printf "%.2f, %.2f, %.2f,\n\t", $1, $2, $3}' tmp > coord.dat
coord1=`awk '{printf "%.2f, %.2f, %.2f, ", $1, $2, $3}' tmp`
coord2=`awk '{printf "%.2f, %.2f, %.2f, ", $1, $2, $3}' tmp1`
sed "s/COORD1/$coord1/g;s/COORD2/$coord2/g" ./cv-inpcrd.in > cv-inpcrd$j.in
done
