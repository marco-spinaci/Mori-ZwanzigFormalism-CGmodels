set terminal postscript eps color enhanced "Times-Roman" 12

set size 1.1,1.1
set key box
set key font ",11"
set grid

set xlabel "{{/RomanOblique p}}"
set ylabel "{{/RomanOblique f (p)}}"
set logscale y
set format "%h"

set output "| epstopdf -f -o=Data_Analysis/Maxwell-Boltzmann_distribution/HistMBd_B1.pdf"

f(x) = a*exp(-b*x**2)

a = 0.1    # BETA=1
b = 0.1
# a = 1e-2   # BETA=1e-1
# b = 1e-2
# a = 1      # BETA=1e-2
# b = 1e-3
set multiplot layout 2,2 title "Maxwell-Boltzmann distribution for the momenta of a single bead \n \
[System C (full simulation of Langevin dynamics), Gamma=1, Beta=1, Total Step = 10^7]" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1

set xrange [-25:25]      # BETA=1
set yrange [1e-5:1]
set xtics 5
# set xrange [-80:80]    # BETA=1e-1
# set yrange [1e-6:1]
fit f(x) "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-4_B1.csv" via a,b
p "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-4_B1.csv" u 1:2 w p lw 2 t "dt = 10^{-4}", f(x) t "fit"
# p "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-4_B1e-2.csv" u 1:2 w p lw 2 t "dt = 10^{-4}"

set key top right    # BETA=1
set yrange [1e-6:1]
fit f(x) "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-3_B1.csv" via a,b
p "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-3_B1.csv" u 1:2 w p lw 2 t "dt = 10^{-3}", f(x) t "fit"
# p "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-3_B1e-2.csv" u 1:2 w p lw 2 t "dt = 10^{-3}"

set yrange [1e-7:1]      # BETA=1
# set xtics 2e12           # BETA=1e-1
# a=1e-2
# b=1e-30
# set yrange [1e-6:5]
# set xrange [-2e12:1e13]
# set yrange [1e-6:5]      # BETA=1e-2
# set xrange [-1e14:5e14]
# set xtics 1e14
# a = 1e-2
# b = 1e-30
fit f(x) "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-2_B1.csv" via a,b
p "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-2_B1.csv" u 1:2 w p lw 2 t "dt = 10^{-2}", f(x) t "fit"
# p "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-2_B1e-2.csv" u 1:2 w p lw 2 t "dt = 10^{-2}"

## to plot the P values
# set xlabel "{{/RomanOblique t}}"
# set ylabel "{{/RomanOblique P}}"
# # set logscale x
# set xrange [0:1000]
# p "Store_FullandConstrainedTrajectory/P_compMBdBETA(1e-1).csv" u 3 w l lw 2 t "dt = 10^{-3}"

unset multiplot

set output
#  EOF
