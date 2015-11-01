include <import/custom_bearing.scad>
include <picasso_config.scad>

module pen_arm(at) {
  difference(){
    union(){ //Bulk
      cylinder(r=18/2,h=18);
      hull() {
        cylinder(r=30/2,h=10);
        translate([at,0,0])
        cylinder(r=38/2,h=10);
      }
    }
    
    translate([0,0,5]) //Grub Screw CutOut
    rotate([0,180,0])
    translate([0,0,-14])
    union() {
	  translate([0,-5,17])cube([6.2,3,9],center = true);
      translate([0,0,14])rotate([0,90,-90])rotate(30)cylinder(r=1.7,h=30);
      translate([0,-5,14])rotate([0,90,-90])cylinder(r=6.2/2/cos(30),h=3,$fn=6,center=true);
    }

    //TODO add Grub Head cutout

    translate([0,0,-0.5])
    cylinder(r=5.25/2,h=19,$fn=50); //Motor Shaft Cutout

    translate([at,0,1])
    cylinder(r=(32+1)/2,h=10); //Bearing Cutout

    translate([at,0,-0.5])
    cylinder(r=22/2,h=10); //Bearing Shaft Cutout
  }
}

module pen_arm_viz(at){
  pen_arm(at);
  translate([at,0,1])
  bearing(model=6002); // 6002 2RS 15x32x9mm 60022RS
}

//pen_arm(picasso_pen_arm_length);
//pen_arm_viz(picasso_pen_arm_length);