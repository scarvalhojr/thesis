set terminal postscript eps enhanced mono "Times" 18
set output "bl.eps"
set size 1.22,.9

#set terminal png size 900,600
#set output "bl.png"

set xtics nomirror 0,5,74
set ytics nomirror
set y2tics nomirror
#set mxtics 5
set mytics
set my2tics

#set grid xtics

# set key Left reverse samplen 0 spacing 1.5 width -6 height 1 box
set key off

# set title "Normalized border length" font "Times,20"

set xlabel "Masking step"
set ylabel "Normalized border length"
set y2label "Number of synthesized middle bases"
set y2range [0:145000]

plot [0:75] [-0.01:0.34] \
	"SRA_1000x1000-1000000-25-01_2DPART-50-GREEDYPLACER-BL-3K-0-KEEP_leftmost.blm" using 1:4 with points pt 4 notitle, \
	"SRA_1000x1000-1000000-25-01_2DCENTRALPART-50-GREEDYPLACER-BL-3K-0-KEEP_centered.blm" using 1:4 with points pt 2 notitle, \
	"SRA_1000x1000-1000000-25-01_2DCENTRALPART-50-GREEDYPLACER-BL-3K-0-KEEP_centered.blm" using 1:2 axes x1y2 with boxes notitle