include <globals.scad>;

use <components.scad>;
use <chassis.scad>;
use <vertical.scad>;
use <horizontal.scad>;



union(){
  $DETAIL = D_HIGH;
  
  chassis($fn=40, x,y,h);
  vertical_assy3($fn=40);
  horizontal_assy();
  

*  colour("blue",0.1) translate([(x-400)/2,(y-300)/2,200]) cube([400,300,3]);

}

