set terminal epslatex monochrome 10
set output "reptx-ci.eps"
set size .5,.75

# set terminal png size 900,600
# set output "reptx-ci.png"

# enable minor tics on both axes
set xtics nomirror
set ytics mirror
# set mxtics
# set mytics

# display grid
# set grid
set key off

set title "Average conflict index"

set xlabel "Time (min)"
#set ylabel "Average conflict index"

set logscale x 2

plot	[10:500] \
	"200-aci.dat" with points pt 5 title "200 x 200", \
	"350-aci.dat" with points pt 4 title "350 x 350", \
	"500-aci.dat" with points pt 7 title "500 x 500"