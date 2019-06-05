set terminal postscript eps color enhanced "Times-Roman" 9
set size 1.1,1.1
#set ylabel "{{/RomanOblique Fmean (R)}}"
set xlabel "{{/RomanOblique Samples}}"
#set xrange [0:2]
#set yrange [-1e8:1e8]
#set logscale xy
unset key
set grid

######################################################################
# file "data_sC_DET.csv" o "data_sC_Stoc_B*_G*.csv"
# num.col.       valori
#   1     ->   RR
#   2     ->   samples
#   3     ->   First Stress Moments
#   4     ->   Second Stress Moments
#   5     ->   Var Stress Moments
######################################################################

set output "| epstopdf -f -o=plotData_sC_B1_G1.pdf"
set multiplot layout 2,2 title "System C, Constrained beds 2, Beta=100, Gamma=10^5" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1

set ylabel "{{/RomanOblique First Stress Moment}}"
set logscale x
p "data_sC_B1_G1.csv" u 2:3 w lp lw 2 lc rgb "red"
set ylabel "{{/RomanOblique Variance Stress Moment}}"
set logscale x
p "data_sC_B1_G1.csv" u 2:4 w lp lw 2 lc rgb "blue"
set ylabel "{{/RomanOblique Mean Stress Moment}}"
set logscale x
p "data_sC_B1_G1.csv" u 2:5 w lp lw 2 lc rgb "blue"
set ylabel "{{/RomanOblique Variance Stress Moment}}"
set logscale x
p "data_sC_B1_G1.csv" u 2:6 w lp lw 2 lc rgb "blue"



unset multiplot

set output
#   EOF
