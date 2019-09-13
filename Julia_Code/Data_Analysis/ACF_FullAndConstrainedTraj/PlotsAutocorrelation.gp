set terminal postscript eps color enhanced "Times-Roman" 12
set size 1.1,1.1
set grid

# /Data_Analysis/ACF_FullAndConstrainedTraj    to add to the path if you want to run the script from the Julia_Code folder
set output "| epstopdf -f -o=./Plots/AutocorrFullandOrtho_1.0.pdf"

# f(x) = exp(-x/t)*(A*cos(w*x)+B*sin(w*x))

set multiplot layout 1,2 title "Time autocorrelation function (ACF) of forces and momenta\n \n\
[System C, NBeads=10, Gamma=1, Beta=1, dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, NumLags=10^4, MacroSamples=100]" font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1
set xlabel "{{/RomanOblique t}}"
set logscale x
set format x "10^{%L}"

set ylabel "{{/RomanOblique ACF of the FORCES}}"
# t = 0.1
# A = 0.1
# B = 0.01
# w = 0.1
# fit f(x) "./Outcomes/OrthocorrF.csv" via t,A,B,w
p "./Outcomes/FullcorrF_1.csv" u 1:2 w l lw 1 t "Orhogonal Component - Full Dynamics",\
  "./Outcomes/OrthocorrF_1.csv" u 1:2 w d lw 4 t "Orthogonal Dynamics"
  # , f(x) t "FIT Orthogonal Dynamics"

set ylabel "{{/RomanOblique ACF of the MOMENTA}}"
# t = 0.1
# A = 1
# B = 0.1
# w = -0.1
# fit f(x) "./Outcomes/FullcorrP.csv" via t,A,B,w
p "./Outcomes/FullcorrP_1.csv" u 1:2 w l lw 2 t "Full Dynamics",\
  "./Outcomes/OrthocorrP_1.csv" u 1:2 w d lw 4 t "Orthogonal Dynamics"
# , f(x) t "FIT"

unset multiplot

set output
#  EOF
