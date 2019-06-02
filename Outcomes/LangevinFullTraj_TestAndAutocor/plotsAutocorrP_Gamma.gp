#!/opt/local/bin/gnuplot -persist
#
set terminal postscript eps color enhanced "Times-Roman" 11
set title "Autocorrelation of the momentum"
set size .9,.9
set lmargin 9
set bmargin 4
#set output "| epstopdf -f -o=Veff.pdf"
#set term pdfcairo
#set output 'CTRW-model.pdf'
#set format y "10^{%L}"
#set format x "10^{%L}"
#set logscale xy
#unset mxtics
#unset mytics
set ylabel "{{/RomanOblique VACF(t)}}"
set xlabel "{{/RomanOblique t}}"
#set xrange [0:2]
#set key bottom left
#unset key
set grid

#########################################
# file "AutocorGAMMAfrom1e-5to1e5.csv"
# num.col.   val.Gamma
#   1     ->      t
#   2     ->   1e-5
#   3     ->   1e-4
#   4     ->  0.001
#   5     ->   0.01
#   6     ->    0.1
#   7     ->      1
#   8     ->     10
#   9     ->    100
#  10     ->   1000
#  11     ->    1e4
#  12     ->    1e5
##########################################

set output "| epstopdf -f -o=plotAutocorP_2.pdf"
p "AutocorGAMMAfrom1e-5to1e5.csv" u 1:4 w l lw 2 lc rgb "blue"   t  "Gamma = 0.001",\
  "AutocorGAMMAfrom1e-5to1e5.csv" u 1:5 w l lw 2 lc rgb "red"    t  "Gamma = 0.01",\
  "AutocorGAMMAfrom1e-5to1e5.csv" u 1:6 w l lw 2 lc rgb "olive"  t  "Gamma = 0.1",\
  "AutocorGAMMAfrom1e-5to1e5.csv" u 1:7 w l lw 2 lc rgb "green"  t "Gamma = 1"\

set xrange [0:0.2]
set output "| epstopdf -f -o=plotAutocorP_3.pdf"
p "AutocorGAMMAfrom1e-5to1e5.csv" u 1:9  w l lw 2 lc rgb "blue"   t  "Gamma = 1e2",\
  "AutocorGAMMAfrom1e-5to1e5.csv" u 1:10 w l lw 2 lc rgb "red"    t  "Gamma = 1e3",\
  "AutocorGAMMAfrom1e-5to1e5.csv" u 1:11 w l lw 2 lc rgb "olive"  t  "Gamma = 1e4",\
  "AutocorGAMMAfrom1e-5to1e5.csv" u 1:12 w l lw 2 lc rgb "green"  t  "Gamma = 1e5"\




set output
#    EOF
