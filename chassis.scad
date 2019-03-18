include <globals.scad>;

use <vslot/vslot.scad>;

use <cornerBracket.scad>;
use <components.scad>;






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



NO_B=[0,0,0,0,0,0,0,0];
BOT_B=[1,0,1,0,0,0,0,0];
TOP_B=[0,1,0,1,0,0,0,0];
TOPBOT_B=BOT_B+TOP_B;

LEFT_B=[0,0,0,0,1,0,1,0];
RIGHT_B=[0,0,0,0,0,1,0,1];


module vslot20x20b(l,b=NO_B){
		bom(str("VSlot20x20"),str("length=",l),["Hardware"]);

    vslot20x20(l);
    if (b[0]) {translate([-v/2,v/2,0]) CornerJointI();}
    if (b[1]) {translate([-v/2,-v/2,0]) CornerJointJ();}

    if (b[2]) {translate([-v/2,v/2,l])   CornerJointL();}
    if (b[3]) {translate([-v/2,-v/2,l])   CornerJointK();}

    if (b[4]) {translate([v/2,-v/2,0]) CornerJointE();}
    if (b[5]) {translate([-v/2,v/2,0])   CornerJointH();}

    if (b[6]) {translate([v/2,-v/2,l]) CornerJointF();}
    if (b[7]) {translate([-v/2,v/2,l])   CornerJointG();}
}

module xrailF(x,y,z=0,b=NO_B){
    translate([v,v/2,v/2+z]) rotate([-90,0,-90]) vslot20x20b(x-v*2,b);
}
module xrailB(x,y,z=0){
    translate([v,y-v/2,v/2+z]) rotate([-90,0,-90]) vslot20x20b(x-v*2,b);
}

module yrailL(x,y,z=0,b=NO_B){
    translate([v/2,v,v/2+z]) rotate([-90,0,0]) vslot20x20b(y-v*2,b);
}
module yrailR(x,y,z=0,b=NO_B){
    translate([x-v/2,v,v/2+z]) rotate([-90,0,0]) vslot20x20b(y-v*2,b);
}

module base(x,y,b=TOP_B){
    xrailF(x,y,b=b);
    xrailB(x,y,b=b);
    yrailL(x,y,b=b+LEFT_B);
    yrailR(x,y,b=b+RIGHT_B);
}

module base2(x,y,b=TOP_B){
    xrailF(x,y,b=b);
    xrailB(x,y,b=b);
    translate([StepperWidth,0,0]) yrailL(x,y,q=b+LEFT_B);
    translate([-StepperWidth,0,0]) yrailR(x,y,q=b+RIGHT_B);
}


module pillars(x,y,h,c=false){
    translate([v/2,v/2,0]) vslot20x20b(h);
    translate([x-v/2,v/2,0]) vslot20x20b(h);

    translate([v/2,y-v/2,0]) vslot20x20b(h);
    translate([x-v/2,y-v/2,0]) vslot20x20b(h);
}

module chassis(x,y,h,c=false){
    xo=c?x/-2:0;
    yo=c?y/-2:0;
    ho=0;
    translate([xo,yo,ho]){
        base(x,y,b=TOP_B);
        translate([0,0,h-v]) base(x,y,b=BOT_B);
        pillars(x,y,h);

*        yrailL(x,y,leadScrewBearingH1-v/2,b=TOPBOT_B);
*        yrailR(x,y,leadScrewBearingH1-v/2,b=TOPBOT_B);
        yrailL(x,y,leadScrewBearingH2-v/2,b=TOPBOT_B);
				yrailR(x,y,leadScrewBearingH2-v/2,b=BOT_B);
        yrailR(x,y,leadScrewBearingH2-v/2+44,b=BOT_B);

*        xrailF(x,y,leadScrewBearingH1-v/2,b=TOPBOT_B);
*        xrailB(x,y,leadScrewBearingH1-v/2,b=TOPBOT_B);
        xrailF(x,y,leadScrewBearingH2-v/2,b=TOPBOT_B);
        xrailB(x,y,leadScrewBearingH2-v/2,b=TOPBOT_B);

    }
}

module chassis2(x,y,h,c=false){
    xo=c?x/-2:0;
    yo=c?y/-2:0;
    ho=0;
    translate([xo,yo,ho]){
        base2(x,y,b=TOP_B);
        translate([0,0,h-v]) base(x,y,b=BOT_B);
        pillars(x,y,h);

*        yrailL(x,y,leadScrewBearingH1-v/2,b=TOPBOT_B);
*        yrailR(x,y,leadScrewBearingH1-v/2,b=TOPBOT_B);
        yrailL(x,y,leadScrewBearingH2-v/2,b=TOPBOT_B);
        yrailR(x,y,leadScrewBearingH2-v/2,b=TOPBOT_B);

*        xrailF(x,y,leadScrewBearingH1-v/2,b=TOPBOT_B);
*        xrailB(x,y,leadScrewBearingH1-v/2,b=TOPBOT_B);
        xrailF(x,y,leadScrewBearingH2-v/2,b=TOPBOT_B);
        xrailB(x,y,leadScrewBearingH2-v/2,b=TOPBOT_B);

    }
}



bomq(";lk;lk;");

union(){
chassis(x,y,h);

*translate(FLB(v)+[0,20,0]) leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=90);
*translate(BLB(v)-[0,StepperWidth+20,0])leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=90);

*translate(FRB(v)-[StepperWidth,-20,0]) leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=270);
*translate(BRB(v)-[StepperWidth,StepperWidth+20,0]) leadScrewAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=270);

*translate(FLB(v)+[20,0,0])   bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=180);
*translate(BLB(v)+[20,-StepperWidth,0]) bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=0);

*translate(FRB(v)+[-StepperWidth-v,0,0]) bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=180);
*translate(BRB(v)+[-StepperWidth-v,-StepperWidth,0]) bedGuideAssy(b1=leadScrewBearingH1,b2=leadScrewBearingH2,r=0);

}

translate(BRT(v)+[0,v,-20]) idlerXY();
translate(BLT(v)+[0,v+0,-20]) mirror([1,0,0]) idlerXY();

colour("blue",0.1) translate([(x-400)/2,(y-400)/2,200]) cube([400,400,3]);

//vslot20x20b(500,b=TOPBOT_B);
