WIDTH = 65;
HEIGHT = 90;
THICKNESS = 5;
CORNER_DIA = 10;

MOTOR_MOUNT_SPACING = 31;
MOTOR_MOUNT_DIA = 3;
MOTOR_SHAFT_DIA = 23;

PULLEY_MOUNT_WIDTH = 55;
PULLEY_MOUNT_HEIGHT = 37;
PULLEY_MOUNT_DIA = 5;
PULLEY_SHAFT_LEN = 12;
PULLEY_SHAFT_DIA = 10;

BEAM_WIDTH = 20;
BEAM_SUPPORT_LEN = 20;
BEAM_SUPPORT_THICKNESS = 5;


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
    bw = BEAM_WIDTH + 2 * BEAM_SUPPORT_THICKNESS;
    hull() {
        rounded_cube(WIDTH, h, THICKNESS, CORNER_DIA);
        translate([0, (HEIGHT-PULLEY_MOUNT_HEIGHT), 0])
        rounded_cube(bw, bw, THICKNESS, CORNER_DIA);
    }   
}

module motor_mount_neg() {
    union() {
        for(i = [-1, 1]) {
            for(j = [-1, 1]) {
                translate([i * MOTOR_MOUNT_SPACING/2, j * MOTOR_MOUNT_SPACING/2, 0])
                cylinder(d = MOTOR_MOUNT_DIA, h = THICKNESS);
            }
        }
        cylinder(d = MOTOR_SHAFT_DIA, h = THICKNESS);
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

module beam_mount_pos() {
    bw = BEAM_WIDTH + 2 * BEAM_SUPPORT_THICKNESS;
    translate([0, (HEIGHT-PULLEY_MOUNT_HEIGHT), 0])
    rounded_cube(bw, bw, THICKNESS + BEAM_SUPPORT_LEN, CORNER_DIA);
}

module beam_mount_neg() {
    bw = BEAM_WIDTH;
    translate([-bw/2, HEIGHT-PULLEY_MOUNT_HEIGHT - bw/2, 0])
    cube(size = [bw, bw, THICKNESS + BEAM_SUPPORT_LEN]);    
}

difference() {
    union() {
        plate();
        pulley_mount_pos();
        beam_mount_pos();
    }
    translate([0, PULLEY_MOUNT_WIDTH/3, 0])
    motor_mount_neg();
    pulley_mount_neg();
    beam_mount_neg();
}