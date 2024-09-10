#!/bin/bash


for j in `seq 0 19`;do

w=`seq 1 5; seq 26 30`
w1=`seq 11 20`

vmd -nt -dispdev text <<EOF
set outDataFile [open tmp w]
        
mol new ../../../2-extract/ref$j.pdb

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

mol new ../../../2-extract/ref$j.pdb

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

vmd -nt -dispdev text <<EOF
set outDataFile [open tmp2 w]

mol new ../../../2-extract/ref$j.pdb

set pro [atomselect top "resid 1 to 30 and name P"]
set u1 [lindex [measure inertia \$pro] 1 0]
set u2 [lindex [measure inertia \$pro] 1 2]
set u3 [lindex [measure inertia \$pro] 1 1]

puts \$outDataFile "[lindex \$u1 0], [lindex \$u1 1], [lindex \$u1 2] "
puts \$outDataFile "[lindex \$u2 0], [lindex \$u2 1], [lindex \$u2 2] "
puts \$outDataFile "[lindex \$u3 0], [lindex \$u3 1], [lindex \$u3 2] "

quit
EOF

# only two decimal, in three columns 
#awk '{printf "%.2f, %.2f, %.2f,\n\t", $1, $2, $3}' tmp > coord.dat
coord1=`awk '{printf "%.2f, %.2f, %.2f, ", $1, $2, $3}' tmp`
coord2=`awk '{printf "%.2f, %.2f, %.2f, ", $1, $2, $3}' tmp1`
axis1=`sed -n '1,1p' tmp2 | awk '{printf "%.2f, %.2f, %.2f, ", $1, $2, $3}'`
axis2=`sed -n '2,2p' tmp2 | awk '{printf "%.2f, %.2f, %.2f, ", $1, $2, $3}'`
axis3=`sed -n '3,3p' tmp2 | awk '{printf "%.2f, %.2f, %.2f, ", $1, $2, $3}'`
sed "s/COORD1/$coord1/g;s/COORD2/$coord2/g;s/AXIS1/$axis1/g;s/AXIS2/$axis2/g;s/AXIS3/$axis3/g" ../cv-pmd.in > cv-pmd$j.in
sed "s/AXIS3/$axis3/g" ../cv-smd.in > cv-smd$j.in
done
