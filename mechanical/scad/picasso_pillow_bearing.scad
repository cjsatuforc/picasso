include <MCAD/bearing.scad>
include <MCAD/nuts_and_bolts.scad>
include <BOLTS/BOLTS.scad>

arm_thickness = 6;

module bearing_vitamin(at) {
   arm_t = at;
   m8_b_l = 40;  //m8 bolt length
   m8_w_t = 1.6; //m8 washer thickness
   m8_n_t = 6.8; //m8 nut thickness
   bear_t = 7;   //bearing thickness

   //Top Washer
   translate([0,0,m8_b_l-arm_thickness -(m8_w_t)])
   ISO7089("M8"); //M8 Washer d1=8.4 d2=14 t=1.6

   //Second Washer
   translate([0,0,m8_b_l-arm_thickness -(2*m8_w_t)])
   ISO7089("M8"); //M8 Washer d1=8.4 d2=14 t=1.6

   //First Bearing
   translate([0,0,m8_b_l-arm_thickness -(2*m8_w_t)-(bear_t)])
   bearing(model=608);

   //First Nut
   translate([0,0,m8_b_l-arm_thickness -(2*m8_w_t)-(bear_t)-(m8_n_t)])
   ISO4032("M8"); //M8 Nut t= 6.8 cylinder diameter 14.38

   //Second Bearing
   translate([0,0,m8_b_l-arm_thickness -(2*m8_w_t)-(2*bear_t)-(m8_n_t)])
   bearing(model=608);

   //Last Washer
   translate([0,0,m8_b_l-arm_thickness -(3*m8_w_t)-(2*bear_t)-(m8_n_t)])
   ISO7089("M8"); //M8 Washer d1=8.4 d2=14 t=1.6

   //Last Nut
   translate([0,0,m8_b_l-arm_thickness -(3*m8_w_t)-(2*bear_t)-(2*m8_n_t)])
   ISO4032("M8"); //M8 Nut t= 6.8 cylinder diameter 14.38

   // M8 Bolt
   translate([0,0,m8_b_l])
   rotate([0,180,0])
   DIN931("M8", l=m8_b_l); // M8 x 40mm Bolt
}

module bearing_vitamin_subtract(at){
  arm_t = at;
   m8_b_l = 40;  //m8 bolt length
   m8_w_t = 1.6; //m8 washer thickness
   m8_n_t = 6.8; //m8 nut thickness
   bear_t = 7;   //bearing thickness
 union(){
   //Top Washer
   translate([0,0,m8_b_l-arm_thickness -(m8_w_t)])
   cylinder(r=9,h=1.6); //M8 Washer d1=8.4 d2=14 t=1.6

   //Second Washer
   translate([0,0,m8_b_l-arm_thickness -(2*m8_w_t)-0.1])
   cylinder(r=9,h=4); //M8 Washer d1=8.4 d2=14 t=1.6

   //First Bearing
   translate([0,0,m8_b_l-arm_thickness -(2*m8_w_t)-(bear_t)])
   cylinder(r=11.3,h=7);

   //First Nut
   translate([0,0,m8_b_l-arm_thickness -(2*m8_w_t)-(bear_t)-(m8_n_t)])
   cylinder(r=8,h=6.8); //M8 Nut t= 6.8 cylinder diameter 14.38

   //Second Bearing
   translate([0,0,m8_b_l-arm_thickness -(2*m8_w_t)-(2*bear_t)-(m8_n_t)])
   cylinder(r=11.3,h=7);

   //Last Washer
   translate([0,0,m8_b_l-arm_thickness -(3*m8_w_t)-(2*bear_t)-(m8_n_t)])
   cylinder(r=9,h=1.7);//M8 Washer d1=8.4 d2=14 t=1.6

   //Last Nut
   translate([0,0,m8_b_l-arm_thickness -(3*m8_w_t)-(2*bear_t)-(2*m8_n_t)-10])
   cylinder(r=8,h=6.8+35); //M8 Nut t= 6.8 cylinder diameter 14.38
 }
}

module pillow_half(side,at){
difference(){
  difference() {
    hull(){
      translate([0,0,(40-at-1)/2])
      cube([15,40,40-at-1], center=true);
      cylinder(r1=15,r2=15,h=40-at-1);
    }
    bearing_vitamin_subtract(at);
  }
  translate([0,-21, -1])
  cube([16,42,40]);
}
}

//color("Silver") bearing_vitamin(arm_thickness);
//bearing_vitamin_subtract(arm_thickness);
pillow_half("NUT",arm_thickness);