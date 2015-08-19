# Nerf Dart Parametric BlowPipe (WIP)
> Inspire by [Franck Youdine](https://twitter.com/fyoudine) Nerf dart paper blowpipe 






## ABOUT

Nerf dart are fun, specially in office opens pace, but Nerf gun are not very powerful and not accurate at all.
We have used them a lot in the office and then Franck Youdine made a paper blowpipe to send dart. It was so accurate and so powerful that I decided to build one using my 3D printer.

The longer the pipe the more it will be accurate, it was a bit challenging to print a long pipe has pipe need to be printed vertically. That were I came with the idea of module that could be connected and printed separately.

![image](img/preview.jpg)

Depending of you printer maximum print height use the script to generate module of the perfect height. The blow module is make the pipe confortable and efficient.

To stabilise the dart during the flight I get this idea of [Rifling](https://en.wikipedia.org/wiki/Rifling) so you have a option to add some groove inside the pipe. Still not sure of the efficiency, I need to get a high frame rate camera to check if the dart rotate during the flight.

![image](img/groove.jpg)

## REQUIREMENTS

You will need [OpenScad](http://www.openscad.org/) free software to generate the blowpipes.

## USAGE

![image](img/usage.jpg)


## OpenScad API


> First you need to include the lib

```
include <blowpipe.scad>;
```

> see the demo


```
/**
 * @param {boolean} HasGroove
 */
demo(true); 
```

> Generate the blow module

```
/**
 * @param {number} PipeLength
 * @param {boolean} HasGroove
 */
blowModule(length,groove); 
```

> Generate pipes

```
/**
 * @param {number} PipeLength
 * @param {boolean} HasGroove
 */
blowPipe(length);
```

## ADVANCED PARAMETERS

```
// SETTINGS
$fn                 =   50;          // Mesh quality (number of fragments )    
fix_length          =   30;          // Length of the connectors
fix_length_blow     =   5;      
fix_ease            =   .2;          // ease between pipe to connect them

// CONNECTOR LENGTH
fix_connector_length=   .5;         // Length ratio // deprecated
fix_connector_length_ratio = .2;    // Regarding the pipe length

// PIPE
internal_radius     =   6.7;        // do not change fine for standart Nerf arrow // .5 inch ?
external_radius     =   9.5;        // radius of the pipe 

// ENTRANCE 
/**
Used to compress the dart inside the pipe to maximyse the pressure
**/
entrance_radius     =   6.5;        // entrance used to manage the pressure on the arrow in the entrance
entrance_length     =   20;         // entrance length

// GROOVE
groove_twist        =   45;         // number of rotation per module default:90;
groove_size         =   1;          // Size of the groove (must not be bigger than External radius - Internal radius default:2
groove_number       =   8;          // Number of groove default:4;
```



## PRINTING

Those part should be printed as they came out of the script without any support.
infill			: 10%
layer heigth	: 0.3mm

