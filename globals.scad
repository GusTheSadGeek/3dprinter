use <bom/bom.scad>;
use <vslot/vslot.scad>;

ABS_MAX_WIDTH=545;
ABS_MAX_DEPTH=470;


D_MAX=10;
D_HIGH=5;
D_MED=3;
D_LOW=1;
D_LOWEST=0;

//$DETAIL=D_HIGH;

x=ABS_MAX_WIDTH-10;
y=ABS_MAX_DEPTH;
h=580;

v=20;


ChassisX=x;
ChassisY=y;
ChassisH=h;

DEFAULT_BELT=9;

TOP_SPACE=106;

leadScrewBearingH1=100;
leadScrewBearingH2=ChassisH-TOP_SPACE-40;

StepperWidth=42.4;
//###############################################################################
//$t=0.5;
BedHeight=20 +$t*270;
GantryPos=50 + (ChassisX-100) *$t;
XPos=GantryPos;

YPos = (ChassisY-88)* (($t>0.5) ?  (1-$t)*2 : $t*2)+22;

//YPos = ($t>0.5) ?  (1-$t)*(ChassisY-66)*2 : $t*(ChassisY-66)*2;
