WIDTH = 19;
HEIGHT = 19;
THICKNESS = 2.5;
CORNER_DIA = 5;

MOUNT_DIA = 4;

SLOT_WIDTH = 1.6;
SLOT_LENGTH = 7;
SLOT_GROOVE_THICKNESS = 1;

SLOT = true;

PASSTHROUGH_DIA = 5;

PASSTHROUGH = true;

$fn = 30;

module rounded_cube(width, height, thickness, corner_dia) {
    hull() {
        for(i = [-1, 1]) {
            for(j = [-1, 1]) {
                translate([i * (width - corner_dia)/2, j * (height - corner_dia)/2, 0])
                cylinder(d = corner_dia, h = thickness);
            }
        }
    }
}

module base() {
    rounded_cube(WIDTH, HEIGHT, THICKNESS, CORNER_DIA);
}

module mount_neg() {
    cylinder(d = MOUNT_DIA, h = THICKNESS);
}

module slot_neg() {
    union() {
        translate([-SLOT_WIDTH/2, -SLOT_LENGTH/2, 0])
        cube(size = [SLOT_WIDTH, SLOT_LENGTH, THICKNESS]);
        translate([-SLOT_WIDTH/2, -SLOT_LENGTH/2, 0])
        cube(size = [100000, SLOT_LENGTH, SLOT_GROOVE_THICKNESS]);
    }
}

module passthrough_neg() {
    union() {
        cylinder(d = PASSTHROUGH_DIA, h = THICKNESS);
        translate([-PASSTHROUGH_DIA/2, 0, 0])
        cube(size = [PASSTHROUGH_DIA, PASSTHROUGH_DIA, THICKNESS]);
    }
}

difference() {
    base();
    mount_neg();
    
    if(SLOT) {
        translate([HEIGHT/3, 0, 0])
        slot_neg();
    }
    
    if(PASSTHROUGH) {
        translate([0, (WIDTH-PASSTHROUGH_DIA)/2, 0])
        passthrough_neg();
    }
    
}