WIDTH = 12;
LENGTH = 50;
HEIGHT = 10;
ANGLE = 100;

GUIDE_WIDTH = 8;
GUIDE_HEIGHT = 8;

NOTCH_ANGLE = 40;
NOTCH_WIDTH = 5;
NOTCH_DEPTH = 0.5;


$fn = 50;

module guide() {
    d = (360*LENGTH)/(PI*ANGLE);
    difference() {
        cylinder(d = d + WIDTH, h = HEIGHT);
        cylinder(d = d - WIDTH, h = HEIGHT);
        translate([0, 0, HEIGHT-GUIDE_HEIGHT])
        difference() {
            cylinder(d = d + GUIDE_WIDTH, h = GUIDE_HEIGHT);
            cylinder(d = d - GUIDE_WIDTH, h = GUIDE_HEIGHT);
        }
        
        for(i = [0:360/NOTCH_ANGLE]) {
            rotate([0, 0, i * NOTCH_ANGLE])
            union() {
                translate([-NOTCH_WIDTH/2, 0, 0])
                cube(size = [NOTCH_WIDTH, d, NOTCH_DEPTH]);
                translate([-NOTCH_WIDTH/2, 0, HEIGHT-NOTCH_DEPTH])
                cube(size = [NOTCH_WIDTH, d, NOTCH_DEPTH]);
            }
        }
    }
}

module arc() {
    d = (360*LENGTH)/(PI*ANGLE);
    intersection() {
        difference() {
            guide();

            if(ANGLE < 90) {
                rotate([0, 0, -90])
                cube(size = [d, d, HEIGHT]);
            }
        }
        union() {
            for(i = [0:(ANGLE/90)-1]) {
                rotate([0, 0, i * 90])
                cube(size = [d, d, HEIGHT]);
            }
            if(ANGLE >= 90) {
                rotate([0, 0, ANGLE % 90])
                cube(size = [d, d, HEIGHT]);
            }
        }
    }
}

arc();