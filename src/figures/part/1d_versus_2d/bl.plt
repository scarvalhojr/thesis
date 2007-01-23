set terminal postscript eps enhanced mono "Times" 18
set output "bl.eps"
set size 1.22,.9

#set terminal png size 900,600
#set output "bl.png"

set xtics nomirror 0,5,74
set ytics nomirror
set mxtics 5
set mytics

set grid xtics

# set key Left reverse samplen 0 spacing 1.5 width -6 height 1 box
set key off

# set title "Normalized border length" font "Times,20"

set xlabel "Masking step"
set ylabel "Normalized border length"

plot [0:75] [-0.01:0.51] \
	"SRA-1000x1000-1000000-25-01_1DPART-1-SEQPLACER-KEEP_leftmost.blm" using 1:4 with points pt 2 notitle, \
	"SRA-1000x1000-1000000-25-01_2DPART-1-SEQPLACER-KEEP_leftmost.blm" using 1:4 with points pt 4 notitle, \
	"SRA-1000x1000-1000000-25-01_1DPART-1-GREEDYPLACER-BL-1K-0-KEEP_leftmost.blm" using 1:4 with points pt 1 notitle, \
	"SRA-1000x1000-1000000-25-01_2DPART-50-GREEDYPLACER-BL-3K-0-KEEP_leftmost.blm" using 1:4 with points pt 6 notitle
