set terminal postscript eps color enhanced "Times-Roman" 9
set size 1.1,1.1
set ylabel "{{/RomanOblique Fmean (R)}}"
set xlabel "{{/RomanOblique R}}"
#set xrange [0:2]
#set yrange [-1e8:1e8]
set grid

#########################################
# file "FvsR_sC_BETA_G*.csv"
# num.col.     valori
#   1     ->   R(Beta1=10)
#   2     ->   R(Beta2=100)
#   3     ->   R(Beta3=1000)
#   4     ->   R(Beta4=10000)
#   5     ->   Fmean(Beta1)
#   6     ->   Fmean(Beta2)
#   7     ->   Fmean(Beta3)
#   8     ->   Fmean(Beta4)
##########################################

set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e0.pdf"
set multiplot layout 2,2 title "Fmean vs R (Gamma=1e0)" margins 0.12, 1, 0.19, 0.9 spacing 0.1
p "FvsR_sC_Gamma_b1.csv" u 1:3 w l lw 2 lc rgb "red"   t "Beta = 10"
p "FvsR_sC_Gamma_b10.csv" u 1:3 w l lw 2 lc rgb "green" t "Beta = 100"
p "FvsR_sC_Gamma_b100.csv" u 1:3 w l lw 2 lc rgb "blue" t "Beta = 1000"
p "FvsR_sC_Gamma_b100.csv" u 1:3 w l lw 2 lc rgb "blue" t "Beta = 1000"
unset multiplot


set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e5.pdf"
set multiplot layout 2,2 title "Fmean vs R (Gamma=1e5)" font ",11" margins 0.12, 1, 0.19, 0.9 spacing 0.09
#set logscale y
p "FvsR_sC_Gamma_b1.csv" u 2:4 w l lw 2 lc rgb "red"   t "Beta = 1"
p "FvsR_sC_Gamma_b10.csv" u 2:4 w l lw 2 lc rgb "green" t "Beta = 10"
#unset logscale y
set key top right
p "FvsR_sC_Gamma_b100.csv" u 2:4 w l lw 2 lc rgb "blue" t "Beta = 100"
unset multiplot


set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e4_1.pdf"
set multiplot layout 2,2 title "Fmean vs R (Gamma=1e4)" margins 0.12, 1, 0.19, 0.9 spacing 0.1
#set logscale y
p "FvsR_sC_Gamma_b10_1.csv" u 1:3 w l lw 2 lc rgb "red"   t "Beta = 10"
set key bottom right
p "FvsR_sC_Gamma_b100_1.csv" u 1:3 w l lw 2 lc rgb "green" t "Beta = 100"
#unset logscale y
p "FvsR_sC_Gamma_b1000.csv" u 1:3 w l lw 2 lc rgb "blue" t "Beta = 1000"
p "FvsR_sC_Gamma_b10000.csv" u 1:3 w l lw 2 lc rgb "olive" t "Beta = 10000"
unset multiplot


set output "| epstopdf -f -o=plotFvsR_sC_BETA_g1e5_1.pdf"
set multiplot layout 2,2 title "Fmean vs R (Gamma=1e5)" font ",11" margins 0.12, 1, 0.19, 0.9 spacing 0.09
#set logscale y
p "FvsR_sC_Gamma_b10_1.csv" u 2:4 w l lw 2 lc rgb "red"   t "Beta = 10"
p "FvsR_sC_Gamma_b100_1.csv" u 2:4 w l lw 2 lc rgb "green" t "Beta = 100"
#unset logscale y
set key top right
p "FvsR_sC_Gamma_b1000.csv" u 2:4 w l lw 2 lc rgb "blue" t "Beta = 1000"
p "FvsR_sC_Gamma_b10000.csv" u 2:4 w l lw 2 lc rgb "olive" t "Beta = 10000"
unset multiplot


set output
#   EOF
