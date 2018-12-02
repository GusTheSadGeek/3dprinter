include <globals.scad>;

use <bom/bom.scad>;
use <cornerBracket.scad>;




   
module Angle(length=100,width=10,thickness=2){
    bom(str("Angle"), str("Angle l="+length+"width="+width+"thickness="+thickness), ["Hardware"]);
    color("green") cube([length,thickness,width]);
    color("green") cube([length,width,thickness]);
}











