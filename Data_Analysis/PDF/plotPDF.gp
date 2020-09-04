set terminal postscript eps color enhanced "Times-Roman" 30 #size 7,15
set size 1.1,1
set grid

set key font ",14"
set logscale y
set format y "10^{%L}"


# set xlabel "{{/RomanOblique P}}"
# set xrange [-10:10]
# set ylabel "{{/Roman pdf (P)}}"
# set yrange[1e-2:1e-1]

# set xrange [-25:25]
# set xtics 5
# unset yrange
# set yrange[1e-7:1e0]

f(x) = a * exp(-b * (x**2))
a = sqrt(1.096 / (2*pi*21))
b = 1.096 / (2*21)

# f(x) = a * exp(-b * (x**2))
# a = sqrt(1. / (2*pi*3))
# b = 1. / (2*3)

# g(x) = c * exp(-d * (x**2))
# c = sqrt(1.00001 / (2*pi*21))
# d = 1.00001 / (2*21)

# # set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_P_1e7B1.096_CORRETTA.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/HistPDF_P_CORRETTAmd.pdf"
# set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_P_1e7_TestBeta.pdf"
# # fit f(x) "./Data_Analysis/PDF/Outcomes/HistP_FGD.csv" via a,b
# p "./Data_Analysis/PDF/Outcomes/HistP_FGD_1e7(B1.096)_CORRETTA.csv" u 1:2 w p lw 5 ps 2 lc 7 pt 5 t "FGD TESI - Beta=1.096" , \
#   f(x) w l lc 4 lw 5 t "Theoretical pdf - Beta=1.096", \
#   "./Data_Analysis/PDF/Outcomes/HistP_FGD_1e7.csv" u 1:2 w p lw 5 ps 2 lc 6 pt 4 t "FGD TEST - Beta=1", \
#   g(x) w l lc 2 lw 5 t "Theoretical pdf - Beta=1"
#
#   # "./Data_Analysis/PDF/Outcomes/HistP_DCGD_1e7(B1.096)_CORRETTA.csv" u 1:2 w p lw 5 ps 2 lc 8 pt 13 t "CGD" , \
#   # "./Data_Analysis/PDF/Outcomes/HistP_MMZD_1e7(B1.096).csv" u 1:2 w p lw 5 ps 2 lc 7 pt 4 t "MMZD"
# set output

# unset xrange
# set xtics 0.2
# unset yrange

set xlabel "{{/RomanOblique R}}"
set ylabel "{{/Roman pdf (R)}}"

# set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_Q_1e7B1.096_CORRETTA.pdf"
# set output "| epstopdf -f -o=../TEX_Notes/Figure/HistPDF_Q_CORRETTAmd.pdf"
set output "| epstopdf -f -o=Outcomes/M10.0_m1.0/PDF/HistQ_M10.0m1.0_1.0e+08_B1.096_dt1.0e-04.pdf"
p "Outcomes/M10.0_m1.0/PDF/HistQ_FGD_M10.0m1.0_1.0e+08_B1.096_dt1.0e-04.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
  "Outcomes/M10.0_m1.0/PDF/HistQ_DCGD_M10.0m1.0_1.0e+08_B1.096_dt1.0e-04.csv" u 1:2 w p lw 5 ps 2 lc 8 pt 13 t "CGD" , \
  "Outcomes/M10.0_m1.0/PDF/HistQ_MMZD_M10.0m1.0_1.0e+08_B1.096_dt1.0e-04.csv" u 1:2 w p lw 5 ps 2 lc 7 pt 4 t "MMZD"
set output


set xlabel "{{/RomanOblique P}}"
set ylabel "{{/Roman pdf (P)}}"

# set xrange [-25:25]
# set xtics 5
# set yrange[1e-8:1e0]

# set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_P.pdf"
# set output "| epstopdf -f -o=../TEX_Notes/Figure/HistPDF_P.pdf"
set output "| epstopdf -f -o=Outcomes/M10.0_m1.0/PDF/HistP_M10.0m1.0_1.0e+08_B1.096_dt1.0e-04.pdf"
p "Outcomes/M10.0_m1.0/PDF/HistP_FGD_M10.0m1.0_1.0e+08_B1.096_dt1.0e-04.csv" u 1:2 w p lw 5 ps 2 lc 2 pt 5 t "FGD" , \
  "Outcomes/M10.0_m1.0/PDF/HistP_DCGD_M10.0m1.0_1.0e+08_B1.096_dt1.0e-04.csv" u 1:2 w p lw 5 ps 2 lc 8 pt 13 t "CGD" , \
  "Outcomes/M10.0_m1.0/PDF/HistP_MMZD_M10.0m1.0_1.0e+08_B1.096_dt1.0e-04.csv" u 1:2 w p lw 5 ps 2 lc 7 pt 4 t "MMZD" , \
  f(x) w l lc 4 lw 2 t "Theoretical pdf"
set output

# unset xrange
# set xtics 0.2
# unset yrange
#
# set xlabel "{{/RomanOblique R}}"
# set ylabel "{{/Roman pdf (R)}}"
#
# # set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_Q.pdf"
# set output "| epstopdf -f -o=../TEX_Notes/Figure/HistPDF_Q.pdf"
# p "./Data_Analysis/PDF/Outcomes/HistQ_FGD_1e8_1e-4.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/PDF/Outcomes/HistQ_DCGD.csv" u 1:2 w p lw 5 ps 2 lc 8 pt 13 t "CGD" , \
#   "./Data_Analysis/PDF/Outcomes/HistQ_MMZD_1e7(B1.096).csv" u 1:2 w p lw 5 ps 2 lc 7 pt 4 t "MMZD"
# set output


#  EOF
