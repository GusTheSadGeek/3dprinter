use <vslot/vslot.scad>;
use <components.scad>;


module vslot_test() {
	$fn = 32;

	vslot20x20(100);

	translate([0, 40, 0])
	vslot20x40(100, vslot_color_black);

	translate([0, 80, 0])    
	vslot20x60(100);

	translate([0, 120, 0])
	vslot20x80(100, vslot_color_black);
}


$fn = 32;
module base(){
    translate([-225,250,10]) rotate([90,0,0]) vslot20x20(500);
    translate([+225,250,10]) rotate([90,0,0]) vslot20x20(500);
    
    translate([-225,250,10]) rotate([90,0,90]) vslot20x20(450);
    translate([-225,-250,10]) rotate([90,0,90]) vslot20x20(450);
}

base();
translate([0,0,400]) base();
translate([-225,-250,0]) vslot20x20(400);
translate([-225,+250,0]) vslot20x20(400);
translate([+225,-250,0]) vslot20x20(400);
translate([+225,+250,0]) vslot20x20(400);

cube([400,400,4],true);


