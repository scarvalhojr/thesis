set terminal postscript eps enhanced mono "Times" 18
set output "EC2.eps"
set size 1.22,.9

#set terminal png size 900,600
#set output "EC2.png"

set xtics nomirror 0,5,74
set ytics nomirror
set mxtics 5
set mytics

set grid xtics

#set key Left reverse samplen 0 spacing 1.5 width -6 height 1 box
set key off

# set title "Normalized border length" font "Times,20"

set xlabel "Masking step"
set ylabel "Normalized border length"

plot [0:75] \
	"EC2_affy_pairleft.blm" using 1:4 with points pt 6 title "EC2_affy_pairleft", \
	"EC2_affy_SEQREEMBED-BL-NORESET-2.blm" using 1:4 with points pt 1 title "EC2_affy_SEQREEMBED-BL-NORESET-2", \
	"EC2-S_GREEDYPLUS-BL-10K-5_SEQREEMBED-BL-NORESET-2.blm" using 1:4 with points pt 4 title "EC2-S_GREEDYPLUS-BL-10K-5_SEQREEMBED-BL-NORESET-2", \
	"EC2-S_GREEDYPLUS-CI-10K-0_SEQREEMBED-CI-NORESET-2.blm" using 1:4 with points pt 2 title "EC2-S_GREEDYPLUS-CI-10K-0_SEQREEMBED-CI-NORESET-2"