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

plot "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:3
minA = GPVAL_DATA_Y_MIN
plot "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:3
minB = GPVAL_DATA_Y_MIN
plot "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:3
minC = GPVAL_DATA_Y_MIN
plot "./ABCD_Systems/Outcomes/sD_4000.csv" u 1:3
minD = GPVAL_DATA_Y_MIN

plot "./ABCD_Systems/Outcomes/sA_50_300p.csv" u 1:3
minA300 = GPVAL_DATA_Y_MIN
plot "./ABCD_Systems/Outcomes/sB_50_300p.csv" u 1:3
minB300 = GPVAL_DATA_Y_MIN
plot "./ABCD_Systems/Outcomes/sC_20_300p.csv" u 1:3
minC300 = GPVAL_DATA_Y_MIN
plot "./ABCD_Systems/Outcomes/sD_50_300p.csv" u 1:3
minD300 = GPVAL_DATA_Y_MIN


## system A
# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sA_2000.pdf"
# set multiplot layout 2,2 title "System A, Constrained beds 2, Beta=1, Gamma=1,\n\n\
#  dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, MacroSamples=2000" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
#
# set ylabel "{{/RomanOblique Mean Force}}"
# p "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:4 w l lw 2 lc rgb "red"
# set ylabel "{{/RomanOblique Fluctuating Force}}"
# p "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:5 w l lw 2 lc rgb "blue"
# set ylabel "{{/RomanOblique Effective Potential}}"
# p "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:3 w l lw 2 lc rgb "green"
#
# unset multiplot
# set output

# set key
# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sA_50_300p_CONFR.pdf"
# set multiplot layout 2,2 margins 0.12, 1, 0.09, 0.88 spacing 0.1
#
# set ylabel "{{/RomanOblique Mean Force}}"
# p  "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:($4*(-1)) w l lw 2 lc rgb "orange" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sA_50_300p.csv" u 1:($4*(-1)) w p lw 2 lc rgb "red" t "100 Beads"
# set ylabel "{{/RomanOblique Effective Potential}}"
# p  "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:($3-minA) w l lw 2 lc rgb "olive" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sA_50_300p.csv" u 1:($3-minA300) w p lw 2 lc rgb "green" t "100 Beads"
# set ylabel "{{/RomanOblique Fluctuating Force}}"
# p  "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:5 w l lw 2 lc rgb "violet" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sA_50_300p.csv" u 1:5 w p lw 2 lc rgb "blue" t "100 Beads"
#
# unset multiplot
# set output

## system B
# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sB_2000.pdf"
# set multiplot layout 2,2 title "System B, Constrained beds 2, Beta=1, Gamma=1,\n\n\
#  dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, MacroSamples=2000, Time required for execution = 54h" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
#
# set ylabel "{{/RomanOblique Mean Force}}"
# p "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:4 w l lw 2 lc rgb "red"
# set ylabel "{{/RomanOblique Fluctuating Force}}"
# p "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:5 w l lw 2 lc rgb "blue"
# set ylabel "{{/RomanOblique Effective Potential}}"
# p "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:3 w l lw 2 lc rgb "green"
#
# unset multiplot
# set output

# set key
# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sB_50_300p_CONFR.pdf"
# set multiplot layout 2,2 margins 0.12, 1, 0.09, 0.88 spacing 0.1
#
# set ylabel "{{/RomanOblique Mean Force}}"
# p  "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:($4*(-1)) w l lw 2 lc rgb "orange" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sB_50_300p.csv" u 1:($4*(-1)) w p lw 2 lc rgb "red" t "100 Beads"
# set ylabel "{{/RomanOblique Effective Potential}}"
# p  "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:($3-minB) w l lw 2 lc rgb "olive" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sB_50_300p.csv" u 1:($3-minB300) w p lw 2 lc rgb "green" t "100 Beads"
# set ylabel "{{/RomanOblique Fluctuating Force}}"
# p  "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:5 w l lw 2 lc rgb "violet" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sB_50_300p.csv" u 1:5 w p lw 2 lc rgb "blue" t "100 Beads"
#
# unset multiplot
# set output


