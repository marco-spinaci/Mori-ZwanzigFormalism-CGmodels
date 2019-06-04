set terminal postscript eps color enhanced "Times-Roman" 9
set size 1.1,1.1
#set ylabel "{{/RomanOblique Fmean (R)}}"
set xlabel "{{/RomanOblique Samples}}"
#set xrange [0:2]
#set yrange [-1e8:1e8]
set logscale x
unset key
set grid

######################################################################
# file "FvsR_sC_BETA_G*.csv"
# num.col.       valori
#   1     ->   RR
#   2     ->   samples
#   3     ->   FirstStress
#   4     ->   VarStress
######################################################################

set output "| epstopdf -f -o=plotData_sC_B100_G1e5.pdf"
set multiplot layout 1,2 title "System C, Constrained beds 2, Beta=100, Gamma=1e5" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1

set ylabel "{{/RomanOblique First Stress Moments}}"
p "data_sC_B100_G1e5.csv" u 2:3 w p lw 2 lc rgb "red"
set ylabel "{{/RomanOblique Variance Stress Moments}}"
p "data_sC_B100_G1e5.csv" u 2:4 w p lw 2 lc rgb "blue"

unset multiplot

set output
#   EOF
