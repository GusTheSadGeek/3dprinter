include <globals.scad>;

use <vslot/vslot.scad>;
use <vslot/ob_wheel.scad>;
use <chassis.scad>;
use <vertical.scad>;

use <cornerBracket.scad>;
use <components.scad>;
use <pulley_wheels.scad>;
use <angle.scad>;


module belts(){
  Z=12;
  X=ChassisX;
  Y=ChassisY;
  C=20;
  Q=12;
  q=6;

  A=YPos;
  B=GantryPos;

  //B=50;

  color("red"){
     translate([B+C-q,Q,1]) belt(A,r=90);
     translate([B+C,Q,0])   smooth_idler_5mm();
     translate([X,q,1])       belt(X-B-C,r=180);
     translate([0,0,0])       toothed_idler_5mm();
     translate([0,-q,1])      belt(X,r=0);

     translate([X,0,0])       toothed_idler_5mm();
     translate([-q,Y,1])      belt(Y,r=270);
     translate([0,Y,0])       toothed_idler_5mm();
     translate([B-C,Y+q,1]) belt(B-C,r=180);
     translate([B-C,Y,0])   toothed_idler_5mm();
     translate([B-C+q,A+30,1]) belt(Y-A-30,r=90);
  }



  color("yellow"){
     translate([B+C-q,A-Q+42,Z+1])   belt(Y-A-42,r=90);
     translate([B+C,Y-Q,Z])  smooth_idler_5mm();
     translate([B+C+q-q,Y-q,Z+1])   belt(X-B-C,r=0);

     translate([0,0,Z])         toothed_idler_5mm();
     translate([X+q-q,Y+q,Z+1])   belt(X,r=180);

     translate([X,Y,Z])  toothed_idler_5mm();
     translate([-q,Y,Z+1])      belt(Y,r=270);
     translate([0,Y,Z])  toothed_idler_5mm();

     translate([q-q,-q,Z+1])   belt(B-C,r=0);

     translate([B-C,0,Z])  toothed_idler_5mm();

     translate([B-C+q,0,Z+1])   belt(A+12,r=90);
  }

}

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
        translate([w/2,q,-0.1]) cylinder(20,3,3);
      }
    }
  }
}


module top_plate(){
  *translate([0,0,0]) cube([ChassisX,40,2]);
  *translate([0,ChassisY-40,0]) cube([ChassisX,40,2]);

//  p = ($t>0.5) ?  (1-$t)*(ChassisX-44)*2 : $t*(ChassisX-44)*2;
//  q = ($t>0.5) ?  (1-$t)*(ChassisY-44)*2 : $t*(ChassisY-44)*2;
  q = YPos;
  p=GantryPos - 22;

   translate([0,16,0]) rotate([0,0,0]) linear_rail(l=ChassisX, p=p);
   translate([0,ChassisY-4,0]) rotate([0,0,0]) linear_rail(l=ChassisX, p=p);

   translate([p+16,0,12]) rotate([0,0,90]) linear_rail(l=ChassisY, p=q);

}


module horizontal_assy(){
  translate([0,0,ChassisH]){
    top_plate();
  }
  translate([0,0,ChassisH+24]) belts();
}




union(){
  $DETAIL = D_LOW;

  color("grey", 0.05) chassis($DETAIL=D_LOW,$fn=1, x,y,h);
  color("grey", 0.05) vertical_assy3($fn=1);
 *toothed_20teeth_8mm();

  horizontal_assy($DETAIL = D_HIGH,$fn=40);


*  translate([-10,-10,-10]) belt(len=100);
}
