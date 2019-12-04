set terminal postscript eps color enhanced "Times-Roman" 30 #size 7,15
set size 1.1,1
set grid

set key font ",18"

set xlabel "{{/RomanOblique t}}"
set logscale xy

set xrange[1e0:1e2]

set ylabel "{{/RomanOblique MSD}}"
# set format y "10^{%L}"

# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e7_less.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e7_less.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_FGD_1e7_1e-4_less.csv" u 1:2 w l lw 5 lc 5 dt 1 t "FGD 10^7 10^{-4}" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e7_1e-4_less.csv" u 1:2 w p lw 1 lc 6 dt 2 t "DCGD 10^7 10^{-4}" , \
#   "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e7_1e-4(B1.096)_less.csv" u 1:2 w p lw 1 ps 1 lc 7 pt 3 t "MMZD 10^7 10^{-4}"
# set output
# "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e7_less.csv" u 1:2 w p lw 2 ps 1 lc 6 pt 2 t "DCGD" , \
# "./Data_Analysis/MSD/Outcomes/msd_FGD_1e6_less.csv" u 1:2 w l lw 5 lc 3 dt 1 t "FGD 10^6" , \
# "./Data_Analysis/MSD/Outcomes/msd_FGD_1e7_test_less.csv" u 1:2 w p lw 5 lc 4 dt 1 t "FGD 10^7 test" , \
# "./Data_Analysis/MSD/Outcomes/msd_FGD_1e8_1e-4.csv" u 1:2 w l lw 5 lc 6 dt 1 t "FGD 10^8 10^{-4}" , \


# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e7_1e-4.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e7_1e-4_less.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD 10^{-4}" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e7_1e-4_less.csv" u 1:2 w p lw 3 ps 2 lc 8 pt 13 t "DCGD 10^{-4}" , \
#   "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e7_1e-4(B1.096)_less.csv" u 1:2 w p lw 3 ps 2 lc 7 pt 4 t "MMZD 10^{-4}"
# set output


# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e7.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e7_less.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e7_less.csv" u 1:2 w p lw 3 ps 2 lc 8 pt 13 t "DCGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e7(B1.096)_less.csv" u 1:2 w p lw 3 ps 2 lc 7 pt 4 t "MMZD"
# set output

# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e6.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e6_less.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e6_less.csv" u 1:2 w p lw 3 ps 2 lc 8 pt 13 t "DCGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e6(B1.096)_less.csv" u 1:2 w p lw 3 ps 2 lc 7 pt 4 t "MMZD"
# set output

set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e5.pdf"
# set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e5_less.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
  "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e5_less.csv" u 1:2 w p lw 3 ps 2 lc 8 pt 13 t "DCGD" , \
  "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e5(B1.096)_less.csv" u 1:2 w p lw 3 ps 2 lc 7 pt 4 t "MMZD"
set output




#  EOF
