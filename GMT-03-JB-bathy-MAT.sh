#!/bin/sh
# Purpose: bathymetry contour from the ETOPO5 grid 5 arc minute global data set
# here: Middle America Trench
# GMT modules: gmtset, grdcut, grdinfo, grdcontour, psbasemap, psxy, logo, pstext, psconvert
# Step-1. Generate a file
ps=GMT_JB_bathy_MAT.ps
# Step-2. GMT set up
gmt set FORMAT_GEO_MAP=dddF \
    MAP_FRAME_PEN=dimgray \
    MAP_FRAME_WIDTH=0.08c \
    MAP_TITLE_OFFSET=.7c \
    MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    MAP_GRID_PEN_PRIMARY=thinnest,dimgray \
    MAP_GRID_PEN_SECONDARY=thinnest,dimgray \
    FONT_TITLE=12p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY=7p,Helvetica,darkblue \
    FONT_LABEL=7p,Palatino-Roman,dimgray \
# Step-3. Cut off the grid
gmt grdcut earth_relief_05m.grd -R263/278/7/17 -Gmat_relief.nc -V
gmt grdinfo @mat_relief.nc
# Step-4. Add contour
gmt grdcontour @mat_relief.nc -R263/278/7/17 -JB270/12/10/14/6.0i \
    -C250 -A500+f5p,Times -T+d15p/3p -W0.1p\
    --FONT_ANNOT_PRIMARY=7p,Palatino-Roman,dimgray \
	-P -K > $ps
# Step-5. Basemap: title, ticks
gmt psbasemap -R -J \
	-Bpxg4f2a2 -Bpyg6f2a2 -Bsxg2 -Bsyg2 \
	-B+t"Topographic contour map of the Guatemala Trench area" \
    -UBL/-7p/-35p -O -K >> $ps
# Step-6. Add scale, directional rose
gmt psbasemap -R -J \
    --FONT=8p,Palatino-Roman,dimgray \
    --MAP_TITLE_OFFSET=0.3c \
    -Tdg144/58+w0.5c+f2+l \
    -Lx12.8c/-0.5i+c50+w500k+l"Conic equal-area Albers projection. Scale at 12\232N, km"+f \
    -O -K >> $ps
# Step-7. Study area
gmt psbasemap -R -J \
    -D266/273/11.5/15 -F \
    -O -K >> $ps
# Step-8. Study area label annotation
gmt psxy -R -J -Wthin -O -K \
    -Sqn1:+f10p,Times-Roman,red+l"Study Area"+c2p+pthin,red+o+gwhite << EOF >> $ps
266.0 15.0
273.0 11.5
EOF
# Step-9. Add logo
gmt logo -R -J -Dx6.5/-2.2+o0.1i/0.1i+w2c -O -K >> $ps
gmt pstext -R -J -F+f7p,Helvetica,dimgray+jCB -N -O -K >> $ps << EOF
5.3 -0.8 Standard paralles at 10\232 and 14\232 N
EOF
# Step-10. Add subtitle
gmt pstext -R0/10/0/15 -JX10/10 -X0.5c -Y7.5c -N -O \
-F+f10p,Palatino-Roman,black+jLB >> $ps << EOF
3.0 5.0 ETOPO1 Global Relief Model 1 arc min resolution grid
EOF
# Step-11. Convert to image file using GhostScript
gmt psconvert GMT_JB_bathy_MAT.ps -A0.2c -E720 -Tj -Z
