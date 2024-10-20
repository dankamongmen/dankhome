/* Library of hex wall bits */
/* updated */
$fn = 128;

/* Constants relating to the insert part */
INSERT_MAIN_OUTER_AF_DISTANCE = 19.7;
INSERT_MAIN_INNER_AF_DISTANCE = 13.4;
INSERT_LIP_AF_DISTANCE = 22.5;
INSERT_MAIN_OUTER_DIAMETER = af_to_diameter(INSERT_MAIN_OUTER_AF_DISTANCE);
INSERT_MAIN_INNER_DIAMETER = af_to_diameter(INSERT_MAIN_INNER_AF_DISTANCE);
INSERT_LIP_DIAMETER = af_to_diameter(INSERT_LIP_AF_DISTANCE);
INSERT_TOTAL_HEIGHT = 10;
INSERT_LIP_HEIGHT = 2.5;
INSERT_LIP_PROTRUSION = (INSERT_LIP_AF_DISTANCE - INSERT_MAIN_OUTER_AF_DISTANCE)/2;

/* Constants relating to the honeycomb itself */
HEXAGON_WIDTH = 20;
HEX_WALL_THICKNESS = 3.6;
HEX_SEPARATION = HEXAGON_WIDTH + HEX_WALL_THICKNESS;
HORIZONTAL_HEX_SEPARATION = HEX_SEPARATION * 2 / sqrt(3) + af_to_diameter(HEXAGON_WIDTH + HEX_WALL_THICKNESS)/2;

/* Constants relating to the plug that can go into an empty insert */
PLUG_HEXAGON_DIAMETER = 14.7;
PLUG_AF_SIZE = PLUG_HEXAGON_DIAMETER * sqrt(3) / 2;
PLUG_LENGTH = 13;

DECORATION_OUTER_DIAMETER = 21.362;
DECORATION_INNER_DIAMETER = 19.053;
DECORATION_DEPTH = 0.3;
DECORATEION_FACET_HEIGHT = 0.35;

tiny_distance = .001;
maxInnerDiameter = 16.5;

cellAf = 23.6;
cellD = af_to_diameter(cellAf);

// insert_empty();
// insert_with_plate();
// insert_horizontal();
// hexagon_plug();
// hexagon_plug_horizontal();
// ^ this items has no decorations for compatibility

//insert(); 		// same as insert_with_plate(); but no cut hexagon underneeze
//insertEmpty(); 	// same as insert_empty();
//insertM2_5();
//insertM3();
//insertM4();
//insertM5();
//insertM6();
//insertM8();
//insertM10();
//insertAttachToWall(5, facetHeight = 1, bottomThickness = 1.5, translateHole = [2.5,-3.5], decorations=false);
//insertAttachToWallEmpty(3.5, facetHeight = 2, bottomThickness = 3, withLatch = false, decorations = true, supportless = true);
//hexagonPlug();
//hexagonPlugHorizontal();

//makeInsertHorizontal() insertEmpty(); // <- any insert 


/*
grid(changeCellOrder=false) {
	row(decorations = false) {
		insertAttachToWallEmpty(4, decorations=false, withLatch=true, facetHeight = 1.6);
		insertEmpty(decorations=false);
	}
	row(decorations = false) {
		insertEmpty(decorations=false);
		insertEmpty(decorations=false);
		insertEmpty(decorations=false);
	}
}
//*/

module insert_empty(tolerance = 0, inner_tolerance = 0) insertEmpty(tolerance, inner_tolerance, decorations=false);

module insert_with_plate(tolerance = 0, inner_tolerance = 0) { 
	difference() {
		insert(tolerance, decorations=false);
		cutHexagon(inner_tolerance, INSERT_LIP_HEIGHT);
	}
}

module insert_horizontal(tolerance = 0, inner_tolerance = 0) {
	makeInsertHorizontal(tolerance) insert_with_plate(tolerance);
}

module hexagon_plug(tolerance = 0) {
    cylinder(d=PLUG_HEXAGON_DIAMETER - tolerance*2, h=PLUG_LENGTH, $fn=6);
}

module hexagon_plug_horizontal(tolerance = 0) {
    translate([0, 0, PLUG_AF_SIZE/2 - tolerance])
        rotate([90, 0, 0]) 
			hexagon_plug(tolerance);
}

module insert(tolerance = 0, decorations = true) {
	$fn = 6;
    WALL_SIDE_GAP_START_HEIGHT = 6.5;
    WALL_SIDE_GAP_WIDTH = 1;
    WALL_TOP_GAP_WIDTH = 0.8;
    WALL_GAP_LENGTH = 8;
    WALL_TOP_GAP_RADIUS = 8.25;
    TAB_STICKS_OUT_BY = 0.5;
    TAB_LENGTH = 2;


