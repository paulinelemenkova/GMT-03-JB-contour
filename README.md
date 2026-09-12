# GMT JB Contour — Bathymetric Contour Maps of Ocean Trenches

GMT (Generic Mapping Tools) shell scripts producing bathymetric contour (isobath) maps of ocean-trench regions. Relief grids are rendered as line contours with annotated index isobaths on an Albers equal-area conic projection, framed with a study-area outline. The scripts have been used to generate figures in the author's marine-geomorphological and cartographic publications.

## What the scripts do

- clip a regional subset from a global relief grid (grdcut) and report its range (grdinfo)
- draw bathymetric contours with a contour interval and annotated index contours (grdcontour -C -A -T)
- render in an Albers equal-area conic projection (-JB) with standard parallels
- add title, grid, scale bar and directional rose (psbasemap)
- outline and label the study area (psbasemap -D, psxy -Sq)
- add data-source annotations and the GMT logo (pstext, logo)
- export to raster (psconvert) at high resolution

## Data source

Global relief / bathymetry: ETOPO (5 arc-minute), via GMT earth_relief tiles.

## File naming

Scripts follow GMT-03-JB-bathy-XX.sh, where XX is an ocean-trench tag (e.g. KKT = Kuril-Kamchatka Trench, AT = Aleutian Trench, MAT = Middle America Trench, TKT).

## Requirements

- GMT 6.x (Generic Mapping Tools): https://www.generic-mapping-tools.org
- A POSIX shell (bash/sh)
- An ETOPO / earth_relief grid available locally

## Usage

Adjust the -R region and -J projection at the top of the chosen script, then run:

    bash GMT-03-JB-bathy-KKT.sh

The script writes a PostScript file and converts it to a raster image (JPG/PNG) via psconvert.

## Author and citation

Polina Lemenkova
ORCID: https://orcid.org/0000-0002-5759-1089

These scripts support figures in the author's marine-geomorphological and cartographic papers; please cite the specific article a given figure appears in. The full publication list is available via the ORCID record above.

## License

See the LICENSE file in this repository.
