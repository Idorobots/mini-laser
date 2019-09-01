WIDTH = 60;
HEIGHT = 70;
THICKNESS = 5;
CORNER_DIA = 10;

PLATE_MOUNT_HEIGHT = 12;
PLATE_MOUNT_DIA = 4;

MOUNT_DIA = 3;
MOUNT_HEIGHT_1 = 40;
MOUNT_WIDTH_1 = 16;
MOUNT_HEIGHT_2 = 60;
MOUNT_WIDTH_2 = 20;

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

module mounting_holes(dia, width, height, thickness, three = false, two = false) {
    union() {
        for(j = [-1, 1]) {
            for(i = (three && j == -1) || two ? [0] : [-1, 1]) {
                translate([i * width/2, j * height/2, 0])
                cylinder(d = dia, h = thickness);
            }
        }
    }
}

module plate() {
    rounded_cube(WIDTH, HEIGHT, THICKNESS, CORNER_DIA);
}

module mount_pos() {
    w = max(MOUNT_WIDTH_1, MOUNT_WIDTH_2)+MOUNT_DIA*2;
    rounded_cube(WIDTH, MOUNT_HEIGHT_1+MOUNT_DIA*2, THICKNESS, CORNER_DIA);

    rounded_cube(WIDTH, MOUNT_HEIGHT_2+MOUNT_DIA*2, THICKNESS, CORNER_DIA);
}

module mount_neg() {
    translate([0, abs(MOUNT_HEIGHT_1-MOUNT_HEIGHT_2)/3, 0])
    mounting_holes(MOUNT_DIA, MOUNT_WIDTH_1, MOUNT_HEIGHT_1, THICKNESS);

    translate([MOUNT_WIDTH_2/2, abs(MOUNT_HEIGHT_1-MOUNT_HEIGHT_2)/3, 0])
    mounting_holes(MOUNT_DIA, MOUNT_WIDTH_2, MOUNT_HEIGHT_1, THICKNESS);

    translate([-(WIDTH - CORNER_DIA)/2, 0, 0])
    mounting_holes(MOUNT_DIA, MOUNT_WIDTH_2, MOUNT_HEIGHT_2, THICKNESS, two = true);
}


module plate_mount_neg() {
    mounting_holes(PLATE_MOUNT_DIA, 0, PLATE_MOUNT_HEIGHT, THICKNESS, two = true);
}

difference() {
    union() {
        plate();
        mount_pos();
    }
    plate_mount_neg();
    mount_neg();
}