	difference() {
		union() {
			for (i=[0:5]) {
					rotate([0, 0, i*60]) {
					translate([0, INSERT_MAIN_OUTER_AF_DISTANCE/2 - tolerance, 0]) {
						hull() {
							translate([0, 0, WALL_SIDE_GAP_START_HEIGHT + WALL_SIDE_GAP_WIDTH + TAB_STICKS_OUT_BY]) {
								rotate([0,90,0]){
									cylinder(r=TAB_STICKS_OUT_BY, h=TAB_LENGTH, center=true, $fn=20);
								}
							}
							translate([0, 0, INSERT_TOTAL_HEIGHT - tiny_distance]) {
								rotate([0, 90, 0]) {
									cylinder(r=tiny_distance, h=TAB_LENGTH, center=true, $fn=20);
								}
							}
						}
					}
				}
			}
			difference() {
				insertBase(tolerance, decorations);
				for (i=[0:5]) {
					rotate([0, 0, i*60]) {
						translate([-WALL_GAP_LENGTH/2, WALL_TOP_GAP_RADIUS - tolerance, WALL_SIDE_GAP_START_HEIGHT]) {
							cube([WALL_GAP_LENGTH, WALL_TOP_GAP_WIDTH, 10]);
						}
						translate([-WALL_GAP_LENGTH/2, WALL_TOP_GAP_RADIUS, WALL_SIDE_GAP_START_HEIGHT]) {
							cube([WALL_GAP_LENGTH, 10, WALL_SIDE_GAP_WIDTH]);
						}
					}
				}
			}
		}
		cutFacetBottom();
	}
}

module insertEmpty(tolerance = 0, inner_tolerance = 0, decorations = true) {
	difference() {
		insert(tolerance, decorations);
		cutHexagon(inner_tolerance);
	}
}

module insertM2_5(tolerance=0, decorations=true) insertMX(2.5, 5.77, tolerance=tolerance, decorations=decorations);
module insertM3(tolerance=0, decorations=true)   insertMX(3, 6.35, tolerance=tolerance, decorations=decorations);
module insertM4(tolerance=0, decorations=true)   insertMX(4, 8.08, tolerance=tolerance, decorations=decorations);
module insertM5(tolerance=0, decorations=true)   insertMX(5, 9.24, tolerance=tolerance, decorations=decorations);
module insertM6(tolerance=0, decorations=true)   insertMX(6, 11.55, tolerance=tolerance, decorations=decorations);
module insertM8(tolerance=0, decorations=true)   insertMX(8, 15.01, tolerance=tolerance, decorations=decorations);
module insertM10(tolerance=0, decorations=true)  insertMX(10, 17.32, tolerance=tolerance, decorations=decorations);

function calculateFacetDiameter(holeD, facetHeight) = facetHeight * 2 + holeD;

module insertAttachToWall(
	holeDiameter, 
	facetHeight = 0, 
	bottomThickness = 1.5, 
	tolerance = 0, 
	inner_tolerance = 0, 
	withLatch = false, // <- I think there is no need latch, but you can turn it on
	translateHole = [0,0], // <- if you drill hole not accurate, you can move it by [x, y],
	decorations = true
) {
	$fn=64;
	isTranslateHole = translateHole[0] != 0 || translateHole[1] != 0;
	spacer = 0.2;
	holeD = holeDiameter + spacer;
	outHoleDiameter = isTranslateHole ? maxInnerDiameter : holeD + 4;
	facetD = calculateFacetDiameter(holeD, facetHeight);

	difference() {
		if (withLatch)  
			insert(tolerance, decorations = decorations);
		 else  
			insertBase(tolerance, decorations = decorations);

		translate([0, 0, -bottomThickness]) cylinder(d = outHoleDiameter, h = INSERT_TOTAL_HEIGHT); 

		if (isTranslateHole) 
			translate([translateHole[0], translateHole[1], 0]) hole();
		else 
			hole();
	}

	module hole() {
		translate([0, 0, INSERT_TOTAL_HEIGHT - bottomThickness - 0.1]) cylinder(d1 = facetD, d2 = holeD, h = facetHeight + 0.1); 
		cylinder(d = holeD, INSERT_TOTAL_HEIGHT + 0.1); 
	}
}

