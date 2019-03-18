include <globals.scad>;

use <vslot/vslot.scad>;
use <vslot/ob_wheel.scad>;
use <chassis.scad>;
use <vertical.scad>;

use <cornerBracket.scad>;
use <components.scad>;
use <pulley_wheels.scad>;
use <angle.scad>;

Q=32;  // XCarrage Tube separation / 2

hwd=10;
HW=ChassisY-hwd*2;
X=ChassisX+10;

YTUBE=12;
YTUBEBEARING=16;

XTUBE=12;
XTUBEBEARING=14;

VIRT_BELT_SEP=12;  // Verticle belt separation

//YPos = HW * (($t>0.5) ?  (1-$t)*2 : $t*2)+22;
YPos = (HW*.7)*$t + HW*0.1;

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
  Z=VIRT_BELT_SEP;  // Verticle belt separation



//  ZZ
  Y=HW-40;
  C=6;  // Distance from centre of XCarrage
  Q=12;
  q=6;

  A=YPos;
  B=GantryPos-10;

  //B=50;
  translate([10,20,-1]){
    translate([X,0,0])       toothed_wheel();  // motor
    translate([X-20,-21,-37])     stepper(0);  // motor

    color("red"){
       translate([B-q,Q,1]) belt(A,r=90);
       translate([B,Q,0])   smooth_idler_5mm();
       translate([X,q,1])       belt(X-B-C,r=180);
       translate([0,0,0])       toothed_idler_5mm();  //
//       translate([0,0,0])       toothed_idler_5mm();  //
       translate([0,-q,1])      belt(X,r=0);

       translate([Q-q,Y-Q,1])      belt(Y-Q,r=268);
//       translate([0,Y-Q,0])       toothed_idler_5mm();
       translate([Q,Y-Q,0])       toothed_idler_5mm();
       translate([B-C,Y+q-Q,1]) belt(B-C-Q,r=180);
       translate([B,Y-Q,0])   toothed_idler_5mm();
       translate([B+q,A+30,1]) belt(Y-A-30-Q,r=90);
    }


    translate([X,Y,-1]) {
      translate([1,0,24])  mirror([0,0,1]) toothed_wheel();  // motor
      translate([-20,-21,-34])  stepper(0);  // motor
    }
    color("yellow"){
       translate([B-q,A-Q+42,Z+1])   belt(Y-A-42,r=90);
       translate([B,Y-Q,Z])  smooth_idler_5mm();
       translate([B+C+q-q,Y-q,Z+1])   belt(X-B-C,r=0);


//       translate([0,Q,Z])         toothed_idler_5mm();  //
       translate([Q,Q,Z])         toothed_idler_5mm();  //
       translate([X+q-q,Y+q,Z+1])   belt(X,r=180);


       translate([-q,Y,Z+1])      belt(Y-Q,r=272);
       translate([0,Y,Z])  toothed_idler_5mm();

       translate([q-q+Q,Q-q,Z+1])   belt(B-C-Q,r=0);

       translate([B,Q,Z])  toothed_idler_5mm();

       translate([B+q,Q,Z+1])   belt(A+12-Q,r=90);
    }
  }
}

/* module linear_slider(){
  l=44;
  w=27;
  h=10;
  difference(){
    cube([w,l,h]);
  }
} */


/* module linear_rail(l=550, p=100){
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
} */


/* module top_plate(){
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
 */
XCAP_WIDTH=34;
XCAP_DEPTH=19;
XCAP_CUTTOUTWIDTH = XCAP_DEPTH-4;

/* module XCcapCuttout(){
  // Screw Cuttout
  translate([3,XCAP_CUTTOUTWIDTH/4,-20]) cylinder($fn=50,40,1,1);
  translate([3,XCAP_CUTTOUTWIDTH/4*3,-20]) cylinder($fn=50,40,1,1);
  cube([XCAP_DEPTH/2,XCAP_CUTTOUTWIDTH,XCAP_DEPTH]);
} */

/* module XCcap(){
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
} */

module leftXCx(right=0){
  // Q = distance between XCarrage tubes and Y Tube

  h1=Q*2;  // dist between X Carriage tube
  height=h1+(XTUBE+4*2); // Total body height

