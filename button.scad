DIAMETER = 9.25;
HEIGHT = 15;
MOUNT_WIDTH = 2;
MOUNT_LENGTH = 3;
MOUNT_HEIGHT = 2.5;

$fn = 30;

difference() {
    cylinder(d = DIAMETER, h = HEIGHT);
    translate([-MOUNT_WIDTH/2, -MOUNT_LENGTH/2, 0])
    cube(size = [MOUNT_WIDTH, MOUNT_LENGTH, MOUNT_HEIGHT]);
}