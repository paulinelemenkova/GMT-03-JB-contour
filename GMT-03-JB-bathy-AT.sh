#!/bin/sh
# Purpose: bathymetry contour from the ETOPO5 grid 5 arc minute global data set)
# GMT modules: gmtset, grdcut, grdinfo, grdcontour, psbasemap, psxy, logo, pstext, psconvert
# Step-1. Generate a file
ps=GMT_JB_bathy_AT.ps
# Step-2. GMT set up
gmt set FORMAT_GEO_MAP=dddF \
    MAP_FRAME_PEN=dimgray \
    MAP_FRAME_WIDTH=0.08c \
    MAP_TITLE_OFFSET=.5c \
    MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    MAP_GRID_PEN_PRIMARY=thinnest,dimgray \
    FONT_TITLE=12p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY=7p,Helvetica,darkblue \
    FONT_LABEL=7p,Palatino-Roman,dimgray \
# Step-3. Cut off the grid
gmt grdcut earth_relief_05m.grd -R154/220/42/62 -Gat_relief.nc -V
gmt grdinfo @at_relief.nc
# Step-4. Add contour
gmt grdcontour @at_relief.nc -R154/220/42/62 -JB186/52/45/59/6.0i \
    -C500 -A1000+f5p,Times -T+d15p/3p -W0.1p\
    --FONT_ANNOT_PRIMARY=7p,Palatino-Roman,dimgray \
	-P -K > $ps
# Step-5. Basemap: title, ticks
gmt psbasemap -R -J \
	-Bxg4f4a10 -Byg2f2a4 \
	-B+t"Topographic contour map of the Aleutian Islands and Aleutian Trench area" \
    -UBL/-7p/-35p -O -K >> $ps
# Step-6. Add scale, directional rose
gmt psbasemap -R -J \
    --FONT=8p,Palatino-Roman,dimgray \
    --MAP_TITLE_OFFSET=0.3c \
    -Tdg144/58+w0.5c+f2+l \
    -Lx5.1i/-0.5i+c50+w1500k+l"Conic equal-area Albers projection. Scale at 52\232N, km"+f \
    -O -K >> $ps
# Step-7. Study area
gmt psbasemap -R -J \
    -D170/45/210/58r -F+pthin,red \
    -O -K >> $ps
# Step-8. Study area label annotation
gmt psxy -R -J -Wthin -O -K \
    -Sqn1:+f10p,Times-Roman,red+l"Study Area"+c3p+pthick,red+o+gwhite << EOF >> $ps
170.0 44.0
203.6 43.7
EOF
# Step-9. Add logo
gmt logo -R -J -Dx6.5/-2.2+o0.1i/0.1i+w2c -O -K >> $ps
gmt pstext -R -J -F+f7p,Helvetica,dimgray+jCB -N -O -K >> $ps << EOF
5.3 -0.8 Standard paralles at 45\232 and 55\232 N
EOF
# Step-10. Add subtitle
gmt pstext -R0/10/0/15 -JX10/10 -X0.5c -Y4.7c -N -O \
-F+f10p,Palatino-Roman,black+jLB >> $ps << EOF
3.0 5.0 ETOPO1 Global Relief Model 1 arc min resolution grid
EOF
# Step-11. Convert to image file using GhostScript
gmt psconvert GMT_JB_bathy_AT.ps -A0.2c -E720 -Tj -Z
