include <globals.scad>;

use <bom/bom.scad>;
use <cornerBracket.scad>;



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





module idlerLugg(q=0){
    translate([5.5,23,10.5])
    rotate([55,0,0])
    rotate([0,-90,0])
    {
        difference(){
            union(){
                hull(){
                    cylinder(5,4.5,4.5);
                    translate([-4.5,-9.7,0]) cube([9,1,5]);
                    translate([-4.5,-9.7,0]) rotate([0,0,-35]) cube([9,1,5]);
                }
                if (q!=1) {translate([0,0,-0.5])cylinder(3,2.5,2.5);}
                if (q!=2) {translate([0,0,2.5])cylinder(3,2.5,2.5);}
            }
            translate([0,0,-2]) cylinder(9,1.5,1.5);
        }
    }
}

module idlerXY(){
    bom(str("ilderXY"), str("??"), ["Printed"]);
    bom("F623ZZ bearing");bom("F623ZZ bearing");bom("F623ZZ bearing");bom("F623ZZ bearing"); 
    bom("m3 bolt - longish");
    bom("m3 nylock nut");
    bomBN(2);

    colour("plum"){
    a=2;
    rotate([180,90,0]){
        difference(){
            hull(){
                translate([0,14,0]) cube([35,1,5]);
                translate([a,a,0]) cylinder(5,a,a);
                translate([35-a,a,0]) cylinder(5,a,a);
            }
            translate([10,10,-1]) cylinder(10,2,2);
            translate([25,10,-1]) cylinder(10,2,2);
        }
        translate([0,0,0]) idlerLugg(2);
        translate([14.5,0,0]) idlerLugg();
        translate([29,0,0]) idlerLugg(1);
    }
}
}

*idlerXY($fn=100);





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
