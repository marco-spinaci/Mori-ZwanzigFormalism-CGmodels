set terminal postscript eps color enhanced "Times-Roman" 12
set size 1.1,1.1
set grid
# set logscale y
# set xrange [2:4]
# set xrange [3.8:6.16]
# set xrange [0.5:1]
# set xrange [0.6:2.01]

#####################

# set output "| epstopdf -f -o=./Code_Tests/Interpolation/Plots/InterpolationMeanForce.pdf"
set output "| epstopdf -f -o=./Code_Tests/Interpolation/Plots/InterpolationMeanForce_algInt_TEST.pdf"

set title "Interpolation Mean Force \n\n\
[System C, NBeads=10, Gamma=1, Beta=1, dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, NumLags=10^4, MacroSamples=2000]" font ",14"

set xlabel "{{/RomanOblique R}}"
set ylabel "{{/RomanOblique MEAN FORCE}}"

# p "./Code_Tests/Interpolation/Outcomes/RRFmean_1e4.csv" u 3:4 w l lw 3 lc rgb "red" t "Interpolation",\
  # "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:4 w l lw 3 dashtype 3 lc rgb "blue" t "Dataset"

# p "./Code_Tests/Interpolation/Outcomes/RFmean_algInt_1e3.csv" u 1:2 w l lw 3 lc rgb "red" t "Interpolation",\
#   "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:4 w l lw 3 dashtype 3 lc rgb "blue" t "Dataset"

p "./Code_Tests/Interpolation/Outcomes/RFmean_algInt_test.csv" u 1:2 w l lw 3 lc rgb "red" t "Interpolation",\
  "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:4 w l lw 4 dashtype 1 lc rgb "blue" t "Dataset"

######################

# set output "| epstopdf -f -o=./Code_Tests/Interpolation/Plots/InterpolationFluctuatingForce.pdf"
set output "| epstopdf -f -o=./Code_Tests/Interpolation/Plots/InterpolationFluctuatingForce_algInt_TEST.pdf"

set title "Interpolation Fluctuating Force \n\n\
[System C, NBeads=10, Gamma=1, Beta=1, dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, NumLags=10^4, MacroSamples=2000]" font ",14"

set xlabel "{{/RomanOblique R}}"
set ylabel "{{/RomanOblique FLUCTUATING FORCE}}"

# p "./Code_Tests/Interpolation/Outcomes/RRFF_1e4.csv" u 1:2 w l lw 3 lc rgb "black" t "Interpolation",\
  # "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:5 w l lw 3 dashtype 3 lc rgb "red" t "Dataset"

# p "./Code_Tests/Interpolation/Outcomes/RRFF_1e4.csv" u 1:2 w l lw 3 lc rgb "black" t "Interpolation",\
#   "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:5 w l lw 3 dashtype 3 lc rgb "red" t "Dataset"

p "./Code_Tests/Interpolation/Outcomes/RFF_algInt_test.csv" u 1:2 w l lw 5 lc rgb "red" t "Interpolation",\
  "./ABCD_Systems/Outcomes/sC_2000.csv" u 1:5 w l lw 5 dashtype 1 lc rgb "blue" t "Dataset"


set output
#  EOF
