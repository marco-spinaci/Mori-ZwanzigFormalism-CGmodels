set terminal postscript eps color enhanced "Times-Roman" 9
set size 1.1,1.1
set ylabel "{{/RomanOblique Fmean (R)}}"
set xlabel "{{/RomanOblique R}}"
#set xrange [0:2]
#set yrange [-1e8:1e8]
unset key
set grid

#############################################################
# file "FvsR_sC_GAMMA_B1000.csv"

# num.col.       valori
#   1     ->   R(Beta1=1)
#   2     ->   R(Beta2=10)
#   3     ->   R(Beta3=100)
#   4     ->   R(Beta4=1000)
#   5     ->   Fmean(Beta1)
#   6     ->   Fmean(Beta2)
#   7     ->   Fmean(Beta3)
#   8     ->   Fmean(Beta4)

############################################################

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e-1.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Constrained beds 2, Gamma=0.1)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "Beta = 1"
p "FvsR_sC_BETA_G1e-1.csv" u 1:5 w l lw 2 lc rgb "red"
set title "Beta = 10"
p "FvsR_sC_BETA_G1e-1.csv" u 2:6 w l lw 2 lc rgb "green"
set title "Beta = 100"
p "FvsR_sC_BETA_G1e-1.csv" u 3:7 w l lw 2 lc rgb "blue"
set title "Beta = 1000"
p "FvsR_sC_BETA_G1e-1.csv" u 4:8 w l lw 2 lc rgb "olive"
unset multiplot

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e-2.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Constrained beds 2, Gamma=0.01)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "Beta = 1"
p "FvsR_sC_BETA_G1e-2.csv" u 1:5 w l lw 2 lc rgb "red"
set title "Beta = 10"
p "FvsR_sC_BETA_G1e-2.csv" u 2:6 w l lw 2 lc rgb "green"
set title "Beta = 100"
p "FvsR_sC_BETA_G1e-2.csv" u 3:7 w l lw 2 lc rgb "blue"
set title "Beta = 1000"
p "FvsR_sC_BETA_G1e-2.csv" u 4:8 w l lw 2 lc rgb "olive"
unset multiplot

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e-3.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Constrained beds 2, Gamma=0.001)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "Beta = 1"
p "FvsR_sC_BETA_G1e-3.csv" u 1:5 w l lw 2 lc rgb "red"
set title "Beta = 10"
p "FvsR_sC_BETA_G1e-3.csv" u 2:6 w l lw 2 lc rgb "green"
set title "Beta = 100"
p "FvsR_sC_BETA_G1e-3.csv" u 3:7 w l lw 2 lc rgb "blue"
set title "Beta = 1000"
p "FvsR_sC_BETA_G1e-3.csv" u 4:8 w l lw 2 lc rgb "olive"
unset multiplot

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e-4.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Constrained beds 2, Gamma=0.0001)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "Beta = 1"
p "FvsR_sC_BETA_G1e-4.csv" u 1:5 w l lw 2 lc rgb "red"
set title "Beta = 10"
p "FvsR_sC_BETA_G1e-4.csv" u 2:6 w l lw 2 lc rgb "green"
set title "Beta = 100"
p "FvsR_sC_BETA_G1e-4.csv" u 3:7 w l lw 2 lc rgb "blue"
set title "Beta = 1000"
p "FvsR_sC_BETA_G1e-4.csv" u 4:8 w l lw 2 lc rgb "olive"
unset multiplot

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e-5.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Constrained beds 2, Gamma=0.00001)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "Beta = 1"
p "FvsR_sC_BETA_G1e-5.csv" u 1:5 w l lw 2 lc rgb "red"
set title "Beta = 10"
p "FvsR_sC_BETA_G1e-5.csv" u 2:6 w l lw 2 lc rgb "green"
set title "Beta = 100"
p "FvsR_sC_BETA_G1e-5.csv" u 3:7 w l lw 2 lc rgb "blue"
set title "Beta = 1000"
p "FvsR_sC_BETA_G1e-5.csv" u 4:8 w l lw 2 lc rgb "olive"
unset multiplot


set output
#   EOF
