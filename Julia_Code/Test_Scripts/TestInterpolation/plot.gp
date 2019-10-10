set terminal postscript eps color enhanced "Times-Roman" 12
set size 1.1,1.1
set grid
set logscale y

#####################

# set output "| epstopdf -f -o=./TestInterpolation/Plots/InterpolationMeanForce.pdf"
set output "| epstopdf -f -o=./TestInterpolation/Plots/InterpolationMeanForce_algInt.pdf"

set title "Interpolation Mean Force \n\n\
[System C, NBeads=10, Gamma=1, Beta=1, dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, NumLags=10^4, MacroSamples=2000]" font ",14"

set xlabel "{{/RomanOblique R}}"
set ylabel "{{/RomanOblique MEAN FORCE}}"

# p "./TestInterpolation/Outcomes/RRFmean_1e4.csv" u 3:4 w l lw 3 lc rgb "red" t "Interpolation",\
#   "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:4 w l lw 3 dashtype 3 lc rgb "blue" t "Dataset"

p "./TestInterpolation/Outcomes/RFmean_algInt.csv" u 1:2 w l lw 3 lc rgb "red" t "Interpolation",\
  "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:4 w l lw 3 dashtype 1 lc rgb "blue" t "Dataset"

######################

# set output "| epstopdf -f -o=./TestInterpolation/Plots/InterpolationFluctuatingForce.pdf"
set output "| epstopdf -f -o=./TestInterpolation/Plots/InterpolationFluctuatingForce_algInt.pdf"

set title "Interpolation Fluctuating Force \n\n\
[System C, NBeads=10, Gamma=1, Beta=1, dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, NumLags=10^4, MacroSamples=2000]" font ",14"

set xlabel "{{/RomanOblique R}}"
set ylabel "{{/RomanOblique FLUCTUATING FORCE}}"

p "./TestInterpolation/Outcomes/RFF_algInt.csv" u 1:2 w l lw 3 lc rgb "black" t "Interpolation",\
  "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:5 w l lw 3 dashtype 3 lc rgb "red" t "Dataset"


set output
#  EOF
