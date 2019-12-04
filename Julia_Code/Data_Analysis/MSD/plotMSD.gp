set terminal postscript eps color enhanced "Times-Roman" 30 #size 7,15
set size 1.1,1
set grid

set key font ",18"

set xlabel "{{/RomanOblique t}}"
set logscale xy

set xrange[0:1e2]

set ylabel "{{/RomanOblique MSD}}"
# set format y "10^{%L}"

set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e7.pdf"
# set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e7.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
  "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e7.csv" u 1:2 w l lw 5 lc 6 dt 2 t "DCGD" , \
  "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e7(B1.096).csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD"
set output


# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e7_test.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/msd_FGD.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_FGD_1e7.csv" u 1:2 w l lw 5 lc 3 dt 1 t "FGD less data" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e7.csv" u 1:2 w l lw 5 lc 6 dt 2 t "DCGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD.csv" u 1:2 w l lw 5 lc 8 dt 2 t "DCGD less data" , \
#   "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e7(B1.096).csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD"
# set output


# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/msd_FGD.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD.csv" u 1:2 w l lw 5 lc 6 dt 2 t "DCGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_MMZD.csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD"
# set output

# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_test.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e5.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e5.csv" u 1:2 w l lw 5 lc 6 dt 2 t "DCGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e5(B1.096).csv" u 1:2 w l lw 5 lc 7 dt 4 t "MMZD"
# set output



#  EOF
