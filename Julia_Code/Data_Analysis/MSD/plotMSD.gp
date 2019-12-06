set terminal postscript eps color enhanced "Times-Roman" 30 #size 7,15
set size 1.1,1
set grid

set key font ",18"

set xlabel "{{/RomanOblique t}}"
set logscale xy

# set xrange[0:1e2]
set xrange[1e-1:1e2]

set ylabel "{{/RomanOblique MSD}}"
set format y "10^{%L}"
# set yrange[1e-4:1e0]

set key bottom right


# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/INT_msd_1e7.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/INT_msd_FGD_1e7.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/MSD/Outcomes/INT_msd_DCGD_1e7.csv" u 1:2 w l lw 5 lc 8 dt 3 t "CGD" , \
#   "./Data_Analysis/MSD/Outcomes/INT_msd_MMZD_1e7(B1.096).csv" u 1:2 w p lw 1 ps 1 lc 7 pt 4 t "MMZD"
# set output
set yrange[1e-4:1e-1]
set title "{{/RomanOblique Plateau of the MSD of the inter-bead distance}}"
# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/INT_msd_1e7_B1.096_CORRETTA.pdf"
set output "| epstopdf -f -o=../TEX_Notes/Figure/INT_MSD_CORRETTAmd.pdf"
p "./Data_Analysis/MSD/Outcomes/INT_msd_FGD_1e7(B1.096)_CORRETTA.csv" u ($1+0.1):2 w l lw 5 lc 2 dt 1 t "FGD" , \
  "./Data_Analysis/MSD/Outcomes/INT_msd_DCGD_1e7(B1.096)_CORRETTA.csv" u ($1+0.1):2 w l lw 5 lc 8 dt 3 t "CGD" , \
  "./Data_Analysis/MSD/Outcomes/INT_msd_MMZD_1e7(B1.096)_CORRETTA.csv" u ($1+0.1):2 w p lw 1 ps 1 lc 7 pt 4 t "MMZD"
set output

set xrange[1e-1:1e2]
set yrange[1e-4:1e-1]
set title "{{/RomanOblique MSD of a sigle bead}}"
# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e7_B1.096_CORRETTA.pdf"
set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD_CORRETTAmd.pdf"
p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e7(B1.096)_CORRETTA.csv" u ($1+0.1):2 w l lw 5 lc 2 dt 1 t "FGD" , \
  "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e7(B1.096)_CORRETTA.csv" u ($1+0.1):2 w l lw 5 lc 8 dt 3 t "CGD" , \
  "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e7(B1.096)_less.csv" u ($1+0.1):2 w p lw 1 ps 1 lc 7 pt 4 t "MMZD"
set output
#
# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e7_1e-4.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e7_1e-4_less.csv" u ($1+0.1):2 w l lw 5 lc 2 dt 1 t "FGD 10^{-4}" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e7_1e-4_less.csv" u ($1+0.1):2 w p lw 3 ps 2 lc 8 pt 13 t "CGD 10^{-4}" , \
#   "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e7_1e-4(B1.096)_less.csv" u ($1+0.1):2 w p lw 3 ps 2 lc 7 pt 4 t "MMZD 10^{-4}"
# set output
#
# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e7.pdf"
# set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e7_NEW.csv" u 1:2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e7_NEW.csv" u 1:2 w l lw 5 lc 8 dt 3 t "CGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e7(B1.096)_NEW.csv" u 1:2 w p lw 1 ps 1 lc 7 pt 4 t "MMZD"
# set output

# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e6.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e6_less.csv" u ($1+0.1):2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e6_less.csv" u ($1+0.1):2 w p lw 3 ps 2 lc 8 pt 13 t "CGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e6(B1.096)_less.csv" u ($1+0.1):2 w p lw 3 ps 2 lc 7 pt 4 t "MMZD"
# set output
#
# set output "| epstopdf -f -o=Data_Analysis/MSD/Plots/msd_1e5.pdf"
# # set output "| epstopdf -f -o=../TEX_Notes/Figure/MSD.pdf"
# p "./Data_Analysis/MSD/Outcomes/msd_FGD_1e5_less.csv" u ($1+0.1):2 w l lw 5 lc 2 dt 1 t "FGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_DCGD_1e5_less.csv" u ($1+0.1):2 w p lw 3 ps 2 lc 8 pt 13 t "CGD" , \
#   "./Data_Analysis/MSD/Outcomes/msd_MMZD_1e5(B1.096)_less.csv" u ($1+0.1):2 w p lw 3 ps 2 lc 7 pt 4 t "MMZD"
# set output




#  EOF
