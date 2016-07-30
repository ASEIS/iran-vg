
clear

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

OUTNAME=seismicity
PSNAME=${OUTNAME}.ps

# Top Map - Notable
# ------------------------------------------------------------------------------

gmt grdgradient mytopo.grd -A300 -Gmytopo.grad -Nt
#gmt grdhisteq mytopo.grad -Gmytopo.hist -N
#gmt grdmath mytopo.hist 3 DIV = mytopo.norm

# Top Map - Historical
# ------------------------------------------------------------------------------

gmt psbasemap -R43.5/61.5/34/40 -JM5i -BWnes -Ba2f1 -Y8i -V -P -K > ${PSNAME}

# gmt psbasemap -R -J -BWnes -Ba2f1 -Y-3.5i -V -P -O -K >> ${PSNAME}
gmt grdimage mytopo.grd -R -J -Bwnes -Imytopo.norm -Cgray -t50 -V -O -K >> ${PSNAME}
gmt pscoast -R -J -B -Dh -W0.25p -N1/0.25p -A500 -V -P -O -K >> ${PSNAME}
gmt pscoast -R -J -B -Slightblue -A500 -Dh -W0.25p -V -P -O -K >> ${PSNAME}

gmt makecpt -Chot -T0/1800/100 -Z -V > historical.cpt
awk '{print $2,$3,$1,($4^3.2)/1000}' historical.txt > data.txt
gmt psxy data.txt -R -J -Sc -W0.5 -Chistorical.cpt -V -K -O >> ${PSNAME} 

# Bottom Map - Instrumental
# ------------------------------------------------------------------------------

gmt psbasemap -R -J -BWneS -Ba2f1 -Y-2.5i -V -P -O -K >> ${PSNAME}
gmt grdimage mytopo.grd -R -J -Bwnes -Imytopo.norm -Cgray -t50 -V -O -K >> ${PSNAME}
gmt pscoast -R -J -B -Dh -W0.25p -N1/0.25p -A500 -V -P -O -K >> ${PSNAME}
gmt pscoast -R -J -B -Slightblue -A500 -Dh -W0.25p -V -P -O -K >> ${PSNAME}

awk '{print $1,$2,($3^3.2)/1000}' instrumental.txt > data.txt
gmt psxy data.txt -R -J -Sc -W0.5 -G0/220/140 -V -K -O >> ${PSNAME} 

# Magnitude Scale
# ------------------------------------------------------------------------------

cat << END | \
awk '{print $2,$3,$1,($4^3.2)/1000}' | \
gmt psxy -R -J -N -Sc -W0.5 -Chistorical.cpt -V -K -O >> ${PSNAME}
1900   63	37.5	5.0
1900   63	36.7	6.0
1900   63	35.7	7.0
1900   63	34.5	8.0
END

gmt pstext -R -J -B -D5p/0p -N -V -K -O >> ${PSNAME} << END
62.1 38.3 8 0 1 ML Magnitude
63.6 37.5 8 0 1 ML 5.0
63.6 36.7 8 0 1 ML 6.0
63.6 35.7 8 0 1 ML 7.0
63.6 34.5 8 0 1 ML 8.0
END

# Year Color Scale
# ------------------------------------------------------------------------------

gmt psscale -Chistorical.cpt -D5.3i/3.5i/1.8i/0.2i -B300 -E -O >> ${PSNAME}

# Creating PDF
# ------------------------------------------------------------------------------

gmt ps2raster ${PSNAME} -Tf -Au0.25c
rm ${PSNAME}
rm data.txt
rm mytopo.grad
rm mytopo.hist
rm mytopo.norm

# Opening PDF
# ------------------------------------------------------------------------------

open -a Adobe\ Acrobat\ Pro.app ${OUTNAME}.pdf

