WIDTH = 70;
HEIGHT = 65;
THICKNESS = 5;
CORNER_DIA = 10;

PULLEY_MOUNT_WIDTH = 60;
PULLEY_MOUNT_HEIGHT = 37;
PULLEY_MOUNT_DIA = 5;

MOUNT_DIA = 3;
MOUNT_HEIGHT = 40;
MOUNT_WIDTH = 16;

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

module mounting_holes(dia, width, height, thickness, three = false) {
    union() {
        for(j = [-1, 1]) {
            for(i = (three && j == -1) ? [0] : [-1, 1]) {
                translate([i * width/2, j * height/2, 0])
                cylinder(d = dia, h = thickness);
            }
        }
    }
}

module plate() {
    h = PULLEY_MOUNT_HEIGHT + 2*PULLEY_MOUNT_DIA;
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
    mounting_holes(MOUNT_DIA, MOUNT_WIDTH, MOUNT_HEIGHT, THICKNESS, false);
}


module pulley_mount_neg() {
    mounting_holes(PULLEY_MOUNT_DIA, PULLEY_MOUNT_WIDTH, PULLEY_MOUNT_HEIGHT, THICKNESS);
}

difference() {
    union() {
        plate();
        mount_pos();
    }
    pulley_mount_neg();
    mount_neg();
}