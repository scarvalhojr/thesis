set terminal epslatex monochrome 10
set output "2dpart_bl.eps"
set size 1,.75

# set terminal png size 900,600
# set output "2dpart.png"

set xtics nomirror
set ytics mirror

# enable minor tics on both axes
set mxtics
set mytics

# display grid
# set grid

# set xlabel "Masking step"
# set ylabel "Normalized border length"

plot	[-1:76] [-0.05:0.7] \
	"SRA_1000x1000-100000-25_01_2d64-center-greedy_centered_border_shifted" with points pointtype 5 notitle, \
	"SRA_1000x1000-100000-25_01_2d64-left-greedy_leftmost_border_shifted" with points pointtype 4 notitle
