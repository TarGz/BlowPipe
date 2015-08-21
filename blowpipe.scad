
/* ---------------------------------------------------------------------------- */
/*                                                                              */
/*                                                                              */
/*      Parametric BlowPipe for Nerf dart by @targz (Julien Terraz)             */
/*      It is licensed under the Creative Commons 1.0 Universal                 */
/*                                                                              */
/*                                                                              */
/* ---------------------------------------------------------------------------- */


/* ---------------------------------------------------------------------------- */
/*                                 SETTINGS                                     */
/* ---------------------------------------------------------------------------- */


$fn                 =   50;          // Mesh quality (number of fragments )
fix_length          =   30;          // Length of th connectors
fix_ease            =   .15;         // ease between pipe to connect them

/** PIPE **/
internal_radius     =   6.7;        // do not change fine for standart Nerf arrow // .5 inch ?
external_radius     =   9.5;        // radius of the pipe 

/** ENTRANCE  **/
entrance_radius     =   6.5;        // Manage the pressure on the arrow in the entrance, more pressure = more speed = harder to blow.
entrance_length     =   20;         // entrance length sould also have an impact on speed.

// GROOVE
groove_twist        =   45;         // number of rotation per module default:90;
groove_size         =   1;          // Size of the groove (must not be bigger than External radius - Internal radius default:2
groove_number       =   4;         // Number of groove default:4;



/* ---------------------------------------------------------------------------- */
/*                                   PUBLIC                                     */
/* ---------------------------------------------------------------------------- */

/**  BLOW MODULE
 *
 * @param {number} PipeLength
 * @param {boolean} HasGroove
 */
module blowModule(pl,asGroove){
    color("red") rotate([180,0,0]) translate([0,0,-pl]) union(){
        blow(pl);
        main_pipe(pl,asGroove);
    }
}

/** BLOW PIPE   
 * 
 * @param {number} PipeLength
 * @param {boolean} HasGroove
 */
module blowPipe(pl,asGroove){
     color("white") rotate([180,0,0]) translate([0,0,-pl]) union(){
        pipeConnector(pl);
        main_pipe(pl,asGroove);
    }
}


/** DEMO
 * 
 * @param {boolean} hasGroove
 */
module demo(asGroove){
    translate([0,0,0])      blowModule(60,asGroove);
    translate([50,0,0])     blowPipe(90,asGroove);
    translate([100,0,0])    blowPipe(130,asGroove);
    translate([150,0,0])    blowPipe(160,asGroove);
    translate([200,0,0])    blowPipe(190,asGroove);
}

/* ---------------------------------------------------------------------------- */
/*              ADVANCED SETTING FROM HERE DO NOT EDIT                          */
/* ---------------------------------------------------------------------------- */


groove_angle                =   360 / groove_number;
fix_width                   =   2;
fix_pipe_overlap            =   1;
blow_radius                 =   external_radius+2;
fix_length_blow             =   5;                      // length of the blow module connector
fix_connector_length        =   .5;         // Length ratio // deprecated
fix_connector_length_ratio  =   .2;    // Regarding the pipe length


/* ---------------------------------------------------------------------------- */
/*                                   PRIVATE                                    */
/* ---------------------------------------------------------------------------- */


/** GROOVES
 *
 * @param {number} PipeLength
 */
module groove(pl){
    length =   pl-fix_length; 
    linear_extrude(height = length, center = false, convexity = 1, twist = groove_twist)
        translate([internal_radius+groove_size/2, 0, 0])
        rotate([0,0,-135]) polygon(points=[[0,0],[groove_size,0],[0,-groove_size]], paths=[[0,1,2]]);
}
module grooves(pl){
    color("white") union() for ( i = [0 : groove_number] ){
        rotate([0,0,groove_angle*i]) groove(pl);
    } 
}

/** MAIN PIPE
 *
 * @param {number} PipeLength
 * @param {boolean} HasGroove
 */
module main_pipe(pl,asGroove){
        // MAIN PIPE
        length =   pl-fix_length; 
        translate([0, 0, fix_length])  
            difference(){
                color("red") difference(){
                    cylinder(length,r=external_radius);
                    translate([0, 0, -5]) cylinder(length+10,r=internal_radius);
                }
                echo("asGroove",asGroove);
                if(asGroove) grooves(pl);
            }  
}

/** PIPES CONNECTOR
 *
 * @param {number} PipeLength
 */
module pipeConnector(pl){
     translate([0, 0, fix_length]) {
        radius1 = external_radius+fix_width+fix_ease;
        // FIX PIPE
        color("grey")  translate([0, 0, -fix_length]) difference(){
            cylinder(fix_length,r1=external_radius+fix_width+fix_ease-1,r2=radius1);
            translate([0, 0, -5]) cylinder((fix_length)+10,r=external_radius+fix_ease);
         }
        // FIX CONNECTOR
        color("orange")  translate([0, 0, 0]) difference(){
            cylinder(pl*fix_connector_length_ratio,r1=radius1,r2=external_radius);
            translate([0, 0, -5]) cylinder((pl*fix_connector_length_ratio+10),r=external_radius);
         }     
     }
}

/** BLOW MODULE
 * 
 * @param {number} PipeLength
 */
module blow(pl){
    difference(){

         translate([0, 0, fix_length]) {
            union(){
                color("DeepSkyBlue") translate([0, 0, -fix_length-fix_length/3]) difference(){
                    cylinder(fix_length/2,r1=lipsRadius,r2=external_radius);
                    translate([0, 0, -5]) cylinder((fix_length/2)+10,r=blow_radius);
                 }
                 // PRESURE MANAGER
                 union(){
                     // cone down
                     color("DeepSkyBlue") translate([0, 0, 0]) difference(){
                        cylinder(entrance_length,r1=blow_radius,r2=external_radius);
                        translate([0, 0, -.1]) cylinder(entrance_length+.2,r1=entrance_radius,r2=external_radius);
                     }         
                     // ring
                     color("MidnightBlue") translate([0, 0, -entrance_length]) difference(){
                        cylinder(entrance_length,r=blow_radius);
                        translate([0, 0, -1]) cylinder(entrance_length+2,r=entrance_radius);
                     }   
                     // cone up
                     color("CadetBlue") translate([0, 0, -fix_length_blow-entrance_length]) difference(){
                        cylinder(fix_length_blow,r1=blow_radius,r2=blow_radius);
                        translate([0, 0, -.1]) cylinder(fix_length_blow+.2,r1=external_radius,r2=entrance_radius);
                     }   
                }
                // LIPS CONTACT SURFACE
                translate([0, 0, 8-fix_length_blow-entrance_length]){
                    color("white") difference(){
                        rotate([180,0,0])  import("stl/lips.stl", convexity = 5);
                        translate([0, 0, -pl/2]) cylinder((pl)+10,r=external_radius);
                    }
                } 
            }  
        }

    }  
}




