set terminal epslatex monochrome 10
set output "bl.eps"
set size .66,.93

#set terminal png size 900,600
#set output "bl.png"

# enable minor tics on both axes
set xtics nomirror
set ytics mirror
# set mxtics
# set mytics

# display grid
# set grid
set key off

set title "Normalized border length"

set xlabel "Time (min)"
#set ylabel "Normalized border length"

set logscale x 2

#plot	[] [44:48.2]
plot [4:2000]\
	"300-nbl.dat" with points pt 5 title "300 x 300", \
	"500-nbl.dat" with points pt 4 title "500 x 500", \
	"800-nbl.dat" with points pt 7 title "800 x 800"