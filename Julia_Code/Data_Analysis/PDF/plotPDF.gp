set terminal postscript eps color enhanced "Times-Roman" 40 size 7,15
set size 1.1,1
set grid

set key font ",30"
set logscale y
set format y "10^{%L}"

set output "| epstopdf -f -o=Data_Analysis/PDF/Plots/HistPDF_test.pdf"


set multiplot layout 2,1 margins 0.2, 1, 0.09, 0.88 spacing 0.15 #title "TEST" font ",28"

set xlabel "{{/RomanOblique p}}"
# set xrange [-30:30]
# set xtics 5
set ylabel "{{/Roman pdf (p)}}"
p "Data_Analysis/PDF/Outcomes/HistPFull_test.csv" u 1:2 w d lw 8 t "full dynamics"

set xlabel "{{/RomanOblique R}}"
# set xrange [-30:30]
# set xtics 5
set ylabel "{{/Roman pdf (R)}}"
p "Data_Analysis/PDF/Outcomes/HistQFull_test.csv" u 1:2 w d lw 8 t "full dynamics"

unset multiplot


set output
#  EOF
