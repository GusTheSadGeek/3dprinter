include <globals.scad>;

use <vslot/vslot.scad>;
use <vslot/ob_wheel.scad>;
use <cornerBracket.scad>;
use <components.scad>;
use <chassis.scad>;
use <pulley_wheels.scad>;
use <angle.scad>;



module heaterPlate(x=200, y=300, z=2){
	bom(str("HeaterPlate"), str(x,"mm"), ["Hardware"],"????");
    cube([x,y,z]);
}


module verticalRodWithLinearBearing(l=leadScrewBearingH2-30, q=0, r=0){
	bom(str("Rod"), str(l,"mm"), ["Hardware"],"????");
    colour("Yellow") cylinder(l,4,4);
    rotate([0,0,r]) translate([-17.25,-9,q])  verticalBearing();
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
    translate([0,0,BedHeight+38]) leadScrewCollar();

    colour("Red") translate([0,0,20]) cylinder(l,4,4);
    translate([-StepperWidth+0,StepperWidth,l+18]) rotate([0,0,270])leadScrewBearing(true);
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
*        translate([0,0,3]) leadScrewCollarPlate();
    }
}


module leadScrewCollarPlate(){
    *cube([100,35,5]);
 translate([-50,15,0])   rotate([180,0,0]) Angle(lenght=100, width=35,thickness=3);


}

module bed(q=BedHeight){

    translate([-8,70,q+65])            rotate([0,90,0]) vslot20x20(ChassisX+16);
    translate([-8,ChassisY-70,q+65])   rotate([0,90,0]) vslot20x20(ChassisX+16);

    translate([10,60,q+45])            rotate([0,90,90]) vslot20x20(ChassisY-120);

    translate([ChassisX-10,60,q+45])            rotate([0,90,90]) vslot20x20(ChassisY-120);


    translate([ChassisX/2-200,90,q+85])   color([0.7,.8,.8]) heaterPlate();
    translate([ChassisX/2+000,90,q+85])   color([0.8,.8,.8])heaterPlate();

}

module vertical_assy(q=BedHeight){
    //translate(BLB(v)+[(ChassisX-StepperWidth)/2,-20,0])

    union(){
        translate([StepperWidth,ChassisY/2,0])          rotate([0,0,90])    stepperAndLeadScrew(true);
        translate([10,50,20])           verticalRodWithLinearBearing(q=q,r=180);
        translate([10,ChassisY-50,20])  verticalRodWithLinearBearing(q=q,r=0);

        translate([ChassisX-StepperWidth,ChassisY/2,0]) rotate([0,0,270])    stepperAndLeadScrew(true);
        translate([ChassisX-10,50,20])  verticalRodWithLinearBearing(q=q,r=180);
        translate([ChassisX-10,ChassisY-50,20])  verticalRodWithLinearBearing(q=q,r=0);

        bed();
    }
}

module bed2(q=BedHeight){
	YY=300;

    translate([StepperWidth-8,70,q+65])            rotate([0,90,0]) vslot20x20(ChassisX-StepperWidth*2+16);
    translate([StepperWidth-8,YY+50,q+65])   rotate([0,90,0]) vslot20x20(ChassisX-StepperWidth*2+16);


    translate([StepperWidth+10,60,q+45])            rotate([0,90,90]) vslot20x20(YY);
    translate([ChassisX-10-StepperWidth,60,q+45])            rotate([0,90,90]) vslot20x20(YY);


    translate([ChassisX/2-200,60,q+85])   color([0.7,.8,.8]) heaterPlate();
    translate([ChassisX/2+000,60,q+85])   color([0.8,.8,.8]) heaterPlate();

}


module vertical_assy2(q=BedHeight){
	YY=300;

    //translate(BLB(v)+[(ChassisX-StepperWidth)/2,-20,0])

    translate([0,-40,0]) union(){
        translate([StepperWidth-20,ChassisY/2,0])          rotate([0,0,90])    stepperAndLeadScrew(true);
        translate([10+StepperWidth,50,20])           verticalRodWithLinearBearing(q=q,r=180);
        translate([10+StepperWidth,YY+70,20])  verticalRodWithLinearBearing(q=q,r=0);

        translate([ChassisX-StepperWidth+20,ChassisY/2,0]) rotate([0,0,270])    stepperAndLeadScrew(true);
        translate([ChassisX-10-StepperWidth,50,20])  verticalRodWithLinearBearing(q=q,r=180);
        translate([ChassisX-10-StepperWidth,YY+70,20])  verticalRodWithLinearBearing(q=q,r=0);

        bed2();

        translate([120,ChassisY,120]) filamentReel();
        translate([ChassisX-120,ChassisY,120]) filamentReel();
        translate([120,ChassisY,200+120]) filamentReel();
        translate([ChassisX-120,ChassisY,200+120]) filamentReel();
    }
}

module bed3(q=BedHeight){
	YY=300;

    translate([-8,18,q+65])             rotate([0,90,0]) vslot20x20(ChassisX+16);
    translate([-8,YY-18,q+65])          rotate([0,90,0]) vslot20x20(ChassisX+16);

    translate([37,-9,q+45])              rotate([0,90,90]) vslot20x20(YY+18);
    translate([ChassisX-37,-9,q+45])     rotate([0,90,90]) vslot20x20(YY+18);

    translate([ChassisX/2-200,0,q+85])   color([0.7,.8,.8]) heaterPlate();
    translate([ChassisX/2+000,0,q+85])   color([0.8,.8,.8]) heaterPlate();

}


module vertical_assy3(q=BedHeight){
	YY=300;

    //translate(BLB(v)+[(ChassisX-StepperWidth)/2,-20,0])

	translate([0,15,0]) union(){
		translate([StepperWidth/2,YY/2,20])          rotate([0,0,90])    stepperAndLeadScrew(true,l=leadScrewBearingH2-54);
		translate([10,37,20])     verticalRodWithLinearBearing(q=q,r=180);
		translate([10,YY-37,20])    verticalRodWithLinearBearing(q=q,r=0);

		translate([ChassisX-StepperWidth/2,YY/2,20])          rotate([0,0,270])    stepperAndLeadScrew(true,l=leadScrewBearingH2-54);
		translate([ChassisX-10,37,20])     verticalRodWithLinearBearing(q=q,r=0);
		translate([ChassisX-10,YY-37,20])    verticalRodWithLinearBearing(q=q,r=180);

		bed3();
	}
}



module filament_assy(){
	translate([0,ChassisY-50,0]) union(){
		translate([120,0,120]) 							color("red")    filamentReel();
		translate([ChassisX-120,0,120]) 			color("blue")   filamentReel();
		translate([120,0,200+120]) 					color("yellow") filamentReel();
		translate([ChassisX-120,0,200+120]) 	color("green")  filamentReel();
	}
}


module filamentReel(w=70){
	translate([0,w/2,0]) rotate([90,0,0]) difference(){
		union(){
			translate([0,0,0]) cylinder(2,100,100);
			translate([0,0,w]) cylinder(2,100,100);
			cylinder(w,27,27);
		}
		translate([0,0,-0.5]) cylinder(w+4,25,25);
	}

}



union(){
  $DETAIL = D_HIGH;

  color("grey", 0.05) chassis($DETAIL=D_LOW,$fn=1, x,y,h);
*  colour("blue",0.1) translate([(x-400)/2,(y-300)/2,200]) cube([400,300,3]);
  vertical_assy3($fn=40);
	color("grey", 0.1) filament_assy();
}
