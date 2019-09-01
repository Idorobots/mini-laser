TOP_WIDTH = 40;
BOT_WIDTH = 20;
HEIGHT = 80;
THICKNESS = 5;
CORNER_DIA = 10;

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
    hull() {
        rounded_cube(TOP_WIDTH, TOP_WIDTH, THICKNESS, CORNER_DIA);
        translate([BOT_WIDTH/2, -(HEIGHT - 1.5*BOT_WIDTH), 0])
        rounded_cube(BOT_WIDTH, BOT_WIDTH, THICKNESS, CORNER_DIA);
    }
}

module mount_neg() {
    union() {
        for(j = [-5, -3, -1, 1]) {
            translate([MOUNT_WIDTH/2, j * MOUNT_HEIGHT/2, 0])
            cylinder(d = MOUNT_DIA, h = THICKNESS);
        }
        for(j = [-1, 1]) {
            translate([-MOUNT_WIDTH/2, j * MOUNT_HEIGHT/2, 0])
            cylinder(d = MOUNT_DIA, h = THICKNESS);
        }
    }
}

difference() {
    plate();
    mount_neg();
}