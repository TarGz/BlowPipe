
// ----------------------------------------------------------------------------
// Parametric BlowPipe for Nerf dart by @targz Julien Terraz
// It is licensed under the Creative Commons 1.0 Universal
// ----------------------------------------------------------------------------

$fn = 50;
// LENGTH
fix_length          =   30;    // Length of th connectors
fix_ease            =   .2;    // ease between pipe to connect them

// CONNECTOR LENGTH
fix_connector_length=   .5;      // Length ratio // deprecated
fix_connector_length_ratio = .2; // Regarding the pipe length

// PIPE
internal_radius     =   6.7;  // do not change fine for standart Nerf arrow // .5 inch ?
entrance_radius     =   7;    // entrance used to manage the pressure on the arrow in the entrance
entrance_length     =   4;    // entrance length
external_radius     =   9.5;  // radius of the pipe 

// GROOVE
groove_twist        =   45;  // number of rotation per module default:90;
groove_size         =   1;    // Size of the groove (must not be bigger than External radius - Internal radius default:2
groove_number       =   8;    // Number of groove default:4;


// PRIVATE DO NOT EDIT FROM HHERE
groove_angle        =   360 / groove_number;
fix_width           =   2;
fix_pipe_overlap    =   1;
blow_radius         =   external_radius+2;

// GROOVE
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

module main_pipe(pl,asGroove){
        // MAIN PIPE
        length =   pl-fix_length; 
        echo ("main_pipe length",length);
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



// Pipes connector
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

// Blow module
module blow(pl){
    difference(){

         translate([0, 0, fix_length]) {
            union(){
                // LIPS COONTACT PIPE
                translate([0, 0, -fix_length]) difference(){
                    cylinder(fix_length,r=blow_radius);
                    translate([0, 0, -5]) cylinder((fix_length)+10,r=external_radius+fix_ease);
                 }
                 // PRESURE MANAGER
                 union(){
                     // cone down
                     color("grey") translate([0, 0, 0]) difference(){
                        cylinder(entrance_length,r1=blow_radius,r2=external_radius);
                        translate([0, 0, -.1]) cylinder(entrance_length+.2,r1=entrance_radius,r2=external_radius);
                     }         
                     // ring
                     color("black") translate([0, 0, -entrance_length]) difference(){
                        cylinder(entrance_length,r=blow_radius);
                        translate([0, 0, -1]) cylinder(entrance_length+2,r=entrance_radius);
                     }   
                     // cone up
                     color("white") translate([0, 0, -fix_length]) difference(){
                        cylinder(fix_length-entrance_length,r1=blow_radius,r2=blow_radius);
                        translate([0, 0, -.1]) cylinder(fix_length-entrance_length+.2,r1=external_radius,r2=entrance_radius);
                     }   
                }
                 
                 
                 // CONE
                 color("orange")  translate([0, 0, 0]) difference(){
                    cylinder(pl*fix_connector_length_ratio,r1=blow_radius,r2=external_radius);
                    translate([0, 0, -5]) cylinder((pl*fix_connector_length_ratio)+10,r=external_radius);
                 }     
            }  
        }
         // LIPS CURVE   
//         *union(){
//            //cylinder(10,r1=external_radius+10,r2=1);  
//            scale([2.25,1,1])rotate([90,90,0])  translate([8,0,-50]) cylinder(100,r=external_radius); 
//         }
    }  
}

module blowModule(pl,asGroove){
    rotate([180,0,0]) translate([0,0,-pl]) union(){
        blow(pl);
        main_pipe(pl,asGroove);
    }
}

module blowPipe(pl,asGroove){
     rotate([180,0,0]) translate([0,0,-pl]) union(){
        pipeConnector(pl);
        main_pipe(pl,asGroove);
    }
}

// DEMO

module demo(asGroove){
    translate([0,0,0]) blowModule(60,asGroove);
    translate([50,0,0]) blowPipe(90,asGroove);
    translate([100,0,0]) blowPipe(130,asGroove);
    translate([150,0,0]) blowPipe(160,asGroove);
    translate([200,0,0]) blowPipe(190,asGroove);
}


// DEMO
//demo(150);
// Create a blow module
// blowModule(150);
// Create blow pipes
// blowPipe(150);

