set terminal epslatex monochrome 10
set output "ci.eps"
set size .66,.93

#set terminal png size 900,600
#set output "ci.png"

# enable minor tics on both axes
set xtics nomirror
set ytics mirror
set mxtics
set mytics

# display grid
# set grid
set key off

set title "Average conflict index"

set xlabel "Time (min)"
#set ylabel "Average conflict index"

set logscale x 2

plot [1.1:1000] \
	"300-aci.dat" with points pt 5 title "200 x 200", \
	"500-aci.dat" with points pt 4 title "500 x 500", \
	"800-aci.dat" with points pt 7 title "800 x 800"