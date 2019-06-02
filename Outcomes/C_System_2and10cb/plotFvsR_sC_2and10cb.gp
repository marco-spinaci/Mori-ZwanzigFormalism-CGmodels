set terminal postscript eps color enhanced "Times-Roman" 10
set size 1.1,1.1
set ylabel "{{/RomanOblique Fmean (R)}}"
set xlabel "{{/RomanOblique R}}"
#set xrange [0:2]
#set yrange [-1e8:1e8]
#set yrange [-2e3:2e3]
unset key
set grid


set output "| epstopdf -f -o=plotFvsR_sC_2and10cb_B100.pdf"
set multiplot layout 2,2 title "Fmean vs R (Gamma=1e4)" font ",16" margins 0.12, 1, 0.19, 0.9 spacing 0.1

set title "2 constrained beads, Beta=100"
p "C_2cb_B100.csv" u 1:2 w l lw 2 lc rgb "red"

set title "10 constrained beads, Beta=100"
p "C_10cb_B100.csv" u 1:2 w l lw 2 lc rgb "green"

set title "2 constrained beads, Beta=1000"
p "C_2cb_B1000.csv" u 1:2 w l lw 2 lc rgb "blue"

set title "10 constrained beads, Beta=1000"
p "C_10cb_B1000.csv" u 1:2 w l lw 2 lc rgb "olive"

unset multiplot


set output
#   EOF
