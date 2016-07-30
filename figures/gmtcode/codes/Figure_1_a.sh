clear

rm gmt.conf
rm gmt.hist


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

OUTNAME=figure1_a
PSNAME=${OUTNAME}.ps


 
gmt grdgradient etopo1_bedrock.grd -A300 -Gmytopo.grad -Nt
gmt psbasemap -R25/80/20/45 -JM5i  -B10f5/10f5 -Y8i -V -P -K > ${PSNAME}
gmt grdimage etopo1_bedrock.grd -R -J -Bwnes  -Cetopo1.cpt  -V -O -K >> ${PSNAME}
gmt pscoast -R -J -B -Dh -W0.25p -N1/0.25p -A500 -V -P -O -K -Lf73/23/23/1000 >> ${PSNAME}
gmt pscoast -R -J -B -Slightblue -A500 -Dh -W0.25p -V -P -O -K >> ${PSNAME}



cat << EOF13 |gmt psxy  -Sc0.05  -W1 -JM5i -R25/80/20/45 -K -O  >> ${PSNAME}

43.5	34
43.5	40
61.5    40
61.5    34
44.228  39.4
48.971  31.136
60.173  36.429
61.435  25.075

EOF13



# Creating PDF
# ------------------------------------------------------------------------------

gmt ps2raster ${PSNAME} -Tf -Au0.25c
rm ${PSNAME}
rm mytopo.grad


# Opening PDF
# ------------------------------------------------------------------------------

open -a Adobe\ Acrobat\ Pro.app ${OUTNAME}.pdf


