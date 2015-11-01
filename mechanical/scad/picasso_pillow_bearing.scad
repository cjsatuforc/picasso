include <MCAD/bearing.scad>
include <MCAD/nuts_and_bolts.scad>
include <BOLTS/BOLTS.scad>
include <picasso_config.scad>

module bearing_vitamin(at) {
   m8_b_l = 40;  //m8 bolt length
   m8_w_t = 1.6; //m8 washer thickness
   m8_n_t = 6.8; //m8 nut thickness
   bear_t = 7;   //bearing thickness

   //Top Washer
   translate([0,0,m8_b_l-at -(m8_w_t)])
   ISO7089("M8"); //M8 Washer d1=8.4 d2=14 t=1.6

   //Second Washer
   translate([0,0,m8_b_l-at -(2*m8_w_t)])
   ISO7089("M8"); //M8 Washer d1=8.4 d2=14 t=1.6

   //First Bearing
   translate([0,0,m8_b_l-at -(2*m8_w_t)-(bear_t)])
   bearing(model=608);

   //First Nut
   translate([0,0,m8_b_l-at -(2*m8_w_t)-(bear_t)-(m8_n_t)])
   ISO4032("M8"); //M8 Nut t= 6.8 cylinder diameter 14.38

   //Second Bearing
   translate([0,0,m8_b_l-at -(2*m8_w_t)-(2*bear_t)-(m8_n_t)])
   bearing(model=608);

   //Last Washer
   translate([0,0,m8_b_l-at -(3*m8_w_t)-(2*bear_t)-(m8_n_t)])
   ISO7089("M8"); //M8 Washer d1=8.4 d2=14 t=1.6

   //Last Nut
   translate([0,0,m8_b_l-at -(3*m8_w_t)-(2*bear_t)-(2*m8_n_t)])
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
   translate([0,0,m8_b_l-at -(m8_w_t)])
   cylinder(r=9,h=1.6); //M8 Washer d1=8.4 d2=14 t=1.6

   //Second Washer
   translate([0,0,m8_b_l-at -(2*m8_w_t)-0.1])
   cylinder(r=9,h=4); //M8 Washer d1=8.4 d2=14 t=1.6

   //First Bearing
   translate([0,0,m8_b_l-at -(2*m8_w_t)-(bear_t)])
   cylinder(r=11.3,h=7);

   //First Nut
   translate([0,0,m8_b_l-at -(2*m8_w_t)-(bear_t)-(m8_n_t)])
   cylinder(r=8,h=6.8); //M8 Nut t= 6.8 cylinder diameter 14.38

   //Second Bearing
   translate([0,0,m8_b_l-at -(2*m8_w_t)-(2*bear_t)-(m8_n_t)])
   cylinder(r=11.3,h=7);

   //Last Washer
   translate([0,0,m8_b_l-at -(3*m8_w_t)-(2*bear_t)-(m8_n_t)-0.4])
   cylinder(r=9,h=2.1);//M8 Washer d1=8.4 d2=14 t=1.6

   //Last Nut
   translate([0,0,m8_b_l-at -(3*m8_w_t)-(2*bear_t)-(2*m8_n_t)-10])
   cylinder(r=8,h=6.8+35); //M8 Nut t= 6.8 cylinder diameter 14.38
 }
}

module pillow_half(type,at){
difference(){
  difference() {
    hull(){ //BULK Material
      translate([0,0,(40-at-1)/2])
      cube([15,40,40-at-1], center=true);
      cylinder(r1=15,r2=15,h=40-at-1);
      
      rotate([0,0,-45]) 
      //translate([-25,20,0])
      translate([-30,-10,0])
      cube([15,10,8]);
      
      rotate([0,0,45])  
      //translate([-25,-30,0])
      translate([-30,0,0])
      cube([15,10,8]);  

    }
    bearing_vitamin_subtract(at); //Bearing vitamin gap.

    //Horiz Screw Holes
    translate([0,-15.5,13.5]) // 1
    rotate([0,-90,0])
    nut_bolt_subtract(type);
    translate([0,-15.5,27])   // 2
    rotate([0,-90,0])
    nut_bolt_subtract(type);
    
    translate([0,15.5,13.5]) // 3
    rotate([0,-90,0])
    nut_bolt_subtract(type);
    translate([0,15.5,27])   // 4
    rotate([0,-90,0])
    nut_bolt_subtract(type);

  }
  translate([-0.5,-50, -1]) //Cut Bulk in Half and take a chunk out
  cube([16,100,40]);
}
}

module nut_bolt_subtract (type) {
   cylinder(r=1.55,h=3.6,$fn=20); //Thread Cutout
   if (type == "NUT"){
     translate([0,0,3.5])
     cylinder(r=5.5 / 2 / cos(180 / 6) + 0.05, h=4.1, $fn=6);
     translate([0,0,3.5+4])
     cylinder(r=3.75,h=30,$fn=20);
   } else {
     translate([0,0,3.5])
     cylinder(r=3.75,h=34,$fn=20);
   }
}

module print_tray ( at) {
translate([5,0,-0.5])
rotate([0,90,0])
pillow_half("NUT",at);

translate([-5,0,-0.5])
rotate([0,90,180])
pillow_half("HEAD",at);
}

module pillow_bearing_viz( at) {
rotate([0,0,30])
color("Silver") bearing_vitamin(at);
pillow_half("NUT",at);
rotate([0,0,180])
pillow_half("HEAD",at);
}

//pillow_bearing_viz(picasso_bearing_head_gap);
//print_tray(picasso_bearing_head_gap);