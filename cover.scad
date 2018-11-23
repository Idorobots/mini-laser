WIDTH = 95;
HEIGHT = 50;
THICKNESS = 2;
CORNER_DIA = 5;

MOUNT_DIA = 4;
MOUNT_HEIGHT = 40;
MOUNT_WIDTH = 85;

BUTTON_DIA = 10;
BUTTON_OFFSET_X = -30;
BUTTON_OFFSET_Y = -10;

BUTTON = true;

FAN_MOUNT_DIA = 3;
FAN_MOUNT_SPACING = 32;
FAN_DIA = 38;
FAN_OFFSET_X = 20;
FAN_OFFSET_Y = 0;

FAN = true;

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

module plate() {
    rounded_cube(WIDTH, HEIGHT, THICKNESS, CORNER_DIA);
}

module mount_neg() {
    union() {
        for(i = [-1, 1]) {
            for(j = [-1, 1]) {
                translate([i * MOUNT_WIDTH/2, j * MOUNT_HEIGHT/2, 0])
                cylinder(d = MOUNT_DIA, h = THICKNESS);
            }
        }
    }
}

module button_hole_neg() {
    cylinder(d = BUTTON_DIA, h = THICKNESS);
}

module fan_mount_neg() {
    union() {
        for(i = [-1, 1]) {
            for(j = [-1, 1]) {
                translate([i * FAN_MOUNT_SPACING/2, j * FAN_MOUNT_SPACING/2, 0])
                cylinder(d = FAN_MOUNT_DIA, h = THICKNESS);
            }
        }
        cylinder(d = FAN_DIA, h = THICKNESS);
    }
}

difference() {
    plate();
    mount_neg();
    if(BUTTON) {
        translate([BUTTON_OFFSET_X, BUTTON_OFFSET_Y, 0])
        button_hole_neg();
    }
    if(FAN) {
        translate([FAN_OFFSET_X, FAN_OFFSET_Y, 0])
        fan_mount_neg();
    }
}