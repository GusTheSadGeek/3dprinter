include <globals.scad>;
use <bom/bom.scad>;

default_belt=9;


module belt(len=10, w=default_belt, r=0){
  thickness=0.5;
	rotate([0,0,r])
	union(){
	  color("black") cube([len,thickness,w]);

	  for(q=[0:2:len]){
//	    translate([q,thickness,-0.1]) color("grey") cube([thickness,thickness,w]);
	  }
	}
}

module toothed_20teeth_8mm(){
	bom(str("toothed_20teeth_8mm"), str("8mm/20t"), ["Hardware"],"http://amzn.eu/d/0etGcmO");
  spindle=8;
  width=16;
  color("SlateGrey")    toothed_wheel(spindle, width);

}

module toothed_40teeth_8mm(){
	bom(str("toothed_40teeth_8mm"), str("8mm/40t"), ["Hardware"], "http://amzn.eu/d/j7fC9fY");

  spindle=8;
  width=24;
  color("SlateGrey")    toothed_wheel(spindle, width);

}

module toothed_20teeth_5mm(belt=default_belt){
	bom(str("toothed_20teeth_",belt,"mm"), str("5mm/20t"), ["Hardware"], "http://amzn.eu/d/gU9vKtN");

  spindle=5;
  width=16;
  color("SlateGrey")    toothed_wheel(spindle, width,heith=belt+2);

}


module smooth_idler_5mm(belt=default_belt){
	bom(str("smooth_idler"), str(belt,"mm/5mm/20t"), ["Hardware"], link=str("https://e3d-online.com/gates-powergripr-smooth-idler-",belt,"mm"));

  spindle=5;
  width=16;
  color("SlateGrey")    toothed_wheel(spindle, width, height=belt+2,collar=0);
}

module toothed_idler_5mm(belt=default_belt){
	bom(str("toothed_idler"), str(belt,"mm/5mm/20t"), ["Hardware"], str("https://e3d-online.com/gates-powergripr-toothed-idler-",belt,"mm"));
  spindle=5;
  width=16;
  color("SlateGrey")    toothed_wheel(spindle, width, height=belt+2,collar=0);
}


module toothed_wheel(spindle=8, width=16, height=14, collar=6){
	bom(str("toothed_20teeth_8mm"), str("8mm/20t"), ["Hardware"]);

  collar_width = 16;

  color("SlateGrey")
  difference(){
    union(){
      translate([0,0,0]) cylinder(1,width/2,width/2);
      translate([0,0,1]) cylinder(height,width/2-2,width/2-2);
      translate([0,0,height]) cylinder(1,width/2,width/2);

      if (collar > 0 ) {
        translate([0,0,height])   cylinder(6,collar_width/2,collar_width/2);
      }

    }
    translate([0,0,-0.1]) cylinder(height+2,spindle/2,spindle/2);
  }
}
