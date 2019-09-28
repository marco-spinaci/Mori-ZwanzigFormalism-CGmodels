set terminal postscript eps color enhanced "Times-Roman" 12
set size 1.1,1.1

set xlabel "{{/RomanOblique R}}" font ",16"
#set logscale xy
unset key
set grid

######################################################################
# file "C_B*_G*.csv"
# num.col.     valori
#   1     ->    RR
#   2     ->    PP
#   3     ->    Veff
#   4     ->    Fmean
#   5     ->    Fstd
######################################################################

## system A
# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sA_100.pdf"
# set multiplot layout 2,2 title "System A, Constrained beds 2, Beta=1, Gamma=1,\n\n\
#  dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, MacroSamples=100" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
#
# set ylabel "{{/RomanOblique Mean Force}}"
# p "./ABCD_Systems/Outcomes/sA_100.csv" u 1:4 w l lw 2 lc rgb "red"
# set ylabel "{{/RomanOblique Fluctuating Force}}"
# p "./ABCD_Systems/Outcomes/sA_100.csv" u 1:5 w l lw 2 lc rgb "blue"
# set ylabel "{{/RomanOblique Effective Potential}}"
# p "./ABCD_Systems/Outcomes/sA_100.csv" u 1:3 w l lw 2 lc rgb "green"
#
# unset multiplot
# set output


## system B
set output "| epstopdf -f -o=./ABCD_Systems/Plots/sB_2000.pdf"
set multiplot layout 2,2 title "System B, Constrained beds 2, Beta=1, Gamma=1,\n\n\
 dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, MacroSamples=2000, Time required for execution = 54h" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1

set ylabel "{{/RomanOblique Mean Force}}"
p "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:4 w l lw 2 lc rgb "red"
set ylabel "{{/RomanOblique Fluctuating Force}}"
p "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:5 w l lw 2 lc rgb "blue"
set ylabel "{{/RomanOblique Effective Potential}}"
p "./ABCD_Systems/Outcomes/sB_2000.csv" u 1:3 w l lw 2 lc rgb "green"

unset multiplot
set output


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
# unset multiplotz
# set output


## system D
# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sD_2000.pdf"
# set multiplot layout 2,2 title "System D, Constrained beds 2, Beta=1, Gamma=1,\n\n\
#  dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, MacroSamples=2000, Time required for execution = 54h" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
#
# set ylabel "{{/RomanOblique Mean Force}}"
# p "./ABCD_Systems/Outcomes/sD_2000.csv" u 1:4 w l lw 2 lc rgb "red"
# set ylabel "{{/RomanOblique Fluctuating Force}}"
# p "./ABCD_Systems/Outcomes/sD_2000.csv" u 1:5 w l lw 2 lc rgb "blue"
# set ylabel "{{/RomanOblique Effective Potential}}"
# p "./ABCD_Systems/Outcomes/sD_2000.csv" u 1:3 w l lw 2 lc rgb "green"
#
# unset multiplot
# set output

##################################################################################################################

# set output "| epstopdf -f -o=./ABCD_Systems/Plots/sABCD_100.pdf"
# set multiplot layout 2,2 title "System A,B,C,D\n\n\
# Constrained beds 2, Beta=1, Gamma=1, dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, MacroSamples=100" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
#
#
#  set key right bottom
#  set ylabel "{{/RomanOblique Mean Force}}" font ",16"
#  p "./ABCD_Systems/Outcomes/sA_100.csv" u 1:4 w l lw 3 lc rgb "red" t "A" ,\
#    "./ABCD_Systems/Outcomes/sB_100.csv" u 1:4 w l lw 3 lc rgb "green" dashtype 3 t "B" ,\
#    "./ABCD_Systems/Outcomes/sC_100.csv" u 1:4 w l lw 3 lc rgb "blue" dashtype 4 t "C" ,\
#    "./ABCD_Systems/Outcomes/sD_100.csv" u 1:4 w l lw 3 lc rgb "black" dashtype 6 t "D"
#
#  set key right top
#  set ylabel "{{/RomanOblique Fluctuating Force}}"
#  p "./ABCD_Systems/Outcomes/sA_100.csv" u 1:5 w l lw 3 lc rgb "red" t "A" ,\
#    "./ABCD_Systems/Outcomes/sB_100.csv" u 1:5 w l lw 3 lc rgb "green" dashtype 3 t "B" ,\
#    "./ABCD_Systems/Outcomes/sC_100.csv" u 1:5 w l lw 3 lc rgb "blue" dashtype 4 t "C" ,\
#    "./ABCD_Systems/Outcomes/sD_100.csv" u 1:5 w l lw 3 lc rgb "black" dashtype 6 t "D"
#
#  set key right top
#  set ylabel "{{/RomanOblique Effective Potential}}"
#  p "./ABCD_Systems/Outcomes/sA_100.csv" u 1:3 w l lw 3 lc rgb "red" t "A" ,\
#    "./ABCD_Systems/Outcomes/sB_100.csv" u 1:3 w l lw 3 lc rgb "green" dashtype 3 t "B" ,\
#    "./ABCD_Systems/Outcomes/sC_100.csv" u 1:3 w l lw 3 lc rgb "blue" dashtype 4 t "C" ,\
#    "./ABCD_Systems/Outcomes/sD_100.csv" u 1:3 w l lw 3 lc rgb "black" dashtype 6 t "D"
#
#  unset multiplot
#  set output

#   EOF
