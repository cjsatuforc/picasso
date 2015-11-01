include <MCAD/stepper.scad>
include <picasso_config.scad>

module m8_trap_subtract(){
  nut_trap_depth=8;
  //nut_trap_thickness=6; //6mm wanted
  m8_nut_diameter = 16.4;

  //translate([0,0,nut_trap_thickness])
  //rotate(30)
  cylinder($fn=6,r=m8_nut_diameter/2-0.5,h=nut_trap_depth+1);
}

module nema14_subtract(){
Nema14_sub = [
                [NemaModel, 14],
                [NemaLengthShort, 26*mm], 
                [NemaLengthMedium, 28*mm], 
                [NemaLengthLong, 34*mm], 
                [NemaSideSize, 35.8*mm],  //Wider for tolerance
                [NemaDistanceBetweenMountingHoles, 26*mm], 
                [NemaMountingHoleDiameter, 3*mm], 
                [NemaMountingHoleDepth, 3.5*mm], 
                [NemaMountingHoleLip, -1*mm], 
                [NemaMountingHoleCutoutRadius, 0*mm], 
                [NemaEdgeRoundingRadius, 5*mm], 
                [NemaRoundExtrusionDiameter, 22*mm], 
                [NemaRoundExtrusionHeight, 1.9*mm], //Longer for cut 
                [NemaAxleDiameter, 5*mm], 
                [NemaFrontAxleLength, 18*mm], 
                [NemaBackAxleLength, 10*mm],
                [NemaAxleFlatDepth, 0.5*mm],
                [NemaAxleFlatLengthFront, 15*mm],
                [NemaAxleFlatLengthBack, 9*mm]
         ];

motor(Nema14_sub, NemaShort, dualAxis=false);
//Motor Lip extrusion
translate([0,0,-19])
cylinder(r=11.5, h=25, $fn=30);

//Drill Holes
translate([13,13,-19])
cylinder(r=1.75, h=25, $fn=20);

translate([-13,13,-19])
cylinder(r=1.75, h=25, $fn=20);

translate([13,-13,-19])
cylinder(r=1.75, h=25, $fn=20);

translate([-13,-13,-19])
cylinder(r=1.75, h=25, $fn=20);

}

module motor_arm(al) {
  difference(){
    union() { //BULK
      hull(){
        cylinder(r=15, h=10);

        translate([al,0,10/2])
        cube([40,40,10], center=true);
      }
      cylinder(r=11,h=14);
    }
    //M8 Fixing
    translate([0,0,6])
    m8_trap_subtract(); //M8 Head
    translate([0,0,-1])
    cylinder(r=4.1,h=12); //M8 Shaft

    //NEMA 14 Mount
    translate([al,0,7])
    nema14_subtract();

    //Bolt Hole Heads
    translate([13+al,13,-1])
    cylinder(r=3, h=4.3, $fn=20);

    translate([-13+al,13,-1])
    cylinder(r=3, h=4.3, $fn=20);

    translate([13+al,-13,-1])
    cylinder(r=3, h=4.3, $fn=20);

    translate([-13+al,-13,-1])
    cylinder(r=3, h=4.3, $fn=20);
  }
}

module motor_arm_viz(al) {
  motor_arm(al);
  translate([al,0,7])
  color("Silver") motor(Nema14, NemaShort, dualAxis=false);
}

//motor_arm(picasso_motor_arm_length);
//motor_arm_viz(picasso_motor_arm_length);
