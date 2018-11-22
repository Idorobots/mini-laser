WIDTH = 65;
HEIGHT = 90;
THICKNESS = 5;
CORNER_DIA = 10;

PULLEY_MOUNT_WIDTH = 55;
PULLEY_MOUNT_HEIGHT = 37.5;
PULLEY_MOUNT_DIA = 5;
PULLEY_SHAFT_LEN = 12;
PULLEY_SHAFT_DIA = 10;
PULLEY_MOTOR_OFFSET = PULLEY_MOUNT_HEIGHT/2;

MOUNT_DIA = 4;
MOUNT_HEIGHT = 20;
MOUNT_WIDTH = 20;

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
    h = PULLEY_MOUNT_HEIGHT+PULLEY_SHAFT_DIA;
    hull() {
        rounded_cube(WIDTH, h, THICKNESS, CORNER_DIA);
    }   
}

module mount_pos() {
    w = MOUNT_WIDTH+MOUNT_DIA*2;
    h = MOUNT_HEIGHT+MOUNT_DIA*2;
    rounded_cube(w, h, THICKNESS, CORNER_DIA);
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

module pulley_mount_pos() {
    for(i = [-1, 1]) {
        for(j = [-1, 1]) {
            translate([i * PULLEY_MOUNT_WIDTH/2, j * PULLEY_MOUNT_HEIGHT/2, 0])
            cylinder(d = PULLEY_SHAFT_DIA, h = PULLEY_SHAFT_LEN + THICKNESS);
        }
    }
}

module pulley_mount_neg() {
    for(i = [-1, 1]) {
        for(j = [-1, 1]) {
            translate([i * PULLEY_MOUNT_WIDTH/2, j * PULLEY_MOUNT_HEIGHT/2, 0])
            cylinder(d = PULLEY_MOUNT_DIA, h = PULLEY_SHAFT_LEN + THICKNESS);
        }
    }   
}


difference() {
    union() {
        plate();
        pulley_mount_pos();
        mount_pos();
    }
    pulley_mount_neg();
    mount_neg();
}