
// ----------------------------------------------------------------------------
// Parametric BlowPipe for Nerf arrows by @targz Julien Terraz
// It is licensed under the Creative Commons 1.0 Universal
// ----------------------------------------------------------------------------


// LENGTH
number_of_pipe=4;
printer_max_height = 150;
fix_length=30;
fix_connector_length=printer_max_height/2;


// PIPE
internal_radius     = 7; // do not change fine for standart Nerf arrow
entrance_radius   = 6.5; // manage the pressure on the arrow in the entrance
external_radius     = 9; 



// GROOVE
groove_twist = 180; // number of rotation per module default:90;
groove_size = 2;  // Size of the groove (must not be bigger than External radius - Internal radius default:2
groove_number = 5; // Number of groove default:4;


// PRIVATE DO NOT EDIT FROM HHERE
groove_angle = 360/groove_number;
fix_ease=1; //
fix_width = external_radius-internal_radius;

fix_pipe_overlap=1;

length = printer_max_height-fix_length; // total length of the BlowPipe
blow_radius = external_radius+5;

// GROOVE
module groove(){
    linear_extrude(height = length, center = false, convexity = 1, twist = groove_twist)
        translate([internal_radius+groove_size/2, 0, 0])
        rotate([0,0,-135]) polygon(points=[[0,0],[groove_size,0],[0,-groove_size]], paths=[[0,1,2]]);
}


module grooves(){
    union() for ( i = [0 : groove_number] ){
        rotate([0,0,groove_angle*i]) groove();
    } 
}

module main_pipe(){
            // MAIN PIPE
        translate([0, 0, fix_length])  
            difference(){
                difference(){
                    cylinder(length,r=external_radius);
                    translate([0, 0, -5]) cylinder(length+10,r=internal_radius);
                }
                grooves();
            }  
}




module pipeConnector(){
    
     translate([0, 0, fix_length]) {
        // FIX PIPE
        translate([0, 0, -fix_length]) difference(){
            cylinder(fix_length,r1=external_radius+fix_width+fix_ease-1,r2=external_radius+fix_width+fix_ease);
            translate([0, 0, -5]) cylinder((fix_length)+10,r=external_radius+fix_ease);
         }
         // FIX CONNECTOR
         translate([0, 0, 0]) difference(){
            cylinder(fix_connector_length,r1=external_radius+fix_width+fix_ease,r2=external_radius);
            translate([0, 0, -5]) cylinder((fix_connector_length)+10,r=external_radius);
         }     
     }
}

module blow(){
    difference(){

         translate([0, 0, fix_length]) {
            union(){
                // FIX PIPE
                
                translate([0, 0, -fix_length]) difference(){
                    cylinder(fix_length,r=blow_radius);
                    translate([0, 0, -5]) cylinder((fix_length)+10,r=external_radius+fix_ease);
                 }
                 // FIX CONNECTOR
                 translate([0, 0, 0]) difference(){
                    cylinder(fix_connector_length,r1=blow_radius,r2=external_radius);
                    translate([0, 0, -5]) cylinder((fix_connector_length)+10,r=external_radius);
                 }     
            }  
        }
         // CONE   
         union(){
            //cylinder(10,r1=external_radius+10,r2=1);  
            scale([2.25,1,1])rotate([90,90,0])  translate([0,0,-50]) cylinder(100,r=external_radius); 
         }
    }  
}

module blowPipe(){
    blow();
    main_pipe();
}

module pipe(){
     union(){
        pipeConnector();
        main_pipe();
    }
}

module pipes(){
    
    for ( i = [0 : number_of_pipe-1] ){
        if(i==0){
            blowPipe();
        }else{
            translate([(i*external_radius)*5,0,0]) pipe();
        }
    }
}

// MAIN
rotate([180,0,0]) translate([0,0,-printer_max_height]) pipes();
