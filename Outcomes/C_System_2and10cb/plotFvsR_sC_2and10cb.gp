set terminal postscript eps color enhanced "Times-Roman"
set size 1.1,1.1
set ylabel "{{/RomanOblique Fmean (R)}}"
set xlabel "{{/RomanOblique R}}"
#set xrange [0:2]
#set yrange [-1e8:1e8]
#unset key
set grid


set output "| epstopdf -f -o=plotFvsR_sC_2and10cb_B100.pdf"
set multiplot layout 1,2 title "Fmean vs R (Gamma=1e4, Beta=100)" margins 0.12, 1, 0.19, 0.9 spacing 0.1

p "C_2cb.csv" u 1:2 w l lw 2 lc rgb "red" t "2 constrained beads"

p "C_10cb.csv" u 1:2 w l lw 2 lc rgb "green" t "10 constrained beads"

unset multiplot


set output
#   EOF
