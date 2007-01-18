set terminal epslatex monochrome 10
set output "ci.eps"
set size 1.2,1.2

#set terminal png size 900,600
#set output "ci.png"

# enable minor tics on both axes
set xtics nomirror 0,5,74
set ytics nomirror
set y2tics nomirror
#set mxtics 5
set mytics
set my2tics

# display grid
# set grid
# set key off

# set title "Normalized border length"

set xlabel "Masking step"
set ylabel "Normalized border length"
set y2label "Number of synthesized middle bases"
set y2range [0:26000]

plot [0:75] \
	"SRA_500x500-250000-25-01_GREEDYPLACER-CI-20K-0-SORTSEQ_leftmost.blm" using 1:4 with points pt 4 notitle, \
	"SRA_500x500-250000-25-01_GREEDYPLACER-CI-20K-0-SORTSEQ_SEQREEMBED-CI-NORESET-2.blm" using 1:4 with points pt 5 notitle, \
	"SRA_500x500-250000-25-01_GREEDYPLACER-CI-20K-0-SORTSEQ_SEQREEMBED-CI-NORESET-2.blm" using 1:2 axes x1y2 with boxes notitle
