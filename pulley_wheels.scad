include <globals.scad>;
use <bom/bom.scad>;

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

module toothed_20teeth_5mm(){
	bom(str("toothed_20teeth_6mm"), str("5mm/20t"), ["Hardware"], "http://amzn.eu/d/gU9vKtN");
  
  spindle=5;
  width=16;
  color("SlateGrey")    toothed_wheel(spindle, width);
  
}


module smooth_5mm(){
	bom(str("smoth_5mm"), str("5mm/20t"), ["Hardware"], "http://amzn.eu/d/9o6fP6xN");
  
  spindle=5;
  width=16;
  color("SlateGrey")    toothed_wheel(spindle, width, collar=0);
  
}




module toothed_wheel(spindle=8, width=16, height=14, collar=6){
	bom(str("toothed_20teeth_8mm"), str("8mm/20t"), ["Hardware"]);

  collar_width = 16;
  
  color("SlateGrey")    
  difference(){
    union(){
      translate([0,0,0]) cylinder(1,width/2,width/2);
      translate([0,0,1]) cylinder(7,width/2-2,width/2-2);
      translate([0,0,8]) cylinder(1,width/2,width/2);

      if (collar > 0 ) {
        translate([0,0,9])   cylinder(6,collar_width/2,collar_width/2);
      }

    }
    translate([0,0,-0.1]) cylinder(14.2,spindle/2,spindle/2);
  }
}
