DIAMETER = 9.25;
HEIGHT = 15;
CAP_DIAMETER = 15;
CAP_HEIGHT = 4;
MOUNT_WIDTH = 2;
MOUNT_LENGTH = 3;
MOUNT_HEIGHT = 2.5;

$fn = 30;

difference() {
    union() {
        cylinder(d = DIAMETER, h = HEIGHT);
        translate([0, 0, HEIGHT-CAP_HEIGHT])
        cylinder(d = CAP_DIAMETER, h = CAP_HEIGHT);
    }
    translate([-MOUNT_WIDTH/2, -MOUNT_LENGTH/2, 0])
    cube(size = [MOUNT_WIDTH, MOUNT_LENGTH, MOUNT_HEIGHT]);
}
