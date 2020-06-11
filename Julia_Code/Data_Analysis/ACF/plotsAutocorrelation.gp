set terminal postscript eps color enhanced "Times-Roman" 14#30 #size 7,15
set size 1.1,1
set grid

set xlabel "{{/RomanOblique t}}"
set logscale x
set format x "10^{%L}"
# set xrange [0:10]
# set tics font ",60"
# set key font ",18"
set key font ",10"


# set ylabel "{{/Roman ACF of the FORCES}}"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/ACF_F_CORRETTA.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/ACF_F.pdf"
# set output "| epstopdf -f -o=./Data_Analysis/ACF/Plots/ACF_F_comp.pdf"
# p "./Data_Analysis/ACF/Outcomes/sC_FullcorrF.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD", \
#   "./Data_Analysis/ACF/Outcomes/sC_FullcorrF_OC.csv" u 1:2 w l lw 4 lc 9 dt 4 t " ACF of the Flucutating Force - FGD", \
#   "./Data_Analysis/ACF/Outcomes/sC_OrthocorrF.csv" u 1:2 w l lw 5 lc 4 dt 2 t "OD", \
#   "./Data_Analysis/ACF/Outcomes/sC_ApproximatecorrF.csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD", \
#   "./Data_Analysis/ACF/Outcomes/sC_ApproximatecorrF(B1.096).csv" u 1:2 w l lw 5 lc 8 dt 4 t "MMZD(B1.096)"
# set output
#
#
# set ylabel "{{/Roman ACF of the MOMENTA}}"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/ACF_P.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/ACF_P_CORRETTA.pdf"
# set output "| epstopdf -f -o=./Data_Analysis/ACF/Plots/ACF_P_comp.pdf"
# p "./Data_Analysis/ACF/Outcomes/sC_FullcorrP.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD", \
#   "./Data_Analysis/ACF/Outcomes/sC_OrthocorrP.csv" u 1:2 w l lw 5 lc 4 dt 2 t "OD", \
#   "./Data_Analysis/ACF/Outcomes/sC_ApproximatecorrP.csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD", \
#   "./Data_Analysis/ACF/Outcomes/sC_ApproximatecorrP(B1.096).csv" u 1:2 w l lw 5 lc 8 dt 4 t "MMZD(B1.096)"
# set output


# set ylabel "{{/Roman ACF}}"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/ACF_comparison.pdf"
# set output "| epstopdf -f -o=./Data_Analysis/ACF/Plots/ACF_comparison_sB.pdf"
# # set title "{{/Roman System B}}"
# p "./Data_Analysis/ACF/Outcomes/sB_FullcorrF.csv" u 1:2 w l lw 5 lc 2 dt 1 t "ACF of Force - FGD - sB", \
#   "./Data_Analysis/ACF/Outcomes/sC_FullcorrF.csv" u 1:2 w l lw 5 lc 5 dt 1 t "ACF of Force - FGD - sC", \
#   "./Data_Analysis/ACF/Outcomes/sB_FullcorrF_OC.csv" u 1:2 w l lw 5 lc 2 dt 4 t " ACF of the Flucutating Force - FGD - sB", \
#   "./Data_Analysis/ACF/Outcomes/sC_FullcorrF_OC.csv" u 1:2 w l lw 5 lc 5 dt 4 t " ACF of the Flucutating Force - FGD - sC", \
#   "./Data_Analysis/ACF/Outcomes/sB_FullcorrP.csv" u 1:2 w l lw 5 lc 2dt 2 t "ACF of the Momenta - FGD - sB", \
#   "./Data_Analysis/ACF/Outcomes/sC_FullcorrP.csv" u 1:2 w l lw 5 lc 5 dt 2 t "ACF of the Momenta - FGD - sC"
# set output

set ylabel "{{/Roman ACF}}"
set output "| epstopdf -f -o=./Data_Analysis/ACF/Plots/ACF_comparison_sC_M1m1.pdf"
set multiplot layout 2,2 title "System C - FGD"
# set title "{{/Roman System C}}"
p "./Data_Analysis/ACF/Outcomes/sC_M1m1_FullcorrF_OC(B1.096).csv" u 1:2 w l lw 2 lc 1 dt 4 t " ACF of the FF - M=1 m=1", \
  "./Data_Analysis/ACF/Outcomes/sC_M1m1_FullcorrP(B1.096).csv" u 1:2 w l lw 2 lc 2 dt 1 t "ACF of P - M=1 m=1"

p "./Data_Analysis/ACF/Outcomes/sC_FullcorrF_OC.csv" u 1:2 w l lw 2 lc 1 dt 4 t " ACF of the FF - M=10 m=1", \
  "./Data_Analysis/ACF/Outcomes/sC_FullcorrP.csv" u 1:2 w l lw 2 lc 2 dt 1 t "ACF of P - M=10 m=1"

p "./Data_Analysis/ACF/Outcomes/sC_M1m1_FullcorrF_OC(B1.096).csv" u 1:2 w l lw 2 lc 7 dt 4 t " ACF of the FF - M=1 m=1", \
  "./Data_Analysis/ACF/Outcomes/sC_FullcorrF_OC.csv" u 1:2 w l lw 2 lc 4 dt 1 t " ACF of the FF - M=10 m=1"

p "./Data_Analysis/ACF/Outcomes/sC_M1m1_FullcorrP(B1.096).csv" u 1:2 w l lw 2 lc 7 dt 4 t "ACF of P - M=1 m=1", \
  "./Data_Analysis/ACF/Outcomes/sC_FullcorrP.csv" u 1:2 w l lw 2 lc 4 dt 1 t "ACF of P - M=10 m=1"

unset multiplot
set output



# EOF
