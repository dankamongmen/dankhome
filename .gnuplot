set encoding utf8
set macros

# Need pngcairo rather than default libgd png for antialiasing
png="set terminal pngcairo enhanced font"

# some new shit 2025-05-09 from https://stackoverflow.com/questions/41602351/how-to-make-gnuplot-charts-look-more-visually-appealing

# See https://github.com/Gnuplotting/gnuplot-palettes
# Line styles (colorbrewer Set1)
set style line 1 lc rgb '#E41A1C' pt 1 ps 1 lt 1 lw 2 # red
set style line 2 lc rgb '#377EB8' pt 6 ps 1 lt 1 lw 2 # blue
set style line 3 lc rgb '#4DAF4A' pt 2 ps 1 lt 1 lw 2 # green
set style line 4 lc rgb '#984EA3' pt 3 ps 1 lt 1 lw 2 # purple
set style line 5 lc rgb '#FF7F00' pt 4 ps 1 lt 1 lw 2 # orange
set style line 6 lc rgb '#FFFF33' pt 5 ps 1 lt 1 lw 2 # yellow
set style line 7 lc rgb '#A65628' pt 7 ps 1 lt 1 lw 2 # brown
set style line 8 lc rgb '#F781BF' pt 8 ps 1 lt 1 lw 2 # pink
# Palette
set palette maxcolors 8
set palette defined ( 0 '#E41A1C', 1 '#377EB8', 2 '#4DAF4A', 3 '#984EA3',\
4 '#FF7F00', 5 '#FFFF33', 6 '#A65628', 7 '#F781BF' )

# Standard border
set style line 11 lc rgb '#808080' lt 1 lw 3
set border 0 back ls 11
set tics out nomirror

# Standard grid
set style line 12 lc rgb '#808080' lt 0 lw 1
set grid back ls 12
unset grid

# a likely-futile attempt to make things less ugly 2017-05-27

# Replace small stripes on the Y-axis with a horizontal gridlines
set tic scale 0
set grid ytics

# Remove border around chart
unset border

# Show human-readable axes, e.g. 100k instead of 100000
#set format '%.0s%c'

# set default point size
set pointsize "1.2"

# variables used later
my_line_width = "2"

# Colorscheme taken from http://labs.guidolin.net/2010/03/how-to-create-beautiful-gnuplot-graphs.html
# Palette URL: http://colorschemedesigner.com/#3K40zsOsOK-K-
red_000 = "#F9B7B0"
red_025 = "#F97A6D"
red_050 = "#E62B17"
red_075 = "#8F463F"
red_100 = "#6D0D03"

blue_000 = "#A9BDE6"
blue_025 = "#7297E6"
blue_050 = "#1D4599"
blue_075 = "#2F3F60"
blue_100 = "#031A49" 

green_000 = "#A6EBB5"
green_025 = "#67EB84"
green_050 = "#11AD34"
green_075 = "#2F6C3D"
green_100 = "#025214"

brown_000 = "#F9E0B0"
brown_025 = "#F9C96D"
brown_050 = "#E69F17"
brown_075 = "#8F743F"
brown_100 = "#6D4903"

set style line 1 linecolor rgbcolor blue_025 linewidth @my_line_width pt 7
set style line 2 linecolor rgbcolor green_025 linewidth @my_line_width pt 5
set style line 3 linecolor rgbcolor red_025 linewidth @my_line_width pt 9
set style line 4 linecolor rgbcolor brown_025 linewidth @my_line_width pt 13
set style line 5 linecolor rgbcolor blue_050 linewidth @my_line_width pt 11
set style line 6 linecolor rgbcolor green_050 linewidth @my_line_width pt 7
set style line 7 linecolor rgbcolor red_050 linewidth @my_line_width pt 5
set style line 8 linecolor rgbcolor brown_050 linewidth @my_line_width pt 9
set style line 9 linecolor rgbcolor blue_075 linewidth @my_line_width pt 13
set style line 10 linecolor rgbcolor green_075 linewidth @my_line_width pt 11
set style line 11 linecolor rgbcolor red_075 linewidth @my_line_width pt 7
set style line 12 linecolor rgbcolor brown_075 linewidth @my_line_width pt 5
set style line 13 linecolor rgbcolor blue_100 linewidth @my_line_width pt 9
set style line 14 linecolor rgbcolor green_100 linewidth @my_line_width pt 13
set style line 15 linecolor rgbcolor red_100 linewidth @my_line_width pt 11
set style line 16 linecolor rgbcolor brown_100 linewidth @my_line_width pt 7
set style line 17 linecolor rgbcolor "#224499" linewidth @my_line_width pt 5

# set key options
set key outside box width 2 height 2 enhanced spacing 2
