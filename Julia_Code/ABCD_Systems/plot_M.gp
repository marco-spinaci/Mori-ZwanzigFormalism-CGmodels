set terminal postscript eps color enhanced "Times-Roman" 14#30 #size 7,15 #13
set size 1.1,1

set xlabel "{{/RomanOblique R}}" #font ",30"
#set logscale xy
unset key
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

set output "| epstopdf -f -o=./ABCD_Systems/Plots/sBD_M_10_confr_2.pdf"
 set key right top #font ",30"

 set ylabel "{{/Roman Mean Force}}" #font ",30"
 p "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:(-1*$4) w l lw 2 lc rgb "olive" t "m=1 M=10 system B", \
   "./ABCD_Systems/Outcomes/sB_M2.csv" u 1:(-1*$4) w p lw 2 lc rgb "green" t "m=1 M=2 system B", \
   "./ABCD_Systems/Outcomes/sD_4000.csv" u 1:(-1*$4) w l lw 2 lc rgb "brown" t "m=1 M=10 system D", \
   "./ABCD_Systems/Outcomes/sD_50_300p.csv" u 1:(-1*$4) w p lw 2 lc rgb "black" t "m=1 M=2 system D"

set output
