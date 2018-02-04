use <vslot/bom.scad>;

StepperWidth=42.4;

module colour(c,t){
    color(c,t) children();
}

module bevelledCube(v,b,c){
        x=v[0];
        y=v[1];
        h=v[2];
        
        xo=c?x/2:0;
        yo=c?y/2:0;
        ho=c?h/2:0;

        q=0.0000000001;
        translate([-xo,-yo,-ho])
        hull(){
            translate([b,0,0])  cube([x-2*b,q,h]);
            translate([b,y,0])  cube([x-2*b,q,h]);

            translate([0,b,0])  cube([q,y-2*b,h]);
            translate([x,b,0])  cube([q,y-2*b,h]);
        }
}

module stepper(c=false){
	bom(str("Stepper Motor"), str("NEMA 17"), ["Electronics"]);
    
    W=StepperWidth;
    L=34;
    H=31;

    xo=c?W/2:0;
    yo=c?W/2:0;
    ho=0;
    translate([-xo,-yo,-ho]){
        difference(){
            colour("DarkSlateGray") bevelledCube([W,W,L],3);
            colour("white"){
                translate([(W-H)/2,(W-H)/2,26]) cylinder(10,1.5,1.5);
                translate([(W-H)/2,H+(W-H)/2,26]) cylinder(10,1.5,1.5);
                translate([H+(W-H)/2,H+(W-H)/2,26]) cylinder(10,1.5,1.5);
                translate([H+(W-H)/2,(W-H)/2,26]) cylinder(10,1.5,1.5);
            }
        }
        colour("LightGray") translate([W/2,W/2,L]) cylinder(2,11,11, $fn=100);
        colour("LightGray") translate([W/2,W/2,L]) cylinder(24,2.5,2.5, $fn=100);
    }
}

module leadThreadCoupler(){
	bom(str("Lead Thread Coupler"), str("8mm/6.3mm"), ["Hardware"]);
    colour("Silver") 
    difference(){
        cylinder(25,9,9);
        translate([0,0,12]) cylinder(14,4,4);
        translate([0,0,-1]) cylinder(14,3.15,3.15);
    }
}

module leadScrew(l=500){
	bom(str("Lead Screw"), str(l,"mm"), ["Hardware"]);
    colour("Khaki") cylinder(l,4,4);
}

module leadScrewBearing(c=false){
	bom(str("Lead Screw Bearing"), str("8mm"), ["Hardware"]);
    
    xo=c?55/2:0;
    yo=c?29/2:0;
    ho=c?13/2:0;
    translate([-xo,yo,-ho]){
        rotate([90,0,0])
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

module leadScrewAssy(b1=100,b2=500,c=false,r=0){
    xo=c?0:StepperWidth/2;
    yo=c?0:StepperWidth/2;
    ho=0;
    translate([xo,yo,ho]) rotate([0,0,r]) {
        stepper(true);
        translate([0,0,62]) leadScrew();
        translate([0,0,46]) leadThreadCoupler(true);
        translate([0,0,b1]) leadScrewBearing(true);
        translate([0,0,b2]) leadScrewBearing(true);
    }
}

module ccc(p,t=2){
    translate(p) cube([t,t,t]);
}

module CornerJoint(){
    bom(str("Corner Joint"), str("??"), ["Hardware"]);
    t=2;
    h=17;
    y=20;
    x=20;
    for(yy=[0,h-t]){
        hull(){
            ccc([0,0,yy],t);
            ccc([x-t,0,yy],t);
            ccc([0,y-t,yy],t);
        }
    }
    difference(){
        cube([x,t,h]);
        hull(){
            translate([x/2-1,3,h/2]) rotate([90,0,0]) cylinder(4,3,3);
            translate([x/2+2,3,h/2]) rotate([90,0,0]) cylinder(4,3,3);
        }
    }
    difference(){
        cube([t,y,h]);
        hull(){
            translate([-1,y/2-1,h/2]) rotate([0,90,0]) cylinder(4,3,3);
            translate([-1,y/2+2,h/2]) rotate([0,90,0]) cylinder(4,3,3);
        }
    }
}

module CornerJointA(){
    rotate([0,0,0]) translate([0,0,1.5]) CornerJoint();
}
module CornerJointB(){
     rotate([0,0,90]) translate([0,0,1.5]) CornerJoint();
}
module CornerJointC(){
    rotate([0,0,180]) translate([0,0,1.5]) CornerJoint();
}
module CornerJointD(){
    rotate([0,0,270]) translate([0,0,1.5]) CornerJoint();
}


module CornerJointE(){
    translate([0,20,0]) rotate([90,0,0]) translate([0,0,1.5]) CornerJoint();
}
module CornerJointF(){
    translate([0,20,0]) rotate([90,90,0]) translate([0,0,1.5]) CornerJoint();
}
module CornerJointG(){
    rotate([90,180,0]) translate([0,0,1.5]) CornerJoint();
}

module CornerJointH(){
    translate([0,0,0]) rotate([90,270,0]) translate([0,0,1.5]) CornerJoint();
}



module CornerJointI(){
    translate([20,0,0]) rotate([0,0,0]) rotate([0,-90,0]) translate([0,0,1.5]) CornerJoint();
}
module CornerJointJ(){
    translate([20,0,0]) rotate([90,0,0]) rotate([0,-90,0]) translate([0,0,1.5]) CornerJoint();
}
module CornerJointK(){
    translate([20,0,0]) rotate([180,0,0]) rotate([0,-90,0]) translate([0,0,1.5]) CornerJoint();
}

module CornerJointL(){
    translate([20,0,0]) rotate([270,0,0]) rotate([0,-90,0]) translate([0,0,1.5]) CornerJoint();
}







*stepper();
*leadThreadCoupler($fn=100);
*leadScrewBearing();

*leadScrewAssy($fn=100);

module CJ(){
    translate([0,0,0]) CornerJointA();
    translate([0,0,0]) CornerJointB();
    translate([0,0,0]) CornerJointC();
    translate([0,0,0]) CornerJointD();

    translate([50,0,0]) CornerJointE();
    translate([50,0,0]) CornerJointF();
    translate([50,0,0]) CornerJointG();
    translate([50,0,0]) CornerJointH();


    translate([100,0,0]) CornerJointI();
    translate([100,0,0]) CornerJointJ();
    translate([100,0,0]) CornerJointK();
    translate([100,0,0]) CornerJointL();
    
//    translate([240,0,0]) CornerJointI();
}

*CJ();
