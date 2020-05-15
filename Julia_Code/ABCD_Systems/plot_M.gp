set terminal postscript eps color enhanced "Times-Roman" 14#30 #size 7,15 #13
set size 1,1

set xlabel "{{/RomanOblique R}}" #font ",30"
#set logscale xy
set grid

######################################################################
# file "s*_*.csv"
# num.col.     valori
#   1     ->    RR
#   2     ->    PP
#   3     ->    Veff
#   4     ->    Fmean
#   5     ->    Fstd
######################################################################

# plot "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:3
# minA = GPVAL_DATA_Y_MIN
# plot "./ABCD_Systems/Outcomes/sB_M2.csv" u 1:3
# minB = GPVAL_DATA_Y_MIN
# plot "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:3
# minC = GPVAL_DATA_Y_MIN
# plot "./ABCD_Systems/Outcomes/sD_M2.csv" u 1:3
# minD = GPVAL_DATA_Y_MIN

# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sB_mMm.pdf"
#  set key right top #font ",30"
#
#  set ylabel "{{/Roman Mean Force}}" #font ",30"
#  p "./ABCD_Systems/Outcomes/sB_M20.csv" u 1:(-1*$4) w p lw 2 lc rgb "yellow" t "m=1 M=20 system B (m-M-m)", \
#    "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:(-1*$4) w l lw 2 lc rgb "red" t "m=1 M=10 system B (m-M-m)", \
#    "./ABCD_Systems/Outcomes/sB_M5.csv" u 1:(-1*$4) w p lw 2 lc rgb "orange" t "m=1 M=5 system B (m-M-m)", \
#    "./ABCD_Systems/Outcomes/sB_M2.csv" u 1:(-1*$4) w p lw 2 lc rgb "green" t "m=1 M=2 system B (m-M-m)"
#
#    # "./ABCD_Systems/Outcomes/sD_M20.csv" u 1:(-1*$4) w p lw 2 lc rgb "blue" t "m=1 M=20 system D (M-m-M)",\
#    # "./ABCD_Systems/Outcomes/sD_2000.csv" u 1:(-1*$4) w l lw 2 lc rgb "black" t "m=1 M=10 system D (M-m-M)",\
#    # "./ABCD_Systems/Outcomes/sD_M5.csv" u 1:(-1*$4) w p lw 2 lc rgb "brown" t "m=1 M=5 system D (M-m-M)", \
#    # "./ABCD_Systems/Outcomes/sD_M2.csv" u 1:(-1*$4) w p lw 2 lc rgb "violet" t "m=1 M=2 system D (M-m-M)",\
#
# set output

set output "| epstopdf -f -o=./ABCD_Systems/Plots/MeanForce_ABCD_10vs100b.pdf"

 set key right top #font ",30"
 set ylabel "{{/Roman Mean Force}}" #font ",30"
 set multiplot layout 2,2 title "\n System A (m-M-m) and system C (M-m-M), and system B (m-M-m) and system D (M-m-M) have the same interactions \n"

 p "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:(-1*$4) w l lw 2 lc rgb "violet" t "10 Beads - A", \
   "./ABCD_Systems/Outcomes/sA_50_300p.csv" u 1:(-1*$4) w p lw 2 lc rgb "blue" t "100 Beads - A"

 p "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:(-1*$4) w l lw 2 lc rgb "olive" t "10 Beads - B", \
   "./ABCD_Systems/Outcomes/sB_50_300p.csv" u 1:(-1*$4) w p lw 2 lc rgb "green" t "100 Beads - B"

 p "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:(-1*$4) w l lw 2 lc rgb "orange" t "10 Beads - C", \
   "./ABCD_Systems/Outcomes/sC_20_300p.csv" u 1:(-1*$4) w p lw 2 lc rgb "red" t "100 Beads - C"

 p "./ABCD_Systems/Outcomes/sD_2000.csv" u 1:(-1*$4) w l lw 2 lc rgb "brown" t "10 Beads - D", \
   "./ABCD_Systems/Outcomes/sD_50_300p.csv" u 1:(-1*$4) w p lw 2 lc rgb "black" t "100 Beads - D"

unset multiplot
set output