module insertAttachToWallEmpty(
	holeDiameter, 
	facetHeight = 0, 
	bottomThickness = 2, 
	tolerance = 0, 
	inner_tolerance = 0, 
	withLatch = false, 
	decorations = true,
    supportless = false,
) {
    layerThickness = 0.2;

	difference() {
		insertAttachToWall(holeDiameter, facetHeight, bottomThickness, tolerance, inner_tolerance, withLatch, decorations = decorations);
		cutHexagon(inner_tolerance, -bottomThickness);
	}
    if (supportless) {
        translate([0, 0, INSERT_TOTAL_HEIGHT - bottomThickness]) 
            difference() {
                cylinder(d = PLUG_HEXAGON_DIAMETER * 1.1, h = layerThickness * 2, $fn = 6, center = true);  
                cube([PLUG_HEXAGON_DIAMETER + 1, calculateFacetDiameter(holeDiameter, facetHeight), layerThickness * 4], center = true);  
            }
        translate([0,0,INSERT_TOTAL_HEIGHT-bottomThickness]) 
            difference() {
                cylinder(d=PLUG_HEXAGON_DIAMETER * 1.1, h = layerThickness * 4, $fn = 6, center = true);  
                rotate(90, [0, 0, 1]) 
                    cube([PLUG_HEXAGON_DIAMETER + 1, calculateFacetDiameter(holeDiameter, facetHeight),layerThickness* 2 * 2 * 2], center = true);  
            }
    }
}

module hexagonPlug(tolerance=0, decorations=true) {
	if (decorations) {
		D = PLUG_HEXAGON_DIAMETER - tolerance*2;
		intersection() {
			cylinder(d=D, h=PLUG_LENGTH, $fn=6);
			translate([0,0,-0.75])
				cylinder(r1=PLUG_LENGTH + D/2, r2=0, h = PLUG_LENGTH + D/2, $fn=6); 
			translate([0,0,-D/2 + 0.75])
				cylinder(r2=PLUG_LENGTH + D/2, r1=0, h = PLUG_LENGTH + D/2, $fn=6); 
		}
	} else {
		cylinder(d=PLUG_HEXAGON_DIAMETER - tolerance*2, h=PLUG_LENGTH, $fn=6);
	}
}

module hexagonPlugHorizontal(tolerance=0, decorations=true) {
	translate([0,0, PLUG_AF_SIZE/2] )
	translate([0,0,-INSERT_MAIN_OUTER_AF_DISTANCE/2] )
	makeInsertHorizontal() hexagonPlug(tolerance, decorations);
}

module makeInsertHorizontal(tolerance=0) {
    large_distance=10;
    difference() {
        translate([0, 0, INSERT_MAIN_OUTER_AF_DISTANCE/2]) 
            rotate([90, 0, 0])
                children();
        translate([-large_distance, -INSERT_TOTAL_HEIGHT - 0.1, -large_distance + tolerance]) 
            cube([large_distance*2, INSERT_TOTAL_HEIGHT + 0.2, large_distance]);
    }
}

module grid(rows=[], changeCellOrder = false, maxRowLength = 10) {
	noRowsInfo = len(rows) == 0;
	upCutRowCount = noRowsInfo ? maxRowLength : rows[0];
	downCutRowCount = noRowsInfo ? maxRowLength : rows[len(rows)-1];
	
	assert( !(!noRowsInfo && len(rows) != $children), 
		"rows info if specified must describe all rows! Example: grid(rows=[1,2]) { row() { insert(); } row() { insert(); insert(); } }");

	difference() {
		for (i = [0:$children-1]) {
			tY = cellOffsetY(i, changeCellOrder);
			translate([(cellD - cellD / 4) * i, tY, 0]) children(i);
		}
		for (i = [0:$children-1]) {

			tY = cellOffsetY(i, changeCellOrder); 
			translate([(cellD - cellD / 4) * i, tY  - cellAf, 0]) connectorCutting();

			if (!noRowsInfo) {
				itemsInRow = rows[i];
				for (k=[0:maxRowLength-1]){
					translate([(cellD - cellD / 4) * i, tY  + (k + itemsInRow) * cellAf, 0]) connectorCutting();
				}
			}
		}

		tYUp = cellOffsetY($children, changeCellOrder);
		translate([(cellD - cellD / 4) * $children, -tYUp, 0]){
			for (j=[0:downCutRowCount-1]) {
				translate([0, cellAf * j, 0]) connectorCutting();
			}
		}
		tYDown = cellOffsetY(-1, changeCellOrder);
		translate([-(cellD - cellD / 4), -tYDown, 0])
			for (k=[0:upCutRowCount-1]) {
				translate([0, cellAf * k, 0]) connectorCutting();
			}
	}
}

module row(connections=true, decorations = true) {
	if ($children > 0) {
		difference() {
			for (i = [0:$children-1]) 
				translate([0, cellAf * i, 0]) {
					if (connections) connector(false, decorations);
					children(i);
				}
			translate([(cellD - cellD / 4) , cellAf * $children - cellAf/2, 0]) connectorCutting();
			translate([0, cellAf * $children, 0]) connectorCutting();
			translate([-(cellD - cellD / 4) , cellAf * $children - cellAf/2, 0]) connectorCutting();
		}
	}
}

// utils modules section ----------------------------------------------------

