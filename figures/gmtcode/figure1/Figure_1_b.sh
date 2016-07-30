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

OUTNAME=figure1_b
PSNAME=${OUTNAME}.ps

PROJ=-JM5i
 
gmt grdgradient etopo1_bedrock.grd -A300 -Gmytopo.grad -Nt
gmt psbasemap -R43.5/61.5/34/40 -JM5i  -B2f1/2f1 -Y8i -V -P -K > ${PSNAME}
gmt grdimage etopo1_bedrock.grd -R -J -Bwnes  -Cetopo1.cpt  -V -O -K >> ${PSNAME}
gmt pscoast -R -J -B -Dh -W0.25p -N1/0.25p -A500 -V -P -O -K -Lf48/23/23/500 >> ${PSNAME}
gmt pscoast -R -J -B -Slightblue -A500 -Dh -W0.25p -V -P -O -K >> ${PSNAME}


cat << EOF13 |gmt psxy   -W1 -R$REGION $PROJ -K -O  >> ${PSNAME}
47.344753	40.72171
49.599926	39.52165
49.26277	38.11627
51.85228	36.86008
54.88121	38.01132
53.19502	39.433327
53.29621	39.878605
55.519176	39.318867
61.2336	36.95889
61.145393	34.578835
59.67538	35.37419
58.63931	35.737476
56.517025	36.478027
54.994373	35.992893
55.327847	35.49136
53.06872	34.645313
50.779488	35.52528
49.27474	35.65256
48.840446	35.903687
48.2894	36.30808
47.588062	36.824024
47.053734	37.228394
46.56968	37.688374
46.28586	37.92538
45.349907	38.177174
44.077763	37.524677
43.326397	38.110287
43.20934	38.12
43          38.14
EOF13

cat << EOF13 |gmt psxy   -W1 -R$REGION $PROJ -K -O  >> ${PSNAME}
54.88124	38.025238
55.346798	36.64662
54.77771	36.369
55.011066	35.97895
EOF13

cat << EOF13 |gmt psxy   -W1 -R$REGION $PROJ -K -O  >> ${PSNAME}
44.061092	37.552536
45.14642	36.71594
46.231182	35.587036
46.69862	35.18276
47.11616	34.917736
47.417107	34.889496
47.65116	34.861343
48.085346	34.554543
48.88672	33.88535
50.17236	32.867535
EOF13

cat << EOF13 |gmt psxy   -W1 -R$REGION $PROJ -K -O  >> ${PSNAME}
60.878136	34.732304
60.869137	30.069403
EOF13


cat << EOF13 |gmt psxy   -W1 -R$REGION $PROJ -K -O  >> ${PSNAME}
43          35.6
43.20405	35.368378
43.78873	35.061375
44.70654	34.071888
45.674435	33.040577
46.542885	32.46873
46.89362	32.245556
EOF13



cat << EOF13 |gmt psxy   -W1 -R$REGION $PROJ -K -O  >> ${PSNAME}
47.25	37.06
49.46	38.9
EOF13


#Tehran
cat << EOF13 |gmt psxy -Sa0.4  -W0.5 -R$REGION $PROJ -G200/0/0 -K -O  >> ${PSNAME}
51.39	35.7
EOF13

cat << EOF13 |gmt pstext   -R$REGION $PROJ  -K -O  >> ${PSNAME}
51  36.1	10 0 0.05 5 Tehran
EOF13




# Creating PDF
# ------------------------------------------------------------------------------

gmt ps2raster ${PSNAME} -Tf -Au0.25c
rm ${PSNAME}
rm data.txt
rm mytopo.grad

# Opening PDF
# ------------------------------------------------------------------------------

open -a Adobe\ Acrobat\ Pro.app ${OUTNAME}.pdf



