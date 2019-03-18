include <globals.scad>;

use <components.scad>;
use <chassis.scad>;
use <vertical.scad>;
use <horizontal.scad>;




$fn=150;
// XCarriage End
leftXCa();

// CornerIdlerBracket
*cornerIdler1();

// CornerIdlerBracket
*cornerIdler2();


*tubeHolder();

*stepperBracket();

*stepperBracketPadding(2);
