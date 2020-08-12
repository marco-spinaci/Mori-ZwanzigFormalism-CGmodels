#!/opt/local/bin/gnuplot -persist
#
set terminal postscript eps color enhanced "Times-Roman" 14
set title ""
set size .5,.5
set lmargin 8 
set bmargin 3
set output "| epstopdf -f -o=Veff.pdf"
#set term pdfcairo
#set output 'CTRW-model.pdf'
#set format y "10^{%L}"
#set format x "10^{%L}"
#set logscale xy
#unset mxtics
#unset mytics
set ylabel "{{/RomanOblique V^{eff}(R)}}"
set xlabel "{{/RomanOblique R}}"
#set yrange [1e-10:1]
#set key bottom left
unset key
set grid
p "test3.csv" u 1:3 w l lw 3 lc 0

set output "| epstopdf -f -o=Veff_compare.pdf"
p "test3.csv" u 1:3 w l lw 3 lc 0, "test3b.csv" u 1:3 w l lw 3 lc 6 dashtype 3, "test3c.csv" u 1:3 w l lw 3 lc 7 dashtype 4, "test3d.csv" u 1:3 w l lw 3 lc 10 dashtype 6

set ylabel "Mean Force"
set output "| epstopdf -f -o=F_compare.pdf"
p "test3.csv" u 1:4 w l lw 3 lc 0, "test3b.csv" u 1:4 w l lw 3 lc 6 dashtype 3, "test3c.csv" u 1:4 w l lw 3 lc 7 dashtype 4, "test3d.csv" u 1:4 w l lw 3 lc 10 dashtype 6

set ylabel "Fluctuating Force"
set output "| epstopdf -f -o=Ff_compare.pdf"
p "test3.csv" u 1:5 w l lw 3 lc 0, "test3b.csv" u 1:5 w l lw 3 lc 6 dashtype 3, "test3c.csv" u 1:5 w l lw 3 lc 7 dashtype 4, "test3d.csv" u 1:5 w l lw 3 lc 10 dashtype 6



set output "| epstopdf -f -o=Veff_compare_constr.pdf"
p "test3.csv" u 1:3 w l lw 3 lc 0, "test3constr.csv" u 1:3 w l lw 3 lc 6 dashtype 3

set ylabel "Mean Force"
set output "| epstopdf -f -o=F_compare_constr.pdf"
p "test3.csv" u 1:4 w l lw 3 lc 0, "test3constr.csv" u 1:4 w l lw 3 lc 6 dashtype 3

set ylabel "Fluctuating Force"
set output "| epstopdf -f -o=Ff_compare_constr.pdf"
p "test3.csv" u 1:5 w l lw 3 lc 0, "test3constr.csv" u 1:5 w l lw 3 lc 6 dashtype 3





set output "| epstopdf -f -o=F.pdf"
#set format y "10^{%L}"
#set format x "10^{%L}"
#set logscale xy
#unset mxtics
#unset mytics
set ylabel "Forces"
set xlabel "{{/RomanOblique R}}"
#set yrange [1e-10:1]
#set key bottom left
unset key
set grid
p "test3.csv" u 1:4 w l lw 4 lc 0, "test3.csv" u 1:5 w l lw 4 lc 6 dashtype 3 


set output "| epstopdf -f -o=Flog.pdf"
set format y "10^{%L}"
#set format x "10^{%L}"
set logscale y
#unset mxtics
unset mytics
set ylabel "Forces magnitude"
set xlabel "{{/RomanOblique R}}"
#set yrange [1e-10:1]
#set key bottom left
unset key
set grid
p "test3.csv" u 1:(abs($4)) w l lw 4 lc 0, "test3.csv" u 1:5 w l lw 4 lc 6 dashtype 3 



set output
#    EOF
