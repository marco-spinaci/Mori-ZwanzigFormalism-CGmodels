#!/opt/local/bin/gnuplot -persist
#
set terminal postscript eps color enhanced "Times-Roman" 14
set title ""
set size .5,.5
set lmargin 8
set bmargin 3
#set output "| epstopdf -f -o=Veff.pdf"
#set term pdfcairo
#set output 'CTRW-model.pdf'
#set format y "10^{%L}"
#set format x "10^{%L}"
#set logscale xy
#unset mxtics
#unset mytics
#set ylabel "{{/RomanOblique V^{eff}(R)}}"
set ylabel "Autocorrelation"
set xlabel "{{/RomanOblique t}}"
#set yrange [1e-10:1]
#set key bottom left
#unset key
set grid

unset key
unset logscale y
set output "| epstopdf -f -o=autocorr.pdf"
p "autocorr/StressesFull.csv" u 1:2 w l lw 3 lc 0 t "Full", "autocorr/StressesApp.csv" u 1:2 w l lw 3 lc 6 dashtype 3 t "Approximate", "autocorr/StressesOrtho.csv" u 1:2  w l lw 3 lc 7 dashtype 4 t "Constrained", "autocorr/StressesFluct.csv" u 1:2  w l lw 3 lc 10 dashtype 6 t "Fluctuations"
set logscale x
set xrange [1e-2:10]
set format x "10^{%L}"
set output "| epstopdf -f -o=autocorr-log.pdf"
rep
set logscale y
set format y "10^{%L}"
set output "| epstopdf -f -o=autocorr-loglog.pdf"
rep

unset key
unset xrange
unset logscale y
unset logscale x
unset format y
unset format x
set output "| epstopdf -f -o=autocorr2.pdf"
p "autocorr/MomentaFull.csv" u 1:2 w l lw 3 lc 0 t "Full", "autocorr/MomentaApp.csv" u 1:2 w l lw 3 lc 6 dashtype 3 t "Approximate", "autocorr/StressesFluct.csv" u 1:2  w l lw 3 lc 10 dashtype 6 t "Fluctuations"
set logscale x
set xrange [1e-2:10]
set format x "10^{%L}"
set output "| epstopdf -f -o=autocorr2-log.pdf"
rep
set logscale y
set format y "10^{%L}"
set output "| epstopdf -f -o=autocorr2-loglog.pdf"
rep


set output
#    EOF
