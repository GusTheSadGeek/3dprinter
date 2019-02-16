include <globals.scad>;

use <vslot/vslot.scad>;
use <vslot/ob_wheel.scad>;
use <chassis.scad>;
use <vertical.scad>;

use <cornerBracket.scad>;
use <components.scad>;
use <pulley_wheels.scad>;
use <angle.scad>;

Q=40;
hwd=30;
HW=ChassisY-hwd*2;

YTUBE=14;
YTUBEBEARING=16;

XTUBE=12;
XTUBEBEARING=14;


module vtube(x,y,t){
  difference(){
    color("green") cylinder(y,x/2,x/2);
    translate([0,0,-0.01]) cylinder(y+0.02,x/2-t,x/2-t);
  }
}

module htube(x,y,t){
  rotate([0,90,0]) vtube(x,y,t);
}



module belts(){
  Z=40;  // Verticle belt separation
  X=ChassisX-20;
  Y=HW;
  C=6;  // Distance from centre of XCarrage
  Q=12;
  q=6;

  A=YPos;
  B=GantryPos-10;

  //B=50;
  translate([10,0,0]){
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

XCAP_WIDTH=34;
XCAP_DEPTH=19;
XCAP_CUTTOUTWIDTH = XCAP_DEPTH-4;

module XCcapCuttout(){
  // Screw Cuttout
  translate([3,XCAP_CUTTOUTWIDTH/4,-20]) cylinder($fn=50,40,1,1);
  translate([3,XCAP_CUTTOUTWIDTH/4*3,-20]) cylinder($fn=50,40,1,1);
  cube([XCAP_DEPTH/2,XCAP_CUTTOUTWIDTH,XCAP_DEPTH]);
}

module XCcap(){
  colour("cyan")  difference() {
    rotate([0,0,90]) htube(XCAP_WIDTH,XCAP_DEPTH,100);

    translate([0,-1,0]) rotate([0,0,90]) htube(XTUBE,30,100);  // Remove hole for tube
    translate([-XCAP_WIDTH/2-1,-1,-XCAP_WIDTH/2-1]) cube([XCAP_WIDTH+2,XCAP_DEPTH+2,XCAP_WIDTH/2+1]);  //Remove bottom half

    // Screw Cuttout
//    translate([-13,6,-20]) cylinder(40,1,1);
//    translate([-13,14,-20]) cylinder(40,1,1);
//    translate([-20,2,6]) cube([XCAP_DEPTH/2,XCAP_CUTTOUTWIDTH,XCAP_DEPTH]);

    translate([-10,2,6]) mirror([1,0,0]) XCcapCuttout();

    translate([10,2,6]) XCcapCuttout();
  }
}

module leftXCx(){
  w=19;
  h1=Q*2;
  h2=24;

  difference(){
    union(){
      translate([-17,20,-Q])  cube([34,w,h1]);
      translate([-10,-6,-12])    cube([20,40,h2]);
*      translate([0,20,Q]) rotate([0,0,90]) htube(34,w,100);
*      translate([0,20,-Q]) rotate([0,0,90]) htube(34,w,100);
      translate([-20,30,0]) htube(24,40,100);

// hole bosses
      translate([10,19,30])    rotate([0,0,90]) htube(4,w+2,100);
      translate([-10,19,30])    rotate([0,0,90]) htube(4,w+2,100);
      translate([10,19,15])    rotate([0,0,90]) htube(4,w+2,100);
      translate([-10,19,15])    rotate([0,0,90]) htube(4,w+2,100);
      translate([10,19,-30])    rotate([0,0,90]) htube(4,w+2,100);
      translate([-10,19,-30])    rotate([0,0,90]) htube(4,w+2,100);
      translate([10,19,-15])    rotate([0,0,90]) htube(4,w+2,100);
      translate([-10,19,-15])    rotate([0,0,90]) htube(4,w+2,100);

      translate([-6,0,-13])     vtube(8,h2+2,100);
      translate([6,12,-13])     vtube(8,h2+2,100);


    }
    translate([-25,30,0]) htube(YTUBEBEARING,50,100);  // bearing width 16 ?
    translate([0,18,Q]) rotate([0,0,90]) htube(XTUBE,30,100);
    translate([0,18,-Q]) rotate([0,0,90]) htube(XTUBE,30,100);
    translate([-3,15,14])    cube([6,30,12]);
    translate([-3,15,-27])    cube([6,30,12]);

    translate([10,-10,30])    rotate([0,0,90]) htube(2,60,100);
    translate([-10,-10,30])    rotate([0,0,90]) htube(2,60,100);
    translate([10,-10,15])    rotate([0,0,90]) htube(2,60,100);
    translate([-10,-10,15])    rotate([0,0,90]) htube(2,60,100);
    translate([10,-10,-30])    rotate([0,0,90]) htube(2,60,100);
    translate([-10,-10,-30])    rotate([0,0,90]) htube(2,60,100);
    translate([10,-10,-15])    rotate([0,0,90]) htube(2,60,100);
    translate([-10,-10,-15])    rotate([0,0,90]) htube(2,60,100);


    translate([-6,0,-15])     vtube(5,60,100);
    translate([6,12,-40])     vtube(5,60,100);
  }

}

module leftXCa(){
   difference(){
    leftXCx();
    translate([-40,30,-50]) cube([100,20,100]);
  }
}

module leftXCb(){
   difference(){
    leftXCx();
    translate([-40,-30,-50]) cube([100,60,100]);
  }
}


module leftXC(){
  translate([0,20,Q])  XCcap();
  translate([0,20,-Q])  rotate ([0,180,0])XCcap();
  colour("skyblue") translate([0,0.1,0]) leftXCb();
  colour("blue")     translate([0,-0.1,0]) leftXCa();
}

module rightXC(){
   translate([0,HW,0]) rotate([0,0,180]) leftXC();
}

module xcarraige_assy(){

     translate([0,18,Q]) rotate([0,0,90]) htube($fn=50,XTUBE,HW-36,1);
     translate([0,18,-Q]) rotate([0,0,90]) htube($fn=50,XTUBE,HW-26,1);
     leftXC();
     rightXC();
}


module horizontal_assy(){
  z=70;
  translate([0,hwd,ChassisH-z]){
    translate([0,HW-30,0]) htube($fn=50,YTUBE,ChassisX,1);
    translate([0,30,0]) htube($fn=50,YTUBE,ChassisX,1);

    translate([GantryPos,0,0]) xcarraige_assy();
  }
  translate([0,hwd,ChassisH-26-z]) belts();
}



union(){
  $DETAIL = D_LOW;

  color("grey", 0.05) chassis($DETAIL=D_LOW,$fn=1, x,y,h);
  color("grey", 0.05) vertical_assy3($fn=1);
 *toothed_20teeth_8mm();

  horizontal_assy($DETAIL = D_HIGH,$fn=40);
	color("grey", 0.1) filament_assy();

//  XCcap($fn=200);
*  translate([-10,-10,-10]) belt(len=100);
}
