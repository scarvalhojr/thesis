set terminal postscript eps enhanced mono "Times" 18
set output "affy_blm.eps"
set size 1.22,.9

#set terminal png size 900,600
#set output "affy_blm.png"

set xtics nomirror 0,5,74
set ytics nomirror
set y2tics nomirror
#set mxtics 5
set mytics
set my2tics

#set grid xtics

#set key Left reverse samplen 0 spacing 1.5 width -6 height 1 box
set key off

# set title "Normalized border length" font "Times,20"

set xlabel "Masking step"
set ylabel "Average number of border conflicts per probe"
set y2label "Number of synthesized middle bases"
set y2range [0:45000]

plot [0:75] \
	"YGS98-S_affy_pairleft.blm" using 1:5 with points pt 2 title "YGS98-S", \
	"HGU95A2-S_affy_pairleft.blm" using 1:5 with points pt 1 title "HGU95A2-S", \
	"EC2-S_affy_pairleft.blm" using 1:5 with points pt 4 title "EC2-S", \
	"EC2-S_affy_pairleft.blm" using 1:2 axes x1y2 with boxes title "EC2-S"