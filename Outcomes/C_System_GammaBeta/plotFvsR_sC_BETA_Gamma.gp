set terminal postscript eps color enhanced "Times-Roman" 9
set size 1.1,1.1
set ylabel "{{/RomanOblique Fmean (R)}}"
set xlabel "{{/RomanOblique R}}"
#set xrange [0:2]
#set yrange [-1e8:1e8]
unset key
set grid

######################################################################
# file "FvsR_sC_BETA_G*.csv"     file "FvsR_sC_GAMMA_B1000.csv"
# num.col.       valori          num.col.       valori
#   1     ->   R(Beta1=1)          1     ->   R(Gamma1=10)
#   2     ->   R(Beta2=10)         2     ->   R(Gamma2=100)
#   3     ->   R(Beta3=100)        3     ->   R(Gamma3=1000)
#   4     ->   Fmean(Beta1)        4     ->   R(Gamma4=1e4)
#   5     ->   Fmean(Beta2)        5     ->   R(Gamma5=1e5)
#   6     ->   Fmean(Beta3)        6     ->   Fmean(Gamma1)
#                                  7     ->   Fmean(Gamma2)
#                                  8     ->   Fmean(Gamma3)
#                                  9     ->   Fmean(Gamma4)
#                                 10     ->   Fmean(Gamma5)


######################################################################

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e0.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Constrained beds 2, Gamma=1)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "Beta = 1"
p "FvsR_sC_BETA_G1e0.csv" u 1:4 w l lw 2 lc rgb "red"
set title "Beta = 10"
p "FvsR_sC_BETA_G1e0.csv" u 2:5 w l lw 2 lc rgb "green"
set title "Beta = 100"
p "FvsR_sC_BETA_G1e0.csv" u 3:6 w l lw 2 lc rgb "blue"
unset multiplot

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e1.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Constrained beds 2, Gamma=10)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "Beta = 1"
p "FvsR_sC_BETA_G1e1.csv" u 1:4 w l lw 2 lc rgb "red"
set title "Beta = 10"
p "FvsR_sC_BETA_G1e1.csv" u 2:5 w l lw 2 lc rgb "green"
set title "Beta = 100"
p "FvsR_sC_BETA_G1e1.csv" u 3:6 w l lw 2 lc rgb "blue"
set title "Beta = 1000"
p "FvsR_sC_GAMMA_B1000.csv" u 1:6 w l lw 2 lc rgb "olive"
unset multiplot

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e2.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Constrained beds 2, Gamma=100)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "Beta = 1"
p "FvsR_sC_BETA_G1e2.csv" u 1:4 w l lw 2 lc rgb "red"
set title "Beta = 10"
p "FvsR_sC_BETA_G1e2.csv" u 2:5 w l lw 2 lc rgb "green"
set title "Beta = 100"
p "FvsR_sC_BETA_G1e2.csv" u 3:6 w l lw 2 lc rgb "blue"
set title "Beta = 1000"
p "FvsR_sC_GAMMA_B1000.csv" u 2:7 w l lw 2 lc rgb "olive"
unset multiplot

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e3.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Constrained beds 2, Gamma=1000)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "Beta = 1"
p "FvsR_sC_BETA_G1e3.csv" u 1:4 w l lw 2 lc rgb "red"
set title "Beta = 10"
p "FvsR_sC_BETA_G1e3.csv" u 2:5 w l lw 2 lc rgb "green"
set title "Beta = 100"
p "FvsR_sC_BETA_G1e3.csv" u 3:6 w l lw 2 lc rgb "blue"
set title "Beta = 1000"
p "FvsR_sC_GAMMA_B1000.csv" u 3:8 w l lw 2 lc rgb "olive"
unset multiplot

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e4.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Constrained beds 2, Gamma=1e4)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "Beta = 1"
p "FvsR_sC_BETA_G1e4.csv" u 1:4 w l lw 2 lc rgb "red"
set title "Beta = 10"
p "FvsR_sC_BETA_G1e4.csv" u 2:5 w l lw 2 lc rgb "green"
set title "Beta = 100"
p "FvsR_sC_BETA_G1e4.csv" u 3:6 w l lw 2 lc rgb "blue"
set title "Beta = 1000"
p "FvsR_sC_GAMMA_B1000.csv" u 4:9 w l lw 2 lc rgb "olive"
unset multiplot

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e5.pdf"
set multiplot layout 2,2 title "Fmean vs R\n \n(System C, Constrained beds 2, Gamma=1e5)" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set title "Beta = 1"
p "FvsR_sC_BETA_G1e5.csv" u 1:4 w l lw 2 lc rgb "red"
set title "Beta = 10"
p "FvsR_sC_BETA_G1e5.csv" u 2:5 w l lw 2 lc rgb "green"
set title "Beta = 100"
p "FvsR_sC_BETA_G1e5.csv" u 3:6 w l lw 2 lc rgb "blue"
set title "Beta = 1000"
p "FvsR_sC_GAMMA_B1000.csv" u 5:10 w l lw 2 lc rgb "olive"
unset multiplot


set output
#   EOF
