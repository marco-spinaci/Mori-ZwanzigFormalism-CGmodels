set terminal postscript eps color enhanced "Times-Roman" 9
set size 1.1,1.1
#set xrange [0:2]
#set yrange [-2:0.5]
unset key
set grid

######################################################################
# file "AutocorGAMMA_1e-5_1e5.csv"     file "Kmean_T.csv"
# num.col.       valori               num.col.       valori
#   1      ->       t                   1     ->        T
#   2      ->   ACF(t)_gamma1e-5        2     ->      Kmean
#  ...     ->      ....
#  12      ->   ACF(t)_gamma1e5
######################################################################


set title "<Kmean> per particle vs T\n \n \
[System C (full simulation of Langevin dynamics), Beta=1, dt = 10^{-3}, total simulation time = 10^4]" font ",14"
set logscale xy
set xlabel "{{/RomanOblique BETA^{-1}}}"
set ylabel "{{/RomanOblique <Kmean>}}"
set output "| epstopdf -f -o=./LangevinFullTraj_TestAndAutocor/plotKmean_T.pdf"
p "./LangevinFullTraj_TestAndAutocor/Kmean_T.csv" u 1:2 w lp lw 2 lc rgb "red"

# unset title
# unset logscale
# set key
#
# set output "| epstopdf -f -o=./LangevinFullTraj_TestAndAutocor/plotAutocorGamma.pdf"
# set multiplot layout 2,2 title "Autocorrelation of the momentum for a single bead\n \n \
# [System C (full simulation of Langevin dynamics), Beta=1, dt = 10^{-4}, total simulation time = 10^3]" \
# font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
# set xlabel "{{/RomanOblique t}}"
# set ylabel "{{/RomanOblique Autocorrelation (t)}}"
# p "./LangevinFullTraj_TestAndAutocor/AutocorGAMMA.csv" u 1:2 w l lw 2 t  "Gamma = 10^{-5}",\
#                   '' u 1:3 w l lw 2 t  "Gamma = 10^{-4}",\
#                   '' u 1:4 w l lw 2 t  "Gamma = 10^{-3}"
#
# set xlabel "{{/RomanOblique t}}"
# set ylabel "{{/RomanOblique Autocorrelation (t)}}"
# p "./LangevinFullTraj_TestAndAutocor/AutocorGAMMA.csv" u 1:5 w l lw 2 t  "Gamma = 10^{-2}",\
#                   '' u 1:6 w l lw 2 t  "Gamma = 10^{-1}",\
#                   '' u 1:7 w l lw 2  t  "Gamma =  1",\
#                   '' u 1:8 w l lw 2  t  "Gamma = 10",\
#                   '' u 1:9 w l lw 2  t  "Gamma = 10^2"
#
# set xlabel "{{/RomanOblique t}}"
# set ylabel "{{/RomanOblique Autocorrelation (t)}}"
# set xrange [0:0.2]
# p "./LangevinFullTraj_TestAndAutocor/AutocorGAMMA.csv" u 1:10 w l lw 2 t  "Gamma = 10^3",\
#                   '' u 1:11 w l lw 2 t  "Gamma = 10^4",\
#                   '' u 1:12 w l lw 2 t  "Gamma = 10^5"
#
# set xrange [0:0.2]
# set xlabel "{{/RomanOblique t}}"
# set ylabel "{{/RomanOblique Autocorrelation (t)}}"
# p "./LangevinFullTraj_TestAndAutocor/AutocorGAMMA.csv" u 1:2 w l lw 2 t  "Gamma = 10^{-5}",\
#                   '' u 1:3 w l lw 2 t  "Gamma = 10^{-4}",\
#                   '' u 1:4 w l lw 2 t  "Gamma = 10^{-3}",\
#                   '' u 1:5 w l lw 2 t  "Gamma = 10^{-2}",\
#                   '' u 1:6 w l lw 2 t  "Gamma = 10^{-1}",\
#                   '' u 1:7 w l lw 2  t  "Gamma =  1",\
#                   '' u 1:8 w l lw 2  t  "Gamma = 10",\
#                   '' u 1:9 w l lw 2  t  "Gamma = 10^2",\
#                   '' u 1:10 w l lw 2 t  "Gamma = 10^3",\
#                   '' u 1:11 w l lw 2 t  "Gamma = 10^4",\
#                   '' u 1:12 w l lw 2 t  "Gamma = 10^5"
#
# unset multiplot
# set output
#  EOF
