include <picasso_config.scad>
include <picasso_motor_arm.scad>
include <picasso_pillow_bearing.scad>


pillow_bearing_viz(picasso_bearing_head_gap);
translate([0,0,40-picasso_bearing_head_gap])
motor_arm_viz(picasson_motor_arm_length);
