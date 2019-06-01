#!/opt/local/bin/gnuplot -persist
#
set terminal postscript eps color enhanced "Times-Roman" 11
set title "Fmean vs R"
set size .9,.9
set lmargin 12
set bmargin 5
#set output "| epstopdf -f -o=Veff.pdf"
#set term pdfcairo
#set output 'CTRW-model.pdf'
#set format y "10^{%L}"
#set format x "10^{%L}"
#set logscale xy
#unset mxtics
#unset mytics
set ylabel "{{/RomanOblique Fmean (R)}}"
set xlabel "{{/RomanOblique R}}"
#set xrange [0:2]
set yrange [-5:5]
#set key bottom left
#unset key
set grid

#########################################
# file "FvsR_sC_Gamma.csv"
# num.col.     valori
#   1     ->   R(Gamma1=1e2)
#   2     ->   R(Gamma2=1e3)
#   3     ->   R(Gamma3=1e4)
#   4     ->   R(Gamma4=1e5)
#   5     ->   Fmean(Gamma1)
#   6     ->   Fmean(Gamma2)
#   7     ->   Fmean(Gamma3)
#   8     ->   Fmean(Gamma4)
##########################################

#set output "| epstopdf -f -o=plotFvsR_sC_GAMMA.pdf"
#p "FvsR_sC_Gamma.csv" u 1:5 w l lw 2 lc rgb "blue"   t  "Gamma = 1e2",\
#  "FvsR_sC_Gamma.csv" u 2:6 w l lw 2 lc rgb "red"    t  "Gamma = 1e3",\
#  "FvsR_sC_Gamma.csv" u 3:7 w l lw 2 lc rgb "olive"  t  "Gamma = 1e4",\
#  "FvsR_sC_Gamma.csv" u 4:8 w l lw 2 lc rgb "green"  t  "Gamma = 1e5"

set output "| epstopdf -f -o=plotFvsR_sC_GAMMA.pdf"
p  "FvsR_sC_Gamma.csv" u 4:8 w l lw 2 lc rgb "green"  t  "Gamma = 1e5"


set output
#    EOF
