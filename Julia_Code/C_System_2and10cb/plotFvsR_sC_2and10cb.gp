set terminal postscript eps color enhanced "Times-Roman" 9
set size 1.1,1.1
set ylabel "{{/RomanOblique Mean Force}}"
set xlabel "{{/RomanOblique R}}"
#set xrange [0:2]
#set yrange [-1e8:1e8]
unset key
set grid


set output "| epstopdf -f -o=./C_System_2and10cb/plotFvsR_sC_2and10cb.pdf"
set multiplot layout 2,2 title "[System C, Gamma=1, Beta=1, dt=10^{-4}, FullSteps=10^5, OrthoSteps=1, OrthoSamples=10^{6}, MacroSamples=10^2]" \
font ",14" margins 0.12, 1, 0.09, 0.88 spacing 0.1

set title "2 constrained beads"
p "./C_System_2and10cb/C_2cb.csv" u 1:2 w lp lw 2 lc rgb "red"

set title "10 constrained beads"
p "./C_System_2and10cb/C_10cb.csv" u 1:2 w lp lw 2 lc rgb "green"

set key bottom right
unset title
p "./C_System_2and10cb/C_2cb.csv" u 1:2 w lp lw 2 t "2 constraine beads", "./C_System_2and10cb/C_10cb.csv" u 1:2 w l lw 2 t "10 constrained beads"

unset key
set title "Effective Potential (2 constrained beads)"
set ylabel "{{/RomanOblique Effective Potential}}"
p "./C_System_2and10cb/C_2cb.csv" u 1:3 w lp lw 2 lc rgb "blue"

unset multiplot

set output
#   EOF
