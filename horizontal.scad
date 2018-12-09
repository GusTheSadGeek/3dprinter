include <globals.scad>;

use <vslot/vslot.scad>;
use <vslot/ob_wheel.scad>;
use <chassis.scad>;
use <vertical.scad>;

use <cornerBracket.scad>;
use <components.scad>;
use <pulley_wheels.scad>;
use <angle.scad>;


module linear_slider(){
  l=44;
  w=27;
  h=10;
  difference(){
    cube([w,l,h]);
  }
}


module linear_rail(l=550, p=100){
  w=12;
  h=8;
  rotate([0,0,270]) {
    translate([-8,p,3]) color("grey") linear_slider();
    color("green") difference()  {
      cube([w,l,h]);
      translate([-0.5,-0.5,h-2.5])  cube([1,l+1,1]);
      translate([w-0.5,-0.5,h-2.5]) cube([1,l+1,1]);
      l1=l-0.001;
      s=(l-floor(l1/22)*22)/2.0;
      for(q=[s:22:l]){
        translate([w/2,q,0]) cylinder(20,3,3);
      }
    }
  }
}


module top_plate(){
  *translate([0,0,0]) cube([ChassisX,40,2]);
  *translate([0,ChassisY-40,0]) cube([ChassisX,40,2]);

  p = ($t>0.5) ?  (1-$t)*(ChassisX-44)*2 : $t*(ChassisX-44)*2;

  q = ($t>0.5) ?  (1-$t)*(ChassisY-44)*2 : $t*(ChassisY-44)*2;

   translate([0,16,0]) rotate([0,0,0]) linear_rail(l=ChassisX, p=p);
   translate([0,ChassisY-4,0]) rotate([0,0,0]) linear_rail(l=ChassisX, p=p);

   translate([p+16,0,20]) rotate([0,0,90]) linear_rail(l=ChassisY, p=q);

}


module horizontal_assy(){
  translate([0,0,ChassisH]){
    top_plate();
  }
}




union(){
  $DETAIL = D_LOW;

  color("grey", 0.05) chassis($DETAIL=D_LOW,$fn=1, x,y,h);
*  colour("blue",0.1) translate([(x-400)/2,(y-300)/2,200]) cube([400,300,3]);
  color("grey", 0.05) vertical_assy3($fn=1);

  horizontal_assy($DETAIL = D_HIGH,$fn=40);
}