## system C
# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sC_2000.pdf"
# set multiplot layout 2,2 title "System C, Constrained beds 2, Beta=1, Gamma=1,\n\n\
#  dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, MacroSamples=2000, Time required for execution = 54h" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
#
# set ylabel "{{/RomanOblique Mean Force}}"
# p "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:4 w l lw 2 lc rgb "red"
# set ylabel "{{/RomanOblique Fluctuating Force}}"
# p "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:5 w l lw 2 lc rgb "blue"
# set ylabel "{{/RomanOblique Effective Potential}}"
# p "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:3 w l lw 2 lc rgb "green"
#
# unset multiplot
# set output

# set key
# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sC_20_300p_CONFR.pdf"
# set multiplot layout 2,2 margins 0.12, 1, 0.09, 0.88 spacing 0.1
# #title "System C, Constrained beds 2, Beta=1, Gamma=1,\n\n\
# # dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, MacroSamples=20, Nbeads=100, Time required for execution = 9gg" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
#
# set ylabel "{{/RomanOblique Mean Force}}"
# p  "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:($4*(-1)) w l lw 2 lc rgb "orange" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sC_20_300p.csv" u 1:($4*(-1)) w p lw 2 lc rgb "red" t "100 Beads"
# set ylabel "{{/RomanOblique Effective Potential}}"
# p  "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:($3-minC) w l lw 2 lc rgb "olive" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sC_20_300p.csv" u 1:($3-minC300) w p lw 2 lc rgb "green" t "100 Beads"
# set ylabel "{{/RomanOblique Fluctuating Force}}"
# p  "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:5 w l lw 2 lc rgb "violet" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sC_20_300p.csv" u 1:5 w p lw 2 lc rgb "blue" t "100 Beads"
#
# unset multiplot
# set output


# system D
# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sD_4000.pdf"
# set multiplot layout 2,2 title "System D, Constrained beds 2, Beta=1, Gamma=1,\n\n\
#  dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, MacroSamples=4000, Time required for execution = 12d12h(299h)" margins 0.12, 1, 0.09, 0.88 spacing 0.1
#
# set ylabel "{{/RomanOblique Mean Force}}"
# p "./ABCD_Systems/Outcomes/sD_4000.csv" u 1:(-1*$4) w l lw 2 lc rgb "red"
# set ylabel "{{/RomanOblique Fluctuating Force}}"
# p "./ABCD_Systems/Outcomes/sD_4000.csv" u 1:5 w l lw 2 lc rgb "blue"
# set ylabel "{{/RomanOblique Effective Potential}}"
# p "./ABCD_Systems/Outcomes/sD_4000.csv" u 1:3 w l lw 2 lc rgb "green"
#
# unset multiplot
# set output

# set key
# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sD_50_300p_CONFR.pdf"
# set multiplot layout 2,2 margins 0.12, 1, 0.09, 0.88 spacing 0.1
#
# set ylabel "{{/RomanOblique Mean Force}}"
# p  "./ABCD_Systems/Outcomes/sD_4000.csv" u 1:($4*(-1)) w l lw 2 lc rgb "orange" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sD_50_300p.csv" u 1:($4*(-1)) w p lw 2 lc rgb "red" t "100 Beads"
# set ylabel "{{/RomanOblique Effective Potential}}"
# p  "./ABCD_Systems/Outcomes/sD_4000.csv" u 1:($3-minD) w l lw 2 lc rgb "olive" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sD_50_300p.csv" u 1:($3-minA300) w p lw 2 lc rgb "green" t "100 Beads"
# set ylabel "{{/RomanOblique Fluctuating Force}}"
# p  "./ABCD_Systems/Outcomes/sD_4000.csv" u 1:5 w l lw 2 lc rgb "violet" t "10 Beads", \
#    "./ABCD_Systems/Outcomes/sD_50_300p.csv" u 1:5 w p lw 2 lc rgb "blue" t "100 Beads"
#
# unset multiplot
# set output

