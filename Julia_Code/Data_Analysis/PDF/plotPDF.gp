set terminal postscript eps color enhanced "Times-Roman" 30 #size 7,15
set size 1.1,1
set grid

set key font ",18"
set logscale y
set format y "10^{%L}"


set xlabel "{{/RomanOblique P}}"
# set xrange [-10:10]
# set xtics 5
set ylabel "{{/RomanOblique pdf (P)}}"
# set yrange[1e-2:1e-1]


f(x) = a*exp(-b*x**2)
a = sqrt(1 / (2*pi*21))
b = 0.0238095
set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_P_test.pdf"
# fit f(x) "./Data_Analysis/PDF/Outcomes/HistP_FGD.csv" via a,b
p f(x) lw 5 t "f(x)", \
  "./Data_Analysis/PDF/Outcomes/HistP_FGD.csv" u 1:2 w p lw 5 lc 2 dt 1 t "FGD" , \
  "./Data_Analysis/PDF/Outcomes/HistP_FGD_1e7_test.csv" u 1:2 w p lw 5 lc 3 dt 1 t "FGD(test)" #, \
  "./Data_Analysis/PDF/Outcomes/HistP_MMZD.csv" u 1:2 w p lw 5 lc 7 dt 4 t "MMZD" , \
  "./Data_Analysis/PDF/Outcomes/HistP_MMZD_1e8_1e-4.csv" u 1:2 w p lw 1 lc 8 dt 4 t "MMZD(10^8) 10^{-4}"
set output


# # set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_P.pdf"
# set output "| epstopdf -f -o=../TEX_Notes/Figure/HistPDF_P.pdf"
# p "./Data_Analysis/PDF/Outcomes/HistP_FGD.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/PDF/Outcomes/HistP_FGD_1e8_1e-4.csv" u 1:2 w p lw 5 lc 3 dt 1 t "FGD(10^8) 10^{-4}" , \
#   "./Data_Analysis/PDF/Outcomes/HistP_DCGD.csv" u 1:2 w l lw 5 lc 6 dt 2 t "DCGD" , \
#   "./Data_Analysis/PDF/Outcomes/HistP_MMZD.csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD" , \
#   "./Data_Analysis/PDF/Outcomes/HistP_MMZD_1e8_1e-4.csv" u 1:2 w l lw 5 lc 8 dt 4 t "MMZD(10^8) 10^{-4}"
# set output
#
# set xlabel "{{/RomanOblique R}}"
# # set xrange [2.6:3.9]
# # set xtics 0.3
# set ylabel "{{/RomanOblique pdf (R)}}"
#
# # set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_Q.pdf"
# set output "| epstopdf -f -o=../TEX_Notes/Figure/HistPDF_Q.pdf"
# p "./Data_Analysis/PDF/Outcomes/HistQ_FGD.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/PDF/Outcomes/HistQ_FGD_1e8_1e-4.csv" u 1:2 w p lw 5 lc 3 dt 1 t "FGD(10^8) 10^{-4}" , \
#   "./Data_Analysis/PDF/Outcomes/HistQ_DCGD.csv" u 1:2 w l lw 5 lc 6 dt 2 t "DCGD" , \
#   "./Data_Analysis/PDF/Outcomes/HistQ_MMZD.csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD" , \
#   "./Data_Analysis/PDF/Outcomes/HistQ_MMZD_1e8_1e-4.csv" u 1:2 w l lw 5 lc 8 dt 4 t "MMZD(10^8) 10^{-4}"
# set output


#  EOF
