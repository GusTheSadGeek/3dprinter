include <globals.scad>;


thickness=2;
width=17;
height=20;
length=20;



module ccc(p,t=thickness){
    translate(p) cube([t,t,t]);
}

module CornerJoint(){
    bom(str("Corner Joint"), str("??"), ["Hardware"]);
    bomBN(2);
    for(y=[0,width-thickness]){
        hull(){
            ccc([0,0,y],thickness);
            ccc([length-thickness,0,y],thickness);
            ccc([0,height-thickness,y],thickness);
        }
    }
    difference(){
        cube([length,thickness,width]);
        hull(){
            translate([length/2-1,3,width/2]) rotate([90,0,0]) cylinder(4,3,3);
            translate([length/2+2,3,width/2]) rotate([90,0,0]) cylinder(4,3,3);
        }
    }
    difference(){
        cube([thickness,height,width]);
        hull(){
            translate([-1,height/2-1,width/2]) rotate([0,90,0]) cylinder(4,3,3);
            translate([-1,height/2+2,width/2]) rotate([0,90,0]) cylinder(4,3,3);
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

CornerJoint();
