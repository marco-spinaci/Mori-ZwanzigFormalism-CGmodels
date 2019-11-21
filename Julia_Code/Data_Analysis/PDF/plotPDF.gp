set terminal postscript eps color enhanced "Times-Roman" 30 #size 7,15
set size 1.1,1
set grid

set key font ",18"
set logscale y
set format y "10^{%L}"


# set multiplot layout 2,1 margins 0.2, 1, 0.09, 0.88 spacing 0.15 #title "TEST" font ",28"

set xlabel "{{/RomanOblique P}}"
set xrange [-25:25]
set xtics 5
set ylabel "{{/RomanOblique pdf (P)}}"

# set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_Q.pdf"
set output "| epstopdf -f -o=../TEX_Notes/Figure/HistPDF_P.pdf"
p "./Data_Analysis/PDF/Outcomes/HistP_FGD.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
  "./Data_Analysis/PDF/Outcomes/HistP_DCGD.csv" u 1:2 w l lw 5 lc 6 dt 2 t "DCGD" #, \
  "./Data_Analysis/PDF/Outcomes/HistP_MMZD.csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD"
set output

set xlabel "{{/RomanOblique R}}"
set xrange [2.6:3.8]
set xtics 0.2
set ylabel "{{/RomanOblique pdf (R)}}"

# set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_Q.pdf"
set output "| epstopdf -f -o=../TEX_Notes/Figure/HistPDF_Q.pdf"
p "./Data_Analysis/PDF/Outcomes/HistQ_FGD.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
  "./Data_Analysis/PDF/Outcomes/HistQ_DCGD.csv" u 1:2 w l lw 5 lc 6 dt 2 t "DCGD" #, \
  "./Data_Analysis/PDF/Outcomes/HistQ_MMZD.csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD"
set output

# unset multiplot
#  EOF
