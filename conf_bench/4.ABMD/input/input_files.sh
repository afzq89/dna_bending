#!/bin/bash

cp ../../3.SMD/slowest/systems/prmtop ./
cp ../../3.SMD/slowest/systems/RST ./

# initial coordinate for all replicas is the same,
# but this is not a problem since they randomely move in
# ABMD scheme
for i in `seq 7`; do
cp ../../3.SMD/slowest/systems/c0.rst pre.ncrst.${i} 
done
