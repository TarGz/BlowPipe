# Parametric BlowPipe 
> Works fine with Nerf dart



## USAGE

BlowPipe should be 1 meter long idealy, for the ease of printing the pipe is splitted in part.
Part should be printed vertically and each part should be as long as possible. 
That's why the main parameter of the script is the maximum print height of your printer.


> Include the lib

```
include <blowpipe.scad>;
```

> see the demo


```
demo(150); 
```

> Generate the blow module

```
blowModule(150); 
```

> Generate pipes

```
blowPipe(150);
```

## parameter

150 is for the length of the pipe the max value depend of the capacity of your printer min is 50;

## Printing
Those part should be printed as they came out of the script without any support and a small infill around 10% is ok.
