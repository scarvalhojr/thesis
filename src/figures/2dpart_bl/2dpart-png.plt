set terminal png size 900,600
set output "2dpart.png"

# enable minor tics on both axes
set mxtics
set mytics

# display grid
set grid

set xlabel "Masking step"
set ylabel "Normalized border length"

plot	[0:75] [-0.02:1] \
	"SRA_1000x1000-100000-25_01_2d1-center-greedy_centered_border_shifted" with points notitle, \
	"SRA_1000x1000-100000-25_01_2d64-center-greedy_centered_border_shifted" with points notitle, \
	"SRA_1000x1000-100000-25_01_2d1-left-greedy_leftmost_border_shifted" with points notitle, \
	"SRA_1000x1000-100000-25_01_2d64-left-greedy_leftmost_border_shifted" with points notitle