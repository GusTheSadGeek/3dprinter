include <globals.scad>;

use <vslot/vslot.scad>;
use <vslot/ob_wheel.scad>;
use <cornerBracket.scad>;
use <components.scad>;
use <chassis.scad>;
use <pulley_wheels.scad>;

module leadThreadCoupler(){
	bom(str("Lead Thread Coupler"), str("8mm/6.3mm"), ["Hardware"]);
    colour("Silver") 
    difference(){
        cylinder(25,9,9);
        translate([0,0,12]) cylinder(14,4,4);
        translate([0,0,-1]) cylinder(14,3.15,3.15);
    }
}

module leadScrew(l=ChassisH-150){
	bom(str("Lead Screw"), str(l,"mm"), ["Hardware"],"http://amzn.eu/d/9isfCCI");
    colour("Red") cylinder(l,4,4);
}

module leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,Q=40,c=true,r=0){
    rotate(r){
        leadScrewBearing(false);
        translate([0,0,b2-10]) leadScrewBearing(false);
        translate([15,55/2,0]) leadScrew(b2);
        translate([15,55/2,Q-4]) toothed_40teeth_8mm();
    }
}

module leadScrewAssy2(b1=leadScrewBearingH1,b2=500,c=true,r=0){
    xo=c?0:StepperWidth/2;
    yo=c?0:StepperWidth/2;
    ho=0;
    translate([0,0,0]) 
    
    rotate([0,0,r]) {
*        stepper(true);
        translate([0,0,0]) leadScrew(l=b2+20);
 *       translate([0,0,46]) leadThreadCoupler(true);
        translate([0,0,6.5]) leadScrewBearing(true);
        translate([0,0,b2]) leadScrewBearing(true);
    }
}

module verticalIdleWheelHolder(Q=43){
    
*    cube([50,30,leadScrewBearingH1+10]);
*    translate([-20,0,20]) cube([7,30,leadScrewBearingH1-30]);
    
    
    
    translate([-20,0,20]) 
    hull(){
        translate([0,0,0]) cylinder(10,3,3);
        translate([0,-40,0]) cylinder(10,3,3);
        translate([70,0,0]) cylinder(10,8,8);
    }
    
    cube([70,30,10]);
    
    
    translate([-20,0,leadScrewBearingH1-20]) cube([70,30,10]);
    
    translate([30,15,Q])  smooth_5mm();
    translate([30,15,0])  cylinder(100,2.5,2.5);
}

module bedGuide(l=leadScrewBearingH2 - leadScrewBearingH1){
	bom(str("Bed Guide"), str(l,"mmx8mm"), ["Hardware"]);
    colour("Khaki") cylinder(l,4,4);
}
module bedGuideAssy(b1=leadScrewBearingH1,b2=500,c=false,r=0){
    rotate(r){
        translate([0,0,b2-10]) color("plum") leadScrewBearing(false);
        translate([0,0,b1-10]) color("plum") leadScrewBearing(false);
        translate([15,55/2,b1]) color("yellow") leadScrew(b2-b1);
    }
}


module vertical_assy2(){
    translate(FLB(v)+[0,20,0]) leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=90);
    translate(BLB(v)-[0,StepperWidth+20,0])leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=90);

    translate(FRB(v)-[StepperWidth,-20,0]) leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=270);
    translate(BRB(v)-[StepperWidth,StepperWidth+20,0]) leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=270);

    translate(FLB(v)+[20,0,0])   bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=180);
    translate(BLB(v)+[20,-StepperWidth,0]) bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=0);

    translate(FRB(v)+[-StepperWidth-v,0,0]) bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=180);
    translate(BRB(v)+[-StepperWidth-v,-StepperWidth,0]) bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=0);
}

module vertical_assy2a(){
    Q=43;
    
    translate(FLB(v)+[0,21,4])  leadScrewAssy(Q=Q);
    translate(BLB(v)+[0,-79,4]) leadScrewAssy(Q=Q);
    translate(FRB(v)+[0,79,4])  leadScrewAssy(Q=Q,r=180);
    translate(BRB(v)+[0,-21,4])  leadScrewAssy(Q=Q,r=180);

 *   translate(FLB(v)+[30,70,Q])  smooth_5mm();
 *    translate(BLB(v)+[30,-70,Q])  smooth_5mm();
 *    translate(FRB(v)+[-30,70,Q])  smooth_5mm();
  *   translate(BRB(v)+[-30,-70,Q])  smooth_5mm();

    translate(FLB(v)+[79,0,4])      bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=90);
    translate(BLB(v)+[21,0,4])      bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=270);
    translate(FRB(v)+[-21,0,4])      bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=90);
    translate(BRB(v)+[-79,0,4])      bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=270);


    
