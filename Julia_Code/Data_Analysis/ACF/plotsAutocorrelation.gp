set terminal postscript eps color enhanced "Times-Roman" 30 #size 7,15
set size 1.1,1
set grid

set xlabel "{{/RomanOblique t}}"
set logscale x
set format x "10^{%L}"
# set xrange [0:10]
# set tics font ",60"
set key font ",18"


# f(x) = exp(-x/t)*(A*cos(w*x)+B*sin(w*x))

# set output "| epstopdf -f -o=./Data_Analysis/ACF_FullAndConstrainedTraj/Plots/AutocorrFullandOrtho_test.pdf"
# set multiplot layout 2,1 margins 0.2, 1, 0.09, 0.88 spacing 0.1
# title "Time autocorrelation function (ACF) of forces and momenta \n \n \
# [System C, NBeads=10, Gamma=1, Beta=1, dt=10^{-3}, FullSteps=10^6, OrthoSamples=10^6, NumLags=10^4, MacroSamples=100]" font ",18" \

# t = 0.1
# A = 0.1
# B = 0.01
# w = 0.1
# fit f(x) "./Outcomes/OrthocorrF.csv" via t,A,B,w

# p "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrF.csv" u 1:2 w l lw 4 t "Full Dynamics F", \
  # "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrF_test.csv" u 1:2 w l lw 2 t "Full Dynamics Ftest"

set ylabel "{{/Roman ACF of the FORCES}}"
set output "| epstopdf -f -o=../TEX_Notes/Figure/ACF_F.pdf"
p "./Data_Analysis/ACF/Outcomes/sC_FullcorrF.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD", \
  "./Data_Analysis/ACF/Outcomes/sC_FullcorrF_OC.csv" u 1:2 w l lw 4 lc 9 dt 4 t " ACF of the Flucutating Force - FGD", \
  "./Data_Analysis/ACF/Outcomes/sC_OrthocorrF.csv" u 1:2 w l lw 5 lc 4 dt 2 t "OD", \
  "./Data_Analysis/ACF/Outcomes/sC_ApproximatecorrF.csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD"
set output

  # , f(x) t "FIT Orthogonal Dynamics"
# "./Data_Analysis/ACF/Outcomes/sC_FullcorrF.csv" u 1:2 w l lw 5 lc 4 dt 2 t "ACF of the Force - FGD", \

# t = 0.1
# A = 1
# B = 0.1
# w = -0.1
# fit f(x) "./Outcomes/FullcorrP.csv" via t,A,B,w

# p "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrP.csv" u 1:2 w l lw 4 t "Full Dynamics P", \
#   "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrP_test.csv" u 1:2 w l lw 2 t "Full Dynamics P_test", \
#   "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrP_1.csv" u 1:2 w l lw 2 t "Full Dynamics P_1", \
#   "./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrP_testOC.csv" u 1:2 w l lw 2 t "Full Dynamics P_testOC",

set ylabel "{{/Roman ACF of the MOMENTA}}"
set output "| epstopdf -f -o=../TEX_Notes/Figure/ACF_P.pdf"
p "./Data_Analysis/ACF/Outcomes/sC_FullcorrP.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD", \
  "./Data_Analysis/ACF/Outcomes/sC_OrthocorrP.csv" u 1:2 w l lw 5 lc 4 dt 2 t "OD", \
  "./Data_Analysis/ACF/Outcomes/sC_ApproximatecorrP.csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD"
set output

# , f(x) t "FIT"


set ylabel "{{/Roman ACF}}"
set output "| epstopdf -f -o=../TEX_Notes/Figure/ACF_comparison.pdf"
# set output "| epstopdf -f -o=Data_Analysis/ACF/Plots/ACF_comparison_sB.pdf"
p "./Data_Analysis/ACF/Outcomes/sC_FullcorrF_OC.csv" u 1:2 w l lw 5 lc 9 dt 4 t " ACF of the Flucutating Force - FGD", \
  "./Data_Analysis/ACF/Outcomes/sC_FullcorrP.csv" u 1:2 w l lw 5 lc 2 dt 1 t "ACF of the Momenta - FGD"
set output


# unset multiplot
# set output

# EOF