  width=34;
  depth=20;
  h2=18;
  difference(){
    union(){
      // main body
      translate([-width/2, 20, -height/2])  bevelledCube6([width,depth,height],3);

      // Top belt bracket
      translate([-width/2,-10,-h2/2-8])    bevelledCube6([width,35,5],1);
      translate([-width*.8/2-1,-5,h2/2+9])  fillet([4,30,6],4);
      translate([width*.8/2-14.5,-5,h2/2+9]) fillet([4,30,6],4);

      // Bottom belt bracket
      translate([-width/2,-10,+h2/2+4])    bevelledCube6([width,35,5],1);
      translate([-width*.8/2-1,-5,-h2/2-8]) mirror([0,0,1]) fillet([4,30,6],4);
      translate([width*.8/2-14.5,-5,-h2/2-8]) mirror([0,0,1]) fillet([4,30,6],4);

      // bearing housing
      translate([-width*0.5,30,0]) htube(depth*1.2,width*1,100);
    }
    // Bearing hole
    translate([-25,30,0]) htube(YTUBEBEARING,50,100);

    // Top tube hole
    translate([0,18,Q]) rotate([0,0,90]) htube(XTUBE,30,100);

    // Bottom tube hole
    translate([0,18,-Q]) rotate([0,0,90]) htube(XTUBE,30,100);

    // Top Cutout
    translate([0,19,Q]) cube([width/2+2,depth+2,1]);
    // Bottom Cutout
    translate([0,19,-Q]) cube([width/2+2,depth+2,1]);

    // Belt idler hole
    translate([0,-2,-40])     vtube(5,60,100);

    translate([width*.35,30,Q-15])      vtube(3,60,100);
    translate([width*.35,30,-2*Q-15])   vtube(3,60,100);

    nutwidth=5;
    nutheight=2;
    translate([width*.35-nutwidth/2,20+depth/2-nutwidth/2,-Q+5])      cube([16,nutwidth,nutheight]);
    translate([width*.35-nutwidth/2,20+depth/2-nutwidth/2,Q-10])      cube([16,nutwidth,nutheight]);

  }


}

module leftXCa(right){
    leftXCx(right);
}


module leftXCc(right=0){
  translate([0,-30,0]){
    colour("blue") leftXCa(right);
  }
}

module leftXC(){
   translate([0,0,0]) rotate([0,0,180]) leftXCc(right=0);
}


module rightXC(){
   translate([0,HW,0]) rotate([0,0,0]) leftXCc(right=1);
}

module xcarraige_assy(){
     translate([0,-10,Q]) rotate([0,0,90]) htube($fn=50,XTUBE,HW+20,1);
     translate([0,-10,-Q]) rotate([0,0,90]) htube($fn=50,XTUBE,HW+20,1);
     leftXC();
     rightXC();
}
module cornerIdler2(){
  mirror([0,1,0]) cornerIdler1();
}
module cornerIdler1(){
  H = TOP_SPACE-50;
  HH = TOP_SPACE+10;

  color("pink") {
      difference(){
        union(){
          translate([-5,10,-30]) bevelledCube4v([35,5,60],2);
          translate([0,-10,-20]) rotate([0,0,90]) bevelledCube4v([22,5,40],2);
          translate([0,10,-17]) bevelledCube4([30,30,5],2);
          translate([0,10,13]) bevelledCube4([30,30,5],2);
        }
        translate([2,11,-12]) cube([32,5,25]);
        translate([22,32,-20]) vtube(5,66,100);
        translate([10,20,-20]) vtube(5,66,100);

        translate([-6,0,12]) htube(4,66,100);
        translate([-6,0,-12]) htube(4,66,100);

        translate([10,0,25])  rotate([0,0,90]) htube(4,66,100);
        translate([10,0,-25])  rotate([0,0,90]) htube(4,66,100);
      }
  }
}

module tubeHolder(){
  H = TOP_SPACE-50;
  HH = TOP_SPACE+10;

  color("Lime") {
      difference(){
        union(){
          translate([30,-10,-20]) rotate([0,0,90]) bevelledCube4v([20,10,40],2);
        }
        translate([-1,0,0]) htube(12,66,100);

        translate([-1,0,12]) htube(4,66,100);
        translate([-1,0,-12]) htube(4,66,100);
      }
  }
}



