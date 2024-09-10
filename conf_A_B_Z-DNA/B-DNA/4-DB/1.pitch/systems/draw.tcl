mol new ref.pdb

proc vmd_draw_arrow {mol start end} {
    # an arrow is made of a cylinder and a cone
    set middle [vecadd $start [vecscale 0.9 [vecsub $end $start]]]
    graphics $mol cylinder $start $middle radius 1
    graphics $mol cone $middle $end radius 2
}

# Since it was returing the opposite direction, we times everything
# by -1.0
set pro [atomselect top "resid 1 to 5 26 to 30 and name P"]
set center [measure center $pro]
set u1 [lindex [measure inertia $pro] 1 0]
set u2 [lindex [measure inertia $pro] 1 1]
set u3 [lindex [measure inertia $pro] 1 2]

set pro1 [atomselect top "resid 11 to 20 and name P"]
set center1 [measure center $pro1]
set u4 [lindex [measure inertia $pro1] 1 0]
set u5 [lindex [measure inertia $pro1] 1 1]
set u6 [lindex [measure inertia $pro1] 1 2]

draw color yellow
vmd_draw_arrow top $center [vecadd [vecscale -40 $u1] $center]
draw color green
vmd_draw_arrow top $center [vecadd [vecscale -40 $u2] $center]
draw color orange
vmd_draw_arrow top $center [vecadd [vecscale -40 $u3] $center]

draw color yellow
vmd_draw_arrow top $center1 [vecadd [vecscale 40 $u4] $center1]
draw color green
vmd_draw_arrow top $center1 [vecadd [vecscale 40 $u5] $center1]
draw color orange
vmd_draw_arrow top $center1 [vecadd [vecscale 40 $u6] $center1]
