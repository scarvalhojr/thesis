set terminal epslatex monochrome 10
set output "bl.eps"
set size 1.2,1.2

#set terminal png size 900,600
#set output "bl.png"

# enable minor tics on both axes
set xtics nomirror 0,5,74
set ytics mirror
set mxtics 5
set mytics

# display grid
set grid xtics
# set key off

# set title "Normalized border length"

set xlabel "Masking step"
set ylabel "Normalized border length"

plot [0:75] \
	"SRA_500x500-250000-25-01_GREEDYPLACER-BL-20K-0-SORTSEQ_SEQREEMBED-BL-NORESET-2.blm" using 1:4 with points pt 4 notitle, \
	"SRA_500x500-250000-25-01_GREEDYPLACER-BL-20K-0-SORTSEQ_leftmost.blm" using 1:4 with points pt 5 notitle
