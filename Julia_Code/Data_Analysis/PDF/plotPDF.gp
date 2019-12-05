set terminal postscript eps color enhanced "Times-Roman" 30 #size 7,15
set size 1.1,1
set grid

set key font ",18"
set logscale y
set format y "10^{%L}"


set xlabel "{{/RomanOblique P}}"
set xrange [-10:10]
set ylabel "{{/Roman pdf (P)}}"
set yrange[1e-2:1e-1]


f(x) = a * exp(-b * (x**2))
a = sqrt(1.096 / (2*pi*21))
b = 1.096 / (2*21)
set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_P_test.pdf"
# fit f(x) "./Data_Analysis/PDF/Outcomes/HistP_FGD.csv" via a,b
p f(x) w l lc 4 lw 2 t "Theoretical distribution" , \
  "./Data_Analysis/PDF/Outcomes/HistP_FGD_1e8_1e-4.csv" u 1:2 w p lw 3 ps 2 lc 2 pt 5 t "FGD" , \
  "./Data_Analysis/PDF/Outcomes/HistP_DCGD.csv" u 1:2 w p lw 3 ps 2 lc 8 pt 13 t "DCGD" , \
  "./Data_Analysis/PDF/Outcomes/HistP_MMZD_1e7(B1.096).csv" u 1:2 w p lw 3 ps 2 lc 7 pt 4 t "MMZD"
set output

set xrange [-25:25]
set xtics 5
# unset yrange
set yrange[1e-7:1e0]

# set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_P.pdf"
set output "| epstopdf -f -o=../TEX_Notes/Figure/HistPDF_P.pdf"
p f(x) w l lc 4 lw 5 t "Theoretical pdf" , \
  "./Data_Analysis/PDF/Outcomes/HistP_FGD_1e8_1e-4.csv" u 1:2 w p lw 5 ps 2 lc 2 pt 5 t "FGD" , \
  "./Data_Analysis/PDF/Outcomes/HistP_DCGD.csv" u 1:2 w p lw 5 ps 2 lc 8 pt 13 t "DCGD" , \
  "./Data_Analysis/PDF/Outcomes/HistP_MMZD_1e7(B1.096).csv" u 1:2 w p lw 5 ps 2 lc 7 pt 4 t "MMZD"
set output

unset xrange
set xtics 0.2
unset yrange

set xlabel "{{/RomanOblique R}}"
set ylabel "{{/Roman pdf (R)}}"

# set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_Q.pdf"
set output "| epstopdf -f -o=../TEX_Notes/Figure/HistPDF_Q.pdf"
p "./Data_Analysis/PDF/Outcomes/HistQ_FGD_1e8_1e-4.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
  "./Data_Analysis/PDF/Outcomes/HistQ_DCGD.csv" u 1:2 w p lw 5 ps 2 lc 8 pt 13 t "DCGD" , \
  "./Data_Analysis/PDF/Outcomes/HistQ_MMZD_1e7(B1.096).csv" u 1:2 w p lw 5 ps 2 lc 7 pt 4 t "MMZD"
set output


#  EOF