##################################################################################################################

# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sABCD_2000.pdf"
# set multiplot layout 2,2 \
# title "System A,B,C,D\n\n\ Constrained beds 2, Beta=1, Gamma=1, dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, MacroSamples=2000" font ",14" \
# margins 0.12, 1, 0.09, 0.88 spacing 0.1

# set output "| epstopdf -f -o=../TEX_Notes/Figure/sABCD_2000_MF.pdf"
#  set key right top
#  set ylabel "{{/Roman Mean Force}}" #font ",30"
#  p "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:(-1*$4) w l lw 5 lc 0 t "A" ,\
#    "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:(-1*$4) w l lw 5 lc 6 dashtype 3 t "B" ,\
#    "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:(-1*$4) w l lw 5 lc 7 dashtype 4 t "C" ,\
#    "./ABCD_Systems/Outcomes/sD_2000.csv" u 1:(-1*$4) w l lw 5 lc 10 dashtype 6 t "D"

set xrange[2.6:3.5]
set yrange[0:40]
# set ytics 10
#
# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sABCD_2000_FF.pdf"
# set output "| epstopdf -f -o=../TEX_Notes/Figure/sABCD_2000_FF.pdf"
#  set key right top #font ",30"
#
#  set ylabel "{{/Roman Fluctuating Force}}" #font ",30"
#  p "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:5 w l lw 5 lc 0 t "A" ,\
#    "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:5 w l lw 5 lc 6 dashtype 3 t "B" ,\
#    "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:5 w l lw 5 lc 7 dashtype 4 t "C" ,\
#    "./ABCD_Systems/Outcomes/sD_2000.csv" u 1:5 w l lw 5 lc 10 dashtype 6 t "D"

set output "| epstopdf -f -o=./ABCD_Systems/Plots/sABCD_300p_FF.pdf"
 set key right top #font ",30"

 set ylabel "{{/Roman Fluctuating Force}}" #font ",30"
 p "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:5 w l lw 2 lc rgb "violet" t "10 Beads - A", \
   "./ABCD_Systems/Outcomes/sA_50_300p.csv" u 1:5 w p lw 2 lc rgb "blue" t "100 Beads - A", \
   "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:5 w l lw 2 lc rgb "olive" t "10 Beads - B", \
   "./ABCD_Systems/Outcomes/sB_50_300p.csv" u 1:5 w p lw 2 lc rgb "green" t "100 Beads - B", \
   "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:5 w l lw 2 lc rgb "orange" t "10 Beads - C", \
   "./ABCD_Systems/Outcomes/sC_20_300p.csv" u 1:5 w p lw 2 lc rgb "red" t "100 Beads - C", \
   "./ABCD_Systems/Outcomes/sD_4000.csv" u 1:5 w l lw 2 lc rgb "brown" t "10 Beads - D", \
   "./ABCD_Systems/Outcomes/sD_50_300p.csv" u 1:5 w p lw 2 lc rgb "black" t "100 Beads - D"

# set output "| epstopdf -f -o=../TEX_Notes/Figure/sABCD_2000_EP.pdf"
#  set key right top
#  set ylabel "{{/Roman Effective Potential}}" #font ",30"
#  p "./ABCD_Systems/Outcomes/sA_2000.csv" u 1:($3-minA) w l lw 5 lc 0 t "A" ,\
#    "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:($3-minB) w l lw 5 lc 6 dashtype 3 t "B" ,\
#    "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:($3-minC) w l lw 5 lc 7 dashtype 4 t "C" ,\
#    "./ABCD_Systems/Outcomes/sD_2000.csv" u 1:($3-minD) w l lw 5 lc 10 dashtype 6 t "D"

set output

#   EOF
