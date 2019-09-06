set terminal postscript eps color enhanced "Times-Roman" 12
set size 1.1,1.1
set grid

set output "| epstopdf -f -o=./Data_Analysis/ACF_FullAndConstrainedTraj/Plots/AutocorrFullandOrtho.pdf"
set multiplot layout 1,2 title "Time autocorrelation function (ACF) of forces and momenta\n \n\
[System C, NBeads=10, Gamma=1, Beta=1, dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^5, NumLags=10^4, MacroSamples=4]" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set xlabel "{{/RomanOblique t}}"
set logscale x
set format x "10^{%L}"

set ylabel "{{/RomanOblique ACF of the FORCES}}"
p "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrF.csv" u 1:2 w l lw 1 t "Full dynamics",\
  './Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/OrthocorrF.csv' u 1:2 w d lw 4 t "Ortho dynamics"

set ylabel "{{/RomanOblique ACF of the MOMENTA}}"
p "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrP.csv" u 1:2 w l lw 2 t "Full dynamics"

unset multiplot

set output
#  EOF
