set terminal postscript eps color enhanced "Times-Roman" 9
set size 1.1,1.1
set ylabel "{{/RomanOblique Fmean (R)}}"
set xlabel "{{/RomanOblique R}}"
#set xrange [0:2]
#set yrange [-1e8:1e8]
unset key
set grid


set output "| epstopdf -f -o=plotFvsR_sC_2and10cb_G1e5.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "2 constrained beads, Beta=10, Gamma=1e5"
p "C_2cb_B10_G1e5.csv" u 1:2 w l lw 2 lc rgb "red"
#set title "10 constrained beads, Beta=10"
#p "C_10cb_B10_G1e5.csv" u 1:2 w l lw 2 lc rgb "green"
set title "2 constrained beads, Beta=100, Gamma=1e5"
p "C_2cb_B100_G1e5.csv" u 1:2 w l lw 2 lc rgb "green"
#set title "10 constrained beads, Beta=100"
#p "C_10cb_B100_G1e5.csv" u 1:2 w l lw 2 lc rgb "olive"
set title "2 constrained beads, Beta 100, Gamma=1e4"
p "C_2cb_B1000_G1e4.csv" u 1:2 w l lw 2 lc rgb "blue"
unset multiplot

#set output "| epstopdf -f -o=plotFvsR_sC_2and10cb_B100.pdf"
#set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Gamma=1e4, Beta=1000)" font ",16" margins 0.12, 1, 0.19, 0.9 spacing 0.1
#set title "2 constrained beads"
#p "C_2cb_B1000_G1e4.csv" u 1:2 w l lw 2 lc rgb "red"
#set title "10 constrained beads"
#p "C_10cb_B1000_G1e4.csv" u 1:2 w l lw 2 lc rgb "green"
#unset multiplot


set output
#   EOF
