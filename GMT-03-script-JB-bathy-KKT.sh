#!/bin/sh
# Purpose: bathymetry contour from the ETOPO5 grid 5 arc minute global data set (here: Kuril-Kamchatka area)
# GMT modules: gmtset, grdcut, grdinfo, grdcontour, psbasemap, psxy, logo, pstext, psconvert
# Step-1. Generate a file
ps=GMT_JB_bathy_KKT.ps
# Step-2. GMT set up
gmt set FORMAT_GEO_MAP=dddF \
    MAP_FRAME_PEN=dimgray \
    MAP_FRAME_WIDTH=0.08c \
    MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    MAP_GRID_PEN_PRIMARY=thinnest,dimgray \
    FONT_TITLE=14p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY=7p,Helvetica,darkblue \
    FONT_LABEL=7p,Palatino-Roman,dimgray \
# Step-3. Cut off the grid
gmt grdcut earth_relief_05m.grd -R140/170/40/60 -Gkkt_relief.nc -V
gmt grdinfo @kkt_relief.nc
# Step-4. Add contour
gmt grdcontour @kkt_relief.nc -R140/170/40/60 -JB155/50/45/55/6.0i \
    -C500 -A1000 -S4 -T+d15p/3p \
    --FONT_ANNOT_PRIMARY=7p,Palatino-Roman,dimgray \
	-P -K > $ps
# Step-5. Basemap: title, ticks
gmt psbasemap -R -J \
	-Bxg4f2a5 -Byg2f1a2 \
	-B+t"Bathymetric contour of the Kuril-Kamchatka Trench area" \
    -U -O -K >> $ps
# Step-6. Add scale, directional rose
gmt psbasemap -R -J \
    --FONT=8p,Palatino-Roman,dimgray \
    --MAP_TITLE_OFFSET=0.3c \
    -Tdg144/57.5+w0.5c+f2+l \
    -Lx5.1i/-0.5i+c50+w1000k+l"Conic equal-area Albers projection. Scale at 50\232N, km"+f \
    -O -K >> $ps
# Step-7. Study area
gmt psbasemap -R -J \
    -D144/40.2/162/51r -F+pthin,red \
    -O -K >> $ps
# Step-8. Study area label annotation
gmt psxy -R -J -Wthin -O -K \
    -Sqn1:+f12p,Times-Roman,red+l"Study Area"+c5p+pthick,red+o << EOF >> $ps
144.2 41.1
160.8 41.5
EOF
# Step-9. Add logo
gmt logo -R -J -Dx6.5/-2.2+o0.1i/0.1i+w2c -O -K >> $ps
# Step-10. Add text
gmt pstext -R0/8.5/0/11 -Jx1i -F+f7p,Helvetica,dimgray+jCB -N -O -K >> $ps << END
0.34 -0.5 Bathymetry: ETOPO 5 arc min Global Relief Model
END
gmt pstext -R -J -F+f7p,Helvetica,dimgray+jCB -N -O >> $ps << EOF
4.8 -0.7 Standard paralles at 45\232 and 55\232 N
EOF
# Step-11. Convert to image file using GhostScript
gmt psconvert GMT_JB_bathy_KKT.ps -A0.2c -E720 -Tj -Z
