#!/bin/bash

for item in alfa beta gamma epsilon zeta
do

tor="$item"

#file="E_QM_ref_zero.dat"
#file="E_MM_zero_ref_zero.dat"
file="E_QM-MM_zero_ref_zero.dat"

#outname="_QM_refpoint_zero.png"
#outname="_MM_zero_refpoint_zero.png"
outname="_QM-MM_zero_refpoint_zero.png"


top=`cat dimer_??/rotation_$tor/$file | sort -nk2,2 | tail -1 | awk '{printf "%3.0f\n", $2+1}'`  # y axis max
dash="_"

cat > tmp_grace.in << EOF
arrange (1,1,.15,0.6,0.6,ON,ON,ON)
 FOCUS G0
 READ NXY "dimer_AA/rotation_$tor/$file"
 READ NXY "dimer_AC/rotation_$tor/$file"
 READ NXY "dimer_AG/rotation_$tor/$file"
 READ NXY "dimer_AU/rotation_$tor/$file"
 READ NXY "dimer_CA/rotation_$tor/$file"
 READ NXY "dimer_CC/rotation_$tor/$file"
 READ NXY "dimer_CG/rotation_$tor/$file"
 READ NXY "dimer_CU/rotation_$tor/$file"
 READ NXY "dimer_GA/rotation_$tor/$file"
 READ NXY "dimer_GC/rotation_$tor/$file"
 READ NXY "dimer_GG/rotation_$tor/$file"
 READ NXY "dimer_GU/rotation_$tor/$file"
 READ NXY "dimer_UA/rotation_$tor/$file"
 READ NXY "dimer_UC/rotation_$tor/$file"
 READ NXY "dimer_UG/rotation_$tor/$file"
 READ NXY "dimer_UU/rotation_$tor/$file"
 #hides the NXY graph
 S0  line color 1
 S0  legend "AA"
 S1  line color 2
 S1  legend "AC"
 S2  line color 3
 S2  legend "AG"
 S3  line color 4
 S3  legend "AU"
 S4  line color 5
 S4  legend "CA"
 S5  line color 6
 S5  legend "CC"
 S6  line color 7
 S6  legend "CG"
 S7  line color 8
 S7  legend "CU"
 S8  line color 9
 S8  legend "GA"
 S9  line color 10
 S9  legend "GC"
 S10  line color 11
 S10  legend "GG"
 S11  line color 12
 S11  legend "GU"
 S12  line color 13
 S12  legend "UA"
 S13  line color 14
 S13  legend "UC"
 S14  line color 15
 S14  legend "UG"
 S15  line color 1
 S15  legend "UU"
 AUTOSCALE

#yaxis  label "QM (kcal/mol)"	
#yaxis  label "MM\szero\N (kcal/mol)"
yaxis  label "QM-MM\szero\N (kcal/mol)"
yaxis  tick minor ticks 3
yaxis  bar linewidth 2.0
yaxis  tick major linewidth 2
yaxis  tick minor linewidth 2

xaxis  label "$tor torsion (\c0\C)"	
xaxis  tick major 60
xaxis  tick minor ticks 3
xaxis  bar linewidth 2.0
xaxis  tick major linewidth 2
xaxis  tick minor linewidth 2

world 0, 0, 400, $top

legend 1.10, 0.8
legend box linewidth 2

PRINT TO "$tor$outname"
HARDCOPY DEVICE "PNG"
PAGE SIZE 2560, 2048
#PAGE SIZE 800, 600
DEVICE "PNG" FONT ANTIALIASING on
DEVICE "PNG" OP "transparent:off"
DEVICE "PNG" OP "compression:9"
PRINT

EOF

xmgrace -batch tmp_grace.in -nosafe -maxpath 1000000 -hardcopy



done
