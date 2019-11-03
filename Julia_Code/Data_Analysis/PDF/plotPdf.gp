set terminal postscript eps color enhanced "Times-Roman" 22
set size 1.1,1
set grid

set xlabel "{{/RomanOblique p}}"
set xrange [-20:20]
# set xtics 5

set ylabel "{{/Roman pdf (p)}}"
set logscale y
set format y "10^{%L}"


set key font ",12"


set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_test.pdf"

set multiplot title "TEST" font ",28" layout 1,2 margins 0.15, 1, 0.09, 0.88 spacing 0.1

p "Data_Analysis/PDF/Outcomes/HistP_test.csv" u 1:2 w d lw 8 t "full dynamics, #step 10^5", \
  "Code_Tests/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-4_B1.csv" u 1:2 w l lw 2 t "full dynamics, #step 10^7"

unset multiplot

set output
#  EOF
