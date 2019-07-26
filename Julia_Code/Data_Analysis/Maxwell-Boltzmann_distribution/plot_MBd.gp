set terminal postscript eps color enhanced "Times-Roman" 12
set size 1.1,1.1
# set xrange [0:2]
# set yrange [-2:0.5]
# unset key
set grid


set output "| epstopdf -f -o=Data_Analysis/Maxwell-Boltzmann_distribution/HistMBd_B1.pdf"
set multiplot layout 2,2 title "Maxwell-Boltzmann distribution for the momenta of a single bead\n \n\
[System C (full simulation of Langevin dynamics), Gamma=1, Beta=1, Total Step = 10^5]" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set xlabel "{{/RomanOblique p}}"
set ylabel "{{/RomanOblique f (p)}}"

p "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-4_B1.csv" u 1:2 w l lw 2 t "dt = 10^{-4}"

p "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-3_B1.csv" u 1:2 w l lw 2 t "dt = 10^{-3}"

# set key top left
p "Data_Analysis/Maxwell-Boltzmann_distribution/HistMaxBolt_dt1e-2_B1.csv" u 1:2 w l lw 2 t "dt = 10^{-2}"

unset multiplot

set output
#  EOF
