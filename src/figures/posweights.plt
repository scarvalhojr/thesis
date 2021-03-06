set terminal postscript eps enhanced mono "Times" 18
set output "posweights.eps"
set size .75,.6

#set terminal epslatex color 10
#set output "posweights.eps"
#set size .75,.65

#set terminal png size 880,660
#set output "position_weights.png"

set xtics nomirror
set ytics mirror
set mxtics
set mytic

# display grid
#set grid ytics xtics

#set xlabel "$b_{s,k}$"
#set ylabel "$\\omega(s,k)$"

set pointsize 1.25

plot [-0.5:25.5] "posweights.dat" with points pointtype 13 notitle