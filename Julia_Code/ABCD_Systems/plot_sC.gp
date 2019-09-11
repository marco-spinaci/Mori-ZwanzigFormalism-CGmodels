set terminal postscript eps color enhanced "Times-Roman" 9
set size 1.1,1.1
#set ylabel "{{/RomanOblique Fmean (R)}}"
set xlabel "{{/RomanOblique R}}"
#set xrange [0:2]
#set yrange [-1e8:1e8]
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

set output "| epstopdf -f -o=./ABCD_Systems/Plots/sC_100.pdf"
set multiplot layout 2,2 title "System C, Constrained beds 2, Beta=1, Gamma=1,\n\n\
 dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, MacroSamples=100" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1

set ylabel "{{/RomanOblique Mean Force}}"
p "./ABCD_Systems/Outcomes/sC_100.csv" u 1:4 w l lw 2 lc rgb "red"
set ylabel "{{/RomanOblique Fluctuating Force}}"
p "./ABCD_Systems/Outcomes/sC_100.csv" u 1:5 w l lw 2 lc rgb "blue"
set ylabel "{{/RomanOblique Effective Potential}}"
p "./ABCD_Systems/Outcomes/sC_100.csv" u 1:3 w l lw 2 lc rgb "green"

unset multiplot

set output
#   EOF
