WIDTH = 70;
HEIGHT = 65;
THICKNESS = 5;
CORNER_DIA = 10;

MOTOR_WIDTH = 42;
MOTOR_MOUNT_SPACING = 31;
MOTOR_MOUNT_DIA = 3;
MOTOR_SHAFT_DIA = 23;

PULLEY_MOUNT_WIDTH = 60;
PULLEY_MOUNT_HEIGHT = 37;
PULLEY_MOUNT_DIA = 5;
PULLEY_MOTOR_OFFSET = -PULLEY_MOUNT_HEIGHT/2;

BEAM_WIDTH = 20;
BEAM_SUPPORT_LEN = 15;
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
    h = PULLEY_MOUNT_HEIGHT + 2*PULLEY_MOUNT_DIA;
    bw = BEAM_WIDTH + 2 * BEAM_SUPPORT_THICKNESS;
    hull() {
        rounded_cube(WIDTH, h, THICKNESS, CORNER_DIA);
        translate([0, (HEIGHT-PULLEY_MOUNT_HEIGHT), 0])
        rounded_cube(bw, bw, THICKNESS, CORNER_DIA);
        translate([0, PULLEY_MOTOR_OFFSET, 0])
        rounded_cube(MOTOR_WIDTH, MOTOR_WIDTH, THICKNESS, CORNER_DIA);
    }   
}

module motor_mount_pos() {
    rounded_cube(MOTOR_WIDTH, MOTOR_WIDTH, THICKNESS, CORNER_DIA);
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

module pulley_mount_neg() {
    for(i = [-1, 1]) {
        for(j = [-1, 1]) {
            translate([i * PULLEY_MOUNT_WIDTH/2, j * PULLEY_MOUNT_HEIGHT/2, 0])
            cylinder(d = PULLEY_MOUNT_DIA, h = THICKNESS);
        }
    }   
}

module beam_mount_pos() {
    bw = BEAM_WIDTH + 2 * BEAM_SUPPORT_THICKNESS;
    rounded_cube(bw, bw, THICKNESS + BEAM_SUPPORT_LEN, CORNER_DIA);
}

module beam_mount_neg() {
    bw = BEAM_WIDTH;
    translate([-bw/2, -bw/2, 0])
    cube(size = [bw, bw, THICKNESS + BEAM_SUPPORT_LEN]);    
}

difference() {
    union() {
        plate();
        translate([0, PULLEY_MOTOR_OFFSET, 0])
        motor_mount_pos();
        translate([0, (HEIGHT-PULLEY_MOUNT_HEIGHT), 0])
        beam_mount_pos();
    }
    translate([0, PULLEY_MOTOR_OFFSET, 0])
    motor_mount_neg();
    pulley_mount_neg();
    translate([0, (HEIGHT-PULLEY_MOUNT_HEIGHT), 0])
    beam_mount_neg();
}