module insertBase(tolerance=0, decorations=true) {
    $fn = 6;
    difference() {
        union() {
            cylinder(d=INSERT_MAIN_OUTER_DIAMETER-tolerance*2, h=INSERT_TOTAL_HEIGHT);
            cylinder(d=INSERT_LIP_DIAMETER, h=INSERT_LIP_HEIGHT);
        }
		if (decorations) {
			translate([0,0,-0.1])
				union() {
					difference() {
						cylinder(d = DECORATION_OUTER_DIAMETER, h = DECORATION_DEPTH + 0.1);
						cylinder(d = DECORATION_INNER_DIAMETER, h = DECORATION_DEPTH + 0.1);
					}
				}

			translate([0,0,DECORATEION_FACET_HEIGHT]) cutFacet(INSERT_LIP_DIAMETER, inverse=true);
		}
        translate([0,0,INSERT_LIP_HEIGHT])
        rotate(90,[0,0,1])
        difference() {
            cylinder(d=INSERT_MAIN_OUTER_DIAMETER*2, h=INSERT_TOTAL_HEIGHT);
            cylinder(d=af_to_diameter(INSERT_MAIN_OUTER_DIAMETER-tolerance*2) - 0.12 * 2, h=INSERT_TOTAL_HEIGHT);
        }
        cutFacetBottom();
    }
}

module cutFacet(diameter, inverse=false) {
	h = diameter / 2 * tan(45);
	z = inverse ? -h : 0;
	translate([0,0,z])
		difference() {
			cylinder(d=diameter*2, h = h);
			if (inverse)
				cylinder(d2=diameter, d1=0, h = h);
			else
				cylinder(d1=diameter, d2=0, h = h);
		}
}

module cutFacetBottom() {
	translate([0,0,INSERT_TOTAL_HEIGHT-DECORATEION_FACET_HEIGHT])
		cutFacet(INSERT_MAIN_OUTER_DIAMETER);
}

module cutHexagon(inner_tolerance, indent = 0) {
	// remove preview artifacts
	z = indent == 0 ? -0.5 : indent;
	addH = indent == 0 ? 1 : 0;
	translate([0,0,z]) 
		cylinder(d=INSERT_MAIN_INNER_DIAMETER + inner_tolerance*2, h=INSERT_TOTAL_HEIGHT + addH, $fn=6);
}

module insertMX(diameter,  nutWidth, tolerance = 0, decorations = true) {
	spacer = 0.2;
	holeD = min(maxInnerDiameter, diameter + spacer);
	facet = holeD / 8;
	facetH = 0.3;
	nutW = min(maxInnerDiameter, nutWidth + spacer);
	aboveNutW = min(maxInnerDiameter, nutW + 6);

	difference() {
		insert(tolerance, decorations = decorations);
		translate([0,0,-0.1]) // remove preview artifacts
			cylinder(d1 = holeD + facet * 2, d2 = holeD, h = facetH + 0.1);
		cylinder(d = holeD, h = INSERT_TOTAL_HEIGHT);
		translate([0, 0, 4])
		cylinder(d = nutW, h = INSERT_TOTAL_HEIGHT, $fn=6);
		translate([0, 0, 7])
		cylinder(d = aboveNutW, h = INSERT_TOTAL_HEIGHT + 0.1, $fn=6);
	}
}

module connector(forCutting=false, decorations = true) {
	connectorW = (cellAf-INSERT_LIP_AF_DISTANCE);
	connectorH = decorations ? INSERT_LIP_HEIGHT - DECORATEION_FACET_HEIGHT : INSERT_LIP_HEIGHT;
	connectorL = INSERT_LIP_DIAMETER/2;
	cuttingTranslateZ = forCutting ? -2 : 0;
	cuttingScaleZ = forCutting ? 2 : 1;

	translate([0,0,cuttingTranslateZ])
		scale([1,1,cuttingScaleZ]) 
			for (a=[0:60:300])
			rotate(a,[0,0,1])
				translate([-connectorL/2, -INSERT_LIP_AF_DISTANCE/2 - connectorW, decorations ? DECORATEION_FACET_HEIGHT : 0]) {
				points = [
					[0, addCutting(connectorW)],
					[connectorL, addCutting(connectorW)],
					[connectorL, 0],
					[0, 0],
					[-(connectorW*sin(60)), connectorW/2]
				];
				linear_extrude(height = connectorH) polygon(points);
			}

	function addCutting(value) = forCutting ? value + 0.1 : value;
}

module connectorCutting() connector(true, true);
function cellOrder(i, change) = change ? i % 2 == 0 : i % 2 != 0;
function cellOffsetY(i, change) = cellOrder(i, change) ? 0 : cellAf / 2;

/* converts an 'across flats' dimension to a maximum diameter — useful for openScad */
function af_to_diameter(af) = af / sqrt(3) * 2;
function diameter_to_af(diameter) = diameter * sqrt(3) / 2;