/* module robEnd1(){
  H = TOP_SPACE-36;
  HH = TOP_SPACE+10;

  translate([0,20-hwd,-H/2]) {
    difference(){
      color("red") cube([20,10,H]);
      translate([-2,10,H/2]) htube(YTUBE,24,100);
      translate([10,16,H/2-13]) rotate([0,0,90]) htube(4,25,100);
      translate([10,16,H/2+13]) rotate([0,0,90]) htube(4,25,100);
    }
  }

  translate([0,20-hwd,-H/2]) {
    difference(){
      translate([0,10,0]) color("lightcyan") cube([20,10,H]);
      translate([-2,10,H/2]) htube(YTUBE,24,100);

      translate([10,16,H/2-13]) rotate([0,0,90]) htube(8,5,100);
      translate([10,16,H/2+13]) rotate([0,0,90]) htube(8,5,100);

      translate([10,16,H/2-13]) rotate([0,0,90]) htube(4,25,100);
      translate([10,16,H/2+13]) rotate([0,0,90]) htube(4,25,100);
    }
  }

  color("lightcyan") translate([0,40-hwd,-HH/2]) {
    difference() {
      union(){
        translate([0,0,23]) cube([20,20,13]);
        translate([0,20,0]) cube([20,10,36]);
        translate([0,20,0]) cube([20,30,10]);
        translate([10,40,0])    vtube(8,11,100);
        translate([10,10,22])    vtube(8,16,100);
      }
      translate([10,10,21])    vtube(6,18,100);
      translate([10,40,-1])    vtube(6,22,100);
    }
  }

  color("lightcyan") translate([0,40-hwd,HH/2]) {
    difference() {
      union(){
        translate([0,0,-36]) cube([20,30,13]);
        translate([0,30,-36]) cube([20,10,36]);
        translate([0,30,-10]) cube([20,30,10]);
        translate([10,22,-38])    vtube(8,16,100);
        translate([10,50,-11])    vtube(8,16,100);
      }
      translate([10,22,-39])    vtube(6,18,100);
      translate([10,50,-12])    vtube(6,16,100);
    }
  }

}

module robEnd2(){
  rotate([180,0,0]) robEnd1();
} */

/* module robEnd3(){
  H = TOP_SPACE-75;
  HH = TOP_SPACE+10;

//  translate([-10,-15,10]) rotate([0,0,90]) htube(4,26,100);
//  translate([-10,-15,-10]) rotate([0,0,90]) htube(4,26,100);

//  translate([-10,6,10]) rotate([0,0,90]) htube(8,5,100);
//  translate([-10,6,-10]) rotate([0,0,90]) htube(8,5,100);


  translate([-20,20-hwd,-H/2]) {
    difference(){
      color("red") cube([20,10,H]);
      translate([-2,10,H/2]) htube(YTUBE,24,100);
      translate([10,0,25]) rotate([0,0,90]) htube(4,25,100);
      translate([10,0,5]) rotate([0,0,90]) htube(4,25,100);

    }
}
  translate([-20,20-hwd,-H/2]) {
    difference(){
      translate([0,10,0]) color("lightcyan") cube([20,10,H]);
      translate([-2,10,H/2]) htube(YTUBE,24,100);
      translate([10,16,25]) rotate([0,0,90]) htube(8,5,100);
      translate([10,16,5]) rotate([0,0,90]) htube(8,5,100);

      translate([10,0,25]) rotate([0,0,90]) htube(4,25,100);
      translate([10,0,5]) rotate([0,0,90]) htube(4,25,100);

    }
  }
} */
module stepperBracketPadding(padding){
  W=StepperWidth;
  colour("Lime")  translate([0,-1,-14]){
      difference(){
          union(){
            translate([-20,-9,-padding]) bevelledCube4([20,W+10,padding],3);
            translate([-10,-9,-padding]) cube([10,W+10,padding]);
          }
          colour("white"){
              translate([-10,20,-padding-1]) vtube(5,30,100);
              translate([-10,35,-padding-1]) vtube(5,30,100);
              translate([-22,-11,-padding-2]) cube([22,22,30]);
          }
      }
    }
}

