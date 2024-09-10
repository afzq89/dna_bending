# A VMD/TCL script to draw principal axies

mol new ref.pdb

proc vmd_draw_arrow {mol start end} {
    # an arrow is made of a cylinder and a cone
    set middle [vecadd $start [vecscale 0.9 [vecsub $end $start]]]
    graphics $mol cylinder $start $middle radius 1
    graphics $mol cone $middle $end radius 2
}

set pro [atomselect top "resid 1 to 30 and name P"]
set center [measure center $pro]
set u1 [lindex [measure inertia $pro] 1 0]
set u2 [lindex [measure inertia $pro] 1 1]
set u3 [lindex [measure inertia $pro] 1 2]


draw color yellow
vmd_draw_arrow top $center [vecadd [vecscale 35 $u1] $center]
draw color green
vmd_draw_arrow top $center [vecadd [vecscale 35 $u2] $center]
draw color orange
vmd_draw_arrow top $center [vecadd [vecscale 35 $u3] $center]
