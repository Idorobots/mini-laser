PULLEY_MOUNT_DIA = 5.4;
PULLEY_SHAFT_LEN = 12;
PULLEY_SHAFT_DIA = 10;

$fn = 30;

module pulley_shaft_pos() {
    cylinder(d = PULLEY_SHAFT_DIA, h = PULLEY_SHAFT_LEN);
}

module pulley_shaft_neg() {
    cylinder(d = PULLEY_MOUNT_DIA, h = PULLEY_SHAFT_LEN);
}

difference() {
    pulley_shaft_pos();
    pulley_shaft_neg();
}