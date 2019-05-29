#!/opt/local/bin/gnuplot -persist
#
set terminal postscript eps color enhanced "Times-Roman" 14
set title ""
set size .5,.5
set lmargin 10
set bmargin 3
#set output "| epstopdf -f -o=Veff.pdf"
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
#unset key
set grid


unset key
unset logscale y
set ylabel "{{/RomanOblique pdf(R)}}"
set xlabel "{{/RomanOblique R}}"
set output "| epstopdf -f -o=x_compare.pdf"
p "17-12-05c/x.csv" u 1:2 w l lw 3 lc 0 t "Full", "17-12-05c/x.csv" u 1:3 w l lw 3 lc 6 dashtype 3 t "Approximate", "17-12-05c/x.csv" u 1:4  w l lw 3 lc 7 dashtype 4 t "Deterministic"
set logscale y
set format y "10^{%L}"
set output "| epstopdf -f -o=x_compare_log.pdf"
rep

unset key
unset logscale y
unset format y
set ylabel "{{/RomanOblique pdf(P)}}"
set xlabel "{{/RomanOblique P}}"
set output "| epstopdf -f -o=m_compare.pdf"
p "17-12-05c/m.csv" u 1:2 w l lw 3 lc 0 t "Full", "17-12-05c/m.csv" u 1:3 w l lw 3 lc 6 dashtype 3 t "Approximate", "17-12-05c/m.csv" u 1:4  w l lw 3 lc 7 dashtype 4 t "Deterministic"
set logscale y
set format y "10^{%L}"
set output "| epstopdf -f -o=m_compare_log.pdf"
rep


set output
#    EOF
