# dna bending

This repository contains parameter and configuration files needed to reproduce the results of dna bending project: “A comparative study of the bending free energies of CG-based DNA: A-, B- and Z-DNA and associated mismatched trinucleotide repeats", Ashkan Fakharzadeh, Mahmoud Moradi, Celeste Sagui, and Christopher Roland

The conf_bench folder corresponds to the benchmarking of three enhanced sampling methods: Umbrella Sampling, Steered MD, and Adaptively Biased MD. This folder contains the initial PDB and scripts to generate prmtop and inpcrd files, AMBER configuration files, as well as run scripts to equilibrate a (CG)_7C regular B-DNA in explicit water and then bend it via quaternion-based collective variables using the aforementioned methods.

The conf_A_B_Z-DNA contains the initial PDB and scripts to generate prmtop and inpcrd files, AMBER configuration files, as well as run scripts to equilibrate (CG)_7C A-, B-, and Z-DNA in explicit water and then bend them via quaternion-based collective variables via Steered MD through two procedure of free bending and directed bending (20 replicas for each DNA-form) as explained in the method section of manuscript.

The conf_2D-ABMD folder contains the initial PDB and scripts to generate prmtop and inpcrd files, AMBER configuration files, as well as run scripts to run a 2D ABMD simulation as explained in the manscript. 

The conf_mismatches folder contains the initial PDB and scripts to generate prmtop and inpcrd files, AMBER configuration files, as well as run scripts to equilibrate mismatched DNA, CCG, GCC, CGG, GCC in explicit water and then bend them via quaternion-based collective variables via Steered MD through two procedure of free bending and directed bending (20 replicas for each DNA-form) as explained in the method section of manuscript.
