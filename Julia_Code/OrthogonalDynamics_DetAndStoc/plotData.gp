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

set output "| epstopdf -f -o=../Outcomes/OrthogonalDynamics_DetAndStoc/plotData_sC_DET.pdf"
set multiplot layout 2,2 title "System C, Constrained beds 2\n \n(Deterministic System)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1

set ylabel "{{/RomanOblique First Stress Moment}}"
set logscale x
p "../Outcomes/OrthogonalDynamics_DetAndStoc/data_sC_DET.csv" u 2:3 w lp lw 2 lc rgb "red"

set ylabel "{{/RomanOblique Second Stress Moment}}"
set logscale x
p "../Outcomes/OrthogonalDynamics_DetAndStoc/data_sC_DET.csv" u 2:4 w lp lw 2 lc rgb "blue"

set ylabel "{{/RomanOblique Variance Stress Moment}}"
set logscale x
p "../Outcomes/OrthogonalDynamics_DetAndStoc/data_sC_DET.csv" u 2:5 w lp lw 2 lc rgb "blue"

unset multiplot


set output "| epstopdf -f -o=../Outcomes/OrthogonalDynamics_DetAndStoc/plotData_sC_STOC.pdf"
set multiplot layout 2,2 title "System C, Constrained beds 2, Beta=1, Gamma=1" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1

set ylabel "{{/RomanOblique First Stress Moment}}"
set logscale x
p "../Outcomes/OrthogonalDynamics_DetAndStoc/data_sC_STOC.csv" u 2:3 w lp lw 2 lc rgb "red"

set ylabel "{{/RomanOblique Second Stress Moment}}"
set logscale x
p "../Outcomes/OrthogonalDynamics_DetAndStoc/data_sC_STOC.csv" u 2:4 w lp lw 2 lc rgb "blue"

set ylabel "{{/RomanOblique Variance Stress Moment}}"
set logscale x
p "../Outcomes/OrthogonalDynamics_DetAndStoc/data_sC_STOC.csv" u 2:5 w lp lw 2 lc rgb "blue"

unset multiplot

set output
#   EOF
