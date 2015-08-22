

=====
```
 		 ____   ____    _    ____    ____  _     ___  ______        ______ ___ ____  _____ 
 		/ ___| / ___|  / \  |  _ \  | __ )| |   / _ \|  _ \ \      / /  _ \_ _|  _ \| ____|
 		\___ \| |     / _ \ | | | | |  _ \| |  | | | | |_) \ \ /\ / /| |_) | || |_) |  _|  
 		 ___) | |___ / ___ \| |_| | | |_) | |__| |_| |  __/ \ V  V / |  __/| ||  __/| |___ 
 		|____/ \____/_/   \_\____/  |____/|_____\___/|_|     \_/\_/  |_|  |___|_|   |_____|	                                                       
	

```

=======



# A Parametric BlowPipe that works with Nerf Elite Dart
> Inspire by [Franck Youdine](https://twitter.com/fyoudine) Nerf darts paper blowpipe 

![image](img/usage.jpg)

## DISCLAIMER

You are using this at your own risks, darts are relatively safe but can still hurts eyes. I can not been made responsible of any stupid things you will do with this. 


## LICENSE

[![Creative Commons License](https://i.creativecommons.org/l/by-nc/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc/4.0/)

Scad BlowPipe by [@targz](https://twitter.com/TarGz) is licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/).

## ABOUT

This project have been tested and developed to fire Nerf Elite Dart but may be adapted to fire darts in the futur.  

Foam darts are fun, specially in office opens pace, but dart gun are not very powerful and not accurate at all.
We have used them a lot in the office and then Franck Youdine made a paper blowpipe to send darts. It was so accurate and so powerful that I decided to build one using my 3D printer.

![image](img/preview.jpg)

The longer the pipe the more it will be accurate, it was a bit challenging to print a long pipe has pipe need to be printed vertically. That were I came with the idea of module that could be connected and printed separately.

Depending of you printer maximum print height you can use the script to generate pipe of the perfect height. The blow module make the pipe confortable and efficient.

To stabilise the darts during the flight I get this idea of [Rifling](https://en.wikipedia.org/wiki/Rifling) so you have an option to add some groove inside the pipe. Still not sure of the efficiency, I need to get a high frame rate camera to check if the darts are rotating during the flight.

![image](img/groove.jpg)


## REQUIREMENTS

You will need:

- [OpenScad](http://www.openscad.org/) free software to generate the blowpipes stl.
- A 3D printer and some PLA
- Some Nerf Elite Dart

## How to

After installing [OpenScad](http://www.openscad.org/) just use it to open the ```demo.scad``` file.
The screen should preview the pipe below. 




Then use the code below or uncomment different part of the demo file to generate your pipes.


>  First you need to include the lib

```
include <scad_blowpipe.scad>;
```

## check the demo


```
/**
 * @param {boolean} HasGroove
 */
demo(true); 
```

## generate the blow module

```
/**
 * @param {number} PipeLength
 * @param {boolean} HasGroove
 */
blow(length,groove); 
```

##  generate pipes

```
/**
 * @param {number} PipeLength
 * @param {boolean} HasGroove
 */
pipe(length,groove);
```

## ADVANCED PARAMETERS

```

/** LENGTH **/
$fn                 =   50;         // Mesh quality (number of fragments ) default:50
fix_length          =   20;         // Length of the connectors default:20
fix_ease            =   .15;        // ease between pipe to connect them default:0.15

/** PIPE **/
internal_radius     =   6.7;        // fine for standard Nerf arrow // .5 inch ? default:6.7
external_radius     =   9.5;        // radius of the pipe  default:9.5

/** ENTRANCE  **/
entrance_radius     =   6.5;        // Manage the pressure on the arrow in the entrance, more pressure = more speed = harder to blow. default:6.5
entrance_length     =   20;         // entrance length should also have an impact on speed. defaulot:20

/** GROOVE  **/
groove_twist        =   45;         // number of rotation per module default:45;
groove_size         =   1;          // Size of the groove (must not be bigger than External radius - Internal radius default:1
groove_number       =   16;         // Number of groove default:16;



```


## 3D PRINTING

Those part should be printed as they came out of the script without any support.

```
material 			: PLA
infill				: 10% 
layer heigth		: 0.3mm
Top solid layer 	: 3
Bottom solid layer 	: 3
Outline perimeter 	: 2
```