module stepperBracket2(){
  mirror([0,1,0]) stepperBracket();
}
module stepperBracket(){
  W=StepperWidth;
  L=4;
  H=31;
  c=0;
  xo=c?W/2:0;
  yo=c?W/2:0;
  ho=0;

  colour("Pink")  translate([0,-1,-14]){
      difference(){
          union(){
            translate([-20,-9,0]) bevelledCube4([W+20,W+10,L],3);

            translate([3,-9,0]) rotate([0,270,0]) bevelledCube4([30,20,3],2);
            /* translate([(W-H)/2,(W-H)/2,-L+5]) cylinder(4,2.5,2.5);
            translate([(W-H)/2,H+(W-H)/2,-L+5]) cylinder(4,2.5,2.5);
            translate([H+(W-H)/2,H+(W-H)/2,-L+5]) cylinder(4,2.5,2.5);
            translate([H+(W-H)/2,(W-H)/2,-L+5]) cylinder(4,2.5,2.5); */
          }
          colour("white"){
              translate([(W-H)/2,(W-H)/2,-L]) cylinder(10,1.5,1.5);
              translate([(W-H)/2,H+(W-H)/2,-L]) cylinder(10,1.5,1.5);
              translate([H+(W-H)/2,H+(W-H)/2,-L]) cylinder(10,1.5,1.5);
              translate([H+(W-H)/2,(W-H)/2,-L]) cylinder(10,1.5,1.5);


              translate([-22,-11,-2]) cube([22,22,30]);

              translate([-10,20,-1]) vtube(5,30,100);
              translate([-10,35,-1]) vtube(5,30,100);

              translate([-5,1,11]) htube(5,30,100);
              translate([-5,1,24]) htube(5,30,100);

              colour("LightGray") translate([W/2,W/2,-L-1]) cylinder(10,11,11);
          }
      }
  }
  /* difference(){
    colour("Pink") union() {
      translate([-4,-10,-24]) cube([4,W+9,4]);
      translate([-39,41,-58]) cube([43,L,H+L+3]);
      translate([0,-30,-78]) cube([L,W+29,58]);
      translate([1,-20,-30]) htube(6,4,10);
      translate([1,-20,-68]) htube(6,4,10);
      translate([1,25,-68]) htube(6,4,10);

    }
    translate([-1,-20,-30]) htube(4,10,10);
    translate([-1,-20,-68]) htube(4,10,10);
    translate([-1,25,-68]) htube(4,10,10);
  } */


}

module horizontal_assy(){
  z=TOP_SPACE-28;
  translate([0,hwd,ChassisH-z]){
    translate([20,HW,0]) htube($fn=50,YTUBE,ChassisX-40,1);
    translate([20,0,0])  htube($fn=50,YTUBE,ChassisX-40,1);

    translate([0,0,0]) cornerIdler1();
    translate([0,ChassisY-20,0]) cornerIdler2();

    translate([0,0,0]) tubeHolder();
    translate([0,ChassisY-20,0]) tubeHolder();

    translate([ChassisX-50,0,0]) tubeHolder();
    translate([ChassisX-50,ChassisY-20,0]) tubeHolder();

    /* translate([0,0,0]) robEnd1();
    translate([0,HW,0])robEnd2();

    translate([ChassisX,0,0]) robEnd3();

    translate([ChassisX,ChassisY-60,0])  rotate([180,0,0]) robEnd3(); */

    translate([ChassisX,0,0])  stepperBracket();
    translate([ChassisX,ChassisY-20,2])  stepperBracket2();
    translate([ChassisX,ChassisY-20,2])  mirror([0,1,0]) stepperBracketPadding(2);
    translate([GantryPos,0,0]) xcarraige_assy();
  }
  translate([0,hwd,ChassisH-10-z]) belts();
}



union(){
  $DETAIL = D_LOW;

  color("grey", 0.05) chassis($DETAIL=D_LOW,$fn=1, x,y,h);
  color("grey", 0.05) vertical_assy3($fn=1);

  horizontal_assy($DETAIL = D_HIGH,$fn=40);
*	color("grey", 0.1) filament_assy();

//  XCcap($fn=200);
*  translate([-10,-10,-10]) belt(len=100);
}
