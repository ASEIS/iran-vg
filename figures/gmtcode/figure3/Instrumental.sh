#!/bin/bash



 

rm gmt.conf gmt.history

# Set GMT constants
# ------------------------------------------------------------------------------

gmt gmtset FONT                     8

gmt gmtset MAP_DEFAULT_PEN          0.75p
gmt gmtset MAP_FRAME_PEN            0.75p
gmt gmtset MAP_FRAME_WIDTH          3p
gmt gmtset MAP_TICK_PEN             0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY     0.75p
gmt gmtset MAP_TICK_PEN_SECONDARY   0.75p
gmt gmtset MAP_GRID_PEN_PRIMARY     0.75p
gmt gmtset MAP_TICK_LENGTH_PRIMARY  6p/3p
gmt gmtset MAP_LABEL_OFFSET         8p
gmt gmtset MAP_ANNOT_OFFSET_PRIMARY 5p



# Set script constants
# ------------------------------------------------------------------------------

OUTNAME=figure2
PSNAME=${OUTNAME}.ps

PROJ=-JM5i

gmt grdgradient etopo1_bedrock.grd -A300 -Gmytopo.grad -Nt
gmt grdhisteq mytopo.grad -Gmytopo.hist -N
gmt grdmath mytopo.hist 3 DIV = mytopo.norm

gmt psbasemap -R43.5/61.5/34/40 -JM5i  -B2f1/2f1 -Y8i -V -P -K > ${PSNAME}
gmt grdimage etopo1_bedrock.grd -R -J -Bwnes  -Cetopo1.cpt  -V -O -K >> ${PSNAME}
gmt pscoast -R -J -B -Dh -W0.25p -N1/0.25p -A500 -V -P -O -K -Lf73/23/23/1000 >> ${PSNAME}
gmt pscoast -R -J -B -Slightblue -A500 -Dh -W0.25p -V -P -O -K >> ${PSNAME}


awk '($7>2.8){print $9,$10,($7^2.5)/140}' Alborz_2005_all_mag.txt|gmt psxy -Sc -G196/19/19 -W0.5  -R$REGION $PROJ -K -O >> ${PSNAME}
awk '($7>3.4){print $9,$10,($7^2.5)/140}' Azerbaijan_2005_all_mag.txt|gmt psxy -Sc -G102/178/255 -W0.5  -R $PROJ -K -O >> ${PSNAME}
awk '($7>2.5){print $9,$10,($7^2.5)/140}' KopehDagh_2005_all_mag.txt|gmt psxy -Sc -G153/153/153 -W0.5  -R $PROJ -K -O >> ${PSNAME}

cat << EOF |awk '{print $1,$2,($3^2.5)/140}' |gmt psxy -Sc -G196/19/19 -W0.5  -R $PROJ -O >> ${PSNAME}
61 37.7   3
61 38.0   4
61 38.2   5
61 38.6   6
EOF


# Creating PDF
# ------------------------------------------------------------------------------

gmt ps2raster ${PSNAME} -Tf -Au0.25c
rm ${PSNAME}
rm data.txt
rm mytopo.grad

# Opening PDF
# ------------------------------------------------------------------------------

open -a Adobe\ Acrobat\ Pro.app ${OUTNAME}.pdf



