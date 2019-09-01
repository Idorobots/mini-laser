// 0 - Pulley.
// 1 - Linear.
// 2 - Universal.
TYPE = 2;
THICKNESS = 5;
CORNER_DIA = 10;

PULLEY_MOUNT_WIDTH = 60;
PULLEY_MOUNT_HEIGHT = 37;
PULLEY_MOUNT_DIA = 5;

LINEAR_MOUNT_WIDTH = 20;
LINEAR_MOUNT_HEIGHT = 20;
LINEAR_MOUNT_DIA = 3;
LINEAR_BEARING_WIDTH = 27;
LINEAR_BEARING_HEIGHT = 45;

MOTOR_WIDTH = 42;
MOTOR_MOUNT_SPACING = 31;
MOTOR_MOUNT_DIA = 3;
MOTOR_SHAFT_DIA = 23;
MOTOR_OFFSET = (TYPE > 0) ? -(MOTOR_WIDTH+LINEAR_BEARING_WIDTH)/2 : -PULLEY_MOUNT_HEIGHT/2;

TOOL_MOUNT_WIDTH = 20;
TOOL_MOUNT_HEIGHT = 20;
TOOL_MOUNT_SPACING = 14;
TOOL_MOUNT_DIA = 4;
TOOL_MOUNT_OFFSET = (TYPE > 0) ? (TOOL_MOUNT_WIDTH+LINEAR_BEARING_WIDTH)/2 : PULLEY_MOUNT_HEIGHT/2;


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

module pulley_mount_pos() {
    w = PULLEY_MOUNT_WIDTH + 2*PULLEY_MOUNT_DIA;
    h = PULLEY_MOUNT_HEIGHT + 2*PULLEY_MOUNT_DIA;
    rounded_cube(w, h, THICKNESS, CORNER_DIA);
}

module pulley_mount_neg() {
    for(i = [-1, 1]) {
        for(j = [-1, 1]) {
            translate([i * PULLEY_MOUNT_WIDTH/2, j * PULLEY_MOUNT_HEIGHT/2, 0])
            cylinder(d = PULLEY_MOUNT_DIA, h = THICKNESS);
        }
    }   
}

module linear_mount_pos() {
    rounded_cube(LINEAR_BEARING_HEIGHT, LINEAR_BEARING_WIDTH, THICKNESS, CORNER_DIA);    
}

module linear_mount_neg() {
    for(i = [-1, 1]) {
        for(j = [-1, 1]) {
            translate([i * LINEAR_MOUNT_WIDTH/2, j * LINEAR_MOUNT_HEIGHT/2, 0])
            cylinder(d = LINEAR_MOUNT_DIA, h = THICKNESS);
            translate([i * LINEAR_MOUNT_WIDTH/2, j * LINEAR_MOUNT_HEIGHT/2, , THICKNESS/2])
            cylinder(d = LINEAR_MOUNT_DIA * 2, h = THICKNESS/2);
        }
    }
}

module tool_mount_pos() {
    rounded_cube(TOOL_MOUNT_HEIGHT, TOOL_MOUNT_WIDTH, THICKNESS, CORNER_DIA);
}

module tool_mount_neg() {
    union() {
        translate([0, TOOL_MOUNT_SPACING/2, 0])
        cylinder(d = TOOL_MOUNT_DIA, h = THICKNESS);

        cylinder(d = TOOL_MOUNT_DIA, h = THICKNESS);

        translate([0, -TOOL_MOUNT_SPACING/2, 0])
        cylinder(d = TOOL_MOUNT_DIA, h = THICKNESS);
    }
}


difference() {
    hull() {
        translate([0, MOTOR_OFFSET, 0])
        motor_mount_pos();
        if(TYPE != 1) pulley_mount_pos();
        if(TYPE > 0) linear_mount_pos();
        translate([0, TOOL_MOUNT_OFFSET, 0])
        tool_mount_pos();
    }
    translate([0, MOTOR_OFFSET, 0])
    motor_mount_neg();
    if(TYPE != 1) pulley_mount_neg();
    if(TYPE > 0) linear_mount_neg();
    translate([0, TOOL_MOUNT_OFFSET, 0])
    tool_mount_neg();
}