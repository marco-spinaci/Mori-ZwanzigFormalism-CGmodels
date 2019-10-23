set terminal postscript eps color enhanced "Times-Roman" 20 size 7,15
set size 1.1,1
set grid

# /Data_Analysis/ACF_FullAndConstrainedTraj    to add to the path if you want to run the script from the Julia_Code folder
set output "| epstopdf -f -o=./Data_Analysis/ACF_FullAndConstrainedTraj/Plots/AutocorrFullandOrtho_11.pdf"

# f(x) = exp(-x/t)*(A*cos(w*x)+B*sin(w*x))

set multiplot layout 2,1 margins 0.12, 1, 0.09, 0.88 spacing 0.1
# title "Time autocorrelation function (ACF) of forces and momenta\n \n\
# [System C, NBeads=10, Gamma=1, Beta=1, dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, NumLags=10^4, MacroSamples=100]" font ",18"
set xlabel "{{/RomanOblique t}}" font ",40"
set logscale x
set format x "10^{%L}"
set tics font ",26"
set key font ",36"

set ylabel "{{/Roman ACF of the FORCES}}" font ",40"
# t = 0.1
# A = 0.1
# B = 0.01
# w = 0.1
# fit f(x) "./Outcomes/OrthocorrF.csv" via t,A,B,w
p "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrF_1.csv" u 1:2 w l lw 4 t "Orhogonal Component - Full Dynamics",\
  "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/OrthocorrF_1.csv" u 1:2 w d lw 8 t "Orthogonal Dynamics"
  # , f(x) t "FIT Orthogonal Dynamics"

set ylabel "{{/Roman ACF of the MOMENTA}}" font ",40"
# t = 0.1
# A = 1
# B = 0.1
# w = -0.1
# fit f(x) "./Outcomes/FullcorrP.csv" via t,A,B,w
p "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrP_1.csv" u 1:2 w l lw 4 t "Full Dynamics",\
  "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/OrthocorrP_1.csv" u 1:2 w d lw 8 t "Orthogonal Dynamics"
# , f(x) t "FIT"

unset multiplot

set output
#  EOF
