THICKNESS = 5;

BELT_MOUNT_HOLE_SPACING_X = 5; // 10; // 10;
BELT_MOUNT_HOLE_SPACING_Y = 10; // 5; // 5;
BELT_MOUNT_HOLE_DIA = 4;

FRAME_MOUNT_HOLE_SPACING_X = 31; // 0; // 36;
FRAME_MOUNT_HOLE_SPACING_Y = 0; // 20; // 0;
FRAME_MOUNT_HOLE_DIA = 4; // 4; // 5;

MOUNT_SPACING = 25; // 30; // 25;

$fn = 50;

module mount_holes(dia, spacing_x, spacing_y) {
    for(i = [-1, 1]) {
        for(j = [-1, 1]) {
            translate([i * spacing_x/2, j * spacing_y/2, 0])
            cylinder(d = dia, h = THICKNESS);            
        }
    }
}

difference() {
    hull() {
        translate([0, MOUNT_SPACING/2, 0])
        mount_holes(BELT_MOUNT_HOLE_DIA + 2 * THICKNESS, BELT_MOUNT_HOLE_SPACING_X, BELT_MOUNT_HOLE_SPACING_Y);
        translate([0, -MOUNT_SPACING/2, 0])
        mount_holes(FRAME_MOUNT_HOLE_DIA + 2 * THICKNESS, FRAME_MOUNT_HOLE_SPACING_X, FRAME_MOUNT_HOLE_SPACING_Y);
    }
    translate([0, MOUNT_SPACING/2, 0])
    mount_holes(BELT_MOUNT_HOLE_DIA, BELT_MOUNT_HOLE_SPACING_X, BELT_MOUNT_HOLE_SPACING_Y);
    translate([0, -MOUNT_SPACING/2, 0])
    mount_holes(FRAME_MOUNT_HOLE_DIA, FRAME_MOUNT_HOLE_SPACING_X, FRAME_MOUNT_HOLE_SPACING_Y);
}