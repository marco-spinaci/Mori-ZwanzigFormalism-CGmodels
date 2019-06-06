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
# file "data_OrthogonalDynamics.csv"
# num.col.       valori
#   1     ->   samples
#   2     ->   First Stress Moments
#   3     ->   Second Stress Moments
#   4     ->   Var Stress Moments
######################################################################

set output "| epstopdf -f -o=plotOD_2.pdf"
set multiplot layout 2,2 title "System C, Constrained beds 2\n \n(Deterministic System)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1

set ylabel "{{/RomanOblique First Stress Moment}}"
set logscale x
p "data_OD_2.csv" u 1:2 w l lw 2 lc rgb "red"

set ylabel "{{/RomanOblique Second Stress Moment}}"
set logscale x
p "data_OD_2.csv" u 1:3 w l lw 2 lc rgb "blue"

set ylabel "{{/RomanOblique Variance Stress Moment}}"
set logscale x
p "data_OD_2.csv" u 1:4 w l lw 2 lc rgb "blue"

unset multiplot
