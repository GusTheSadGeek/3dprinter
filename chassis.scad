use <vslot/vslot.scad>;
include <components.scad>;

x=500;
y=470;
h=500;

v=20; 

leadScrewBearingH1=100;
leadScrewBearingH2=h-100;


function FLB(q=0) = [0+q,0+q,0]; // FrontLeftBottom
function FRB(q=0) = [x-q,0+q,0]; // FrontRightBottom
function BLB(q=0) = [0+q,y-q,0]; // BackLeftBottom
function BRB(q=0) = [x-q,y-q,0]; // BackRightBottom

function FLT(q=0) = [0+q,0+q,h-q]; // FrontLeftTop
function FRT(q=0) = [x-q,0+q,h-q]; // FrontRightTop
function BLT(q=0) = [0+q,y-q,h-q]; // BackLeftTop
function BRT(q=0) = [x-q,y-q,h-q]; // BackRightTop


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

module xrailF(x,y,z=0){
    translate([v,v/2,v/2+z]) rotate([-90,0,-90]) vslot20x20(x-v*2);
}
module xrailB(x,y,z=0){
    translate([v,y-v/2,v/2+z]) rotate([-90,0,-90]) vslot20x20(x-v*2);
}

module yrailL(x,y,z=0){
    translate([v/2,v,v/2+z]) rotate([-90,0,0]) vslot20x20(y-v*2);
}
module yrailR(x,y,z=0){
    translate([x-v/2,v,v/2+z]) rotate([-90,0,0]) vslot20x20(y-v*2);
}

module base(x,y){
    xrailF(x,y);
    xrailB(x,y);
    yrailL(x,y);
    yrailR(x,y);
}

module pillars(x,y,h,c=false){
    translate([v/2,v/2,0]) vslot20x20(h);
    translate([x-v/2,v/2,0]) vslot20x20(h);

    translate([v/2,y-v/2,0]) vslot20x20(h);
    translate([x-v/2,y-v/2,0]) vslot20x20(h);
}

module chassis(x,y,h,c=false){
    xo=c?x/-2:0;
    yo=c?y/-2:0;
    ho=0;
    translate([xo,yo,ho]){
        base(x,y);
        translate([0,0,h-v]) base(x,y);
        pillars(x,y,h);
        
        yrailL(x,y,leadScrewBearingH1-v/2);
        yrailR(x,y,leadScrewBearingH1-v/2);
        yrailL(x,y,leadScrewBearingH2-v/2);
        yrailR(x,y,leadScrewBearingH2-v/2);
    }
    translate(FLB()+[v,0,v]) CornerJointE();
    translate(FLB()+[0,v,v]) CornerJointI();
    translate(FLB()+[v,v,0]) CornerJointA();
    
    translate(FRB()+[-v,v,v]) CornerJointH();
    translate(FRB()+[-v,v,v]) CornerJointI();
    translate(FRB()+[-v,v,0]) CornerJointB();
    

    translate(BLB()+[0,-v,v]) CornerJointJ();
    translate(BLB()+[v,-v,v]) CornerJointE();
    translate(BLB()+[v,-v,0]) CornerJointD();

    
    translate(BRB()+[-v,0,v]) CornerJointH();
    translate(BRB()+[-v,-v,v]) CornerJointJ();
    translate(BRB()+[-v,-v,0]) CornerJointC();

    translate(FLT()+[v,0,-v]) CornerJointF();
    translate(FLT()+[0,v,-v]) CornerJointL();
    translate(FLT()+[v,v,-v]) CornerJointA();

    translate(FRT()+[-v,v,-v]) CornerJointG();
    translate(FRT()+[-v,v,-v]) CornerJointL();
    translate(FRT()+[-v,v,-v]) CornerJointB();

    translate(BLT()+[v,-v,-v]) CornerJointF();
    translate(BLT()+[0,-v,-v]) CornerJointK();
    translate(BLT()+[v,-v,-v]) CornerJointD();

    
    translate(BRT()+[-v,0,-v]) CornerJointG();
    translate(BRT()+[-v,-v,-v]) CornerJointK();
    translate(BRT()+[-v,-v,-v]) CornerJointC();
    
}

chassis(x,y,h);

translate(FLB(v)+[0,20,0]) leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=90);
translate(BLB(v)-[0,StepperWidth+20,0])leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=90);

translate(FRB(v)-[StepperWidth,-20,0]) leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=270);
translate(BRB(v)-[StepperWidth,StepperWidth+20,0]) leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=270);