*    translate(BLB(v)+[20,0,0])      bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=0);



    translate(FLB(v)+[30,95,0]) union(){
        stepper(true);
        translate([0,0,Q]) toothed_20teeth_5mm();
    }
    
    translate(BLB(v)+[0,-110,0]) verticalIdleWheelHolder(Q);
    translate(FRB(v)+[0,110,0])  rotate(180) verticalIdleWheelHolder(Q);
    translate(BRB(v)+[0,-90,0]) rotate(180) verticalIdleWheelHolder(Q);
}


/***********************************************************************/

module verticalRod(l=leadScrewBearingH2-30, q=0){
	bom(str("Rod"), str(l,"mm"), ["Hardware"],"????");
    colour("Yellow") cylinder(l,4,4);
    translate([-17.25,-9,q]) verticalBearing();
}

module verticalBearing(l=leadScrewBearingH2-30){
	bom(str("VertBearing"), str(l,"mm"), ["Hardware"],"https://ebay.us/G7C7GL");
    difference(){
        colour("lightcyan") union(){
            cube([34.5,18,58]);
            translate([9,18,0]) cube([16,4,58]);
        }
        translate([17.25-12,20,8]) rotate([90,0,0]) cylinder(22,2,2);
        translate([17.25+12,20,8]) rotate([90,0,0]) cylinder(22,2,2);
        translate([17.25-12,20,50]) rotate([90,0,0]) cylinder(22,2,2);
        translate([17.25+12,20,50]) rotate([90,0,0]) cylinder(22,2,2);
    }

}

module stepperAndLeadScrew(c=false, l=leadScrewBearingH2-10){
	bom(str("Lead Screw"), str(l,"mm"), ["Hardware"],"https://e3d-online.com/motors-leadscrew-motor-with-pom-nut");
    stepper(c);
    colour("Red") translate([0,0,20]) cylinder(l,4,4);
    translate([-StepperWidth+0,StepperWidth,leadScrewBearingH2]) rotate([0,0,270])leadScrewBearing(true);
}

module leadScrewBearing(c=false){
	bom(str("Lead Screw Bearing"), str("8mm"), ["Hardware"],"http://amzn.eu/d/7ZUJSQP");
    bomBN(2);
    
    xo=c?55/2:0;
    yo=c?29/2:0;
    ho=c?13/2:0;
    translate([xo,yo,-ho]){
        rotate([90,0,90])
        difference()
        {
            union(){
                colour("Silver") bevelledCube([55,13,2],2);
                colour("Silver") hull(){
                    translate([55/2,13,14.5]) rotate([90,0,0]) cylinder(13,14.5,14.5);
                    translate([(55-29)/2,0,0]) cube([29,13,2]);
                }
                colour("Gold") translate([55/2,13.05,14.5]) rotate([90,0,0]) cylinder(13.1,12.5,12.5);
            }
            translate([55/2,14,14.5]) rotate([90,0,0]) cylinder(15,4,4);
            translate([(55-42)/2,6.5,-1]) cylinder(4,2.5,2.5);
            translate([(55-42)/2+42,6.5,-1]) cylinder(4,2.5,2.5);
        }
    }
}

module leadScrewCollar(){
    colour("grey") {
        cylinder(3.5,11,11);
        translate([0,0,-1.5]) cylinder(15,5.1,5.1);
        translate([0,0,3]) leadScrewCollarPlate();
    }
}

module verticalBackPlate(){
    cube([400,5,60]);
}

module leadScrewCollarPlate(){
    translate([-50,-15,0]) cube([100,35,5]);
}

module vertical_assy(){
    translate(BLB(v)+[(ChassisX-StepperWidth)/2,-20,0]) union(){
        stepperAndLeadScrew(true);
        q=3;
        translate([50,30,20])  verticalRod(q=q);
        translate([-50,30,20]) verticalRod(q=q);
        translate([150,30,20])  verticalRod(q=q);
        translate([-150,30,20]) verticalRod(q=q);
        translate([0,0,q]){
            translate([-200,15,20]) verticalBackPlate();
            translate([0,0,70]) leadScrewCollar();
        }
        
    }
    
}




union(){
  $DETAIL = D_HIGH;
  
  color("grey", 0.05) chassis($DETAIL=D_LOW,$fn=1, x,y,h);
  colour("blue",0.1) translate([(x-400)/2,(y-300)/2,200]) cube([400,300,3]);
  
  vertical_assy($fn=40);
*    ob_solid_wheel();

*   translate([-200,-200,0])  cylinder(14,3.15,3.15);

*   translate([-200,-200,0]) toothed_20teeth_8mm();
*   translate([-100,-100,0]) toothed_40teeth_8mm();

*   translate([20,40,4]) leadScrewAssy();

}

*translate(BRT(v)+[0,v,-20]) idlerXY();
*translate(BLT(v)+[0,v+0,-20]) mirror([1,0,0]) idlerXY();

*colour("blue",0.1) translate([(x-400)/2,(y-400)/2,200]) cube([400,400,3]);

//vslot20x20b(500,b=TOPBOT_B);
