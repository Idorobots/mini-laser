WHEEL_INNER_DIA = 5;
WHEEL_OUTER_DIA = 24;
WHEEL_THICKNESS = 8; // 1 mm thicker than the actual wheel to accomodate washers.

PULLEY_SHAFT_LEN = 12;
PULLEY_SHAFT_DIA = 10;

SEGMENT_DIA = PULLEY_SHAFT_DIA;
SEGMENT_WIDTH = 2 * PULLEY_SHAFT_LEN + WHEEL_THICKNESS - 2; // 1 mm slimmer to accomodate washers.
SEGMENT_LENGTH = (WHEEL_OUTER_DIA + PULLEY_SHAFT_DIA)/2;
SEGMENT_MOUNT_DIA = 3;
SEGMENT_MOUNT_HEAD_DIA = 6;
SEGMENT_ANGLE = 30;

$fn = 50;

module wheel_neg() {
    difference() {
        cylinder(d = WHEEL_OUTER_DIA, h = WHEEL_THICKNESS, center = true);
        cylinder(d = WHEEL_INNER_DIA, h = WHEEL_THICKNESS, center = true);
    }
}

module segment_pos(length) {
    hull() {
        for(i = [-1, 1]) {
            translate([0, i * length/2, 0])
            cylinder(d = SEGMENT_DIA, h = SEGMENT_WIDTH, center = true);
        }
    }
}

module mounting_hole_neg(dia) {
    cylinder(d = dia, h = SEGMENT_WIDTH, center = true);
}

intersection() {
    difference() {
        union() {
            translate([0, -SEGMENT_LENGTH/2, 0])
            segment_pos(SEGMENT_LENGTH);

            rotate([0, 0, SEGMENT_ANGLE])
            translate([0, SEGMENT_LENGTH/2, 0])
            segment_pos(SEGMENT_LENGTH);
            
            translate([-sin(SEGMENT_ANGLE) * SEGMENT_LENGTH - SEGMENT_LENGTH/4, cos(SEGMENT_ANGLE) * SEGMENT_LENGTH, 0])
            rotate([0, 0, 90])
            segment_pos(SEGMENT_LENGTH/2);
        }
        // Wheel cutout
        translate([0, -SEGMENT_LENGTH, 0])
        wheel_neg();

        // Main shaft
        mounting_hole_neg(WHEEL_INNER_DIA);

        // Tensioner hole
        translate([-sin(SEGMENT_ANGLE) * SEGMENT_LENGTH - SEGMENT_LENGTH/2 * 0.66, cos(SEGMENT_ANGLE) * SEGMENT_LENGTH, 0])
        rotate([90, 0, 0])
        mounting_hole_neg(SEGMENT_MOUNT_DIA);

        // The thing that holds this together
        translate([-sin(SEGMENT_ANGLE) * SEGMENT_LENGTH, cos(SEGMENT_ANGLE)*SEGMENT_LENGTH, 0])
        mounting_hole_neg(SEGMENT_MOUNT_DIA);
        
        translate([-sin(SEGMENT_ANGLE) * SEGMENT_LENGTH, cos(SEGMENT_ANGLE)*SEGMENT_LENGTH, SEGMENT_WIDTH - SEGMENT_MOUNT_HEAD_DIA/2])
        mounting_hole_neg(SEGMENT_MOUNT_HEAD_DIA);
        
        translate([-sin(SEGMENT_ANGLE) * SEGMENT_LENGTH, cos(SEGMENT_ANGLE)*SEGMENT_LENGTH, -SEGMENT_WIDTH + SEGMENT_MOUNT_HEAD_DIA/2])
        mounting_hole_neg(SEGMENT_MOUNT_HEAD_DIA);
        
    }
    
    cylinder(d = SEGMENT_LENGTH*4, h = SEGMENT_WIDTH);
}