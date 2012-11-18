COLLISION DETECTION FUNCTIONS
Written by Jeff Thompson (www.jeffreythompson.org)
Version 0.9
Updated Nov 30, 2011

- - -

DESCRIPTION
A set of functions to do basic 2d collision detection in Processing (www.processing.org).

While some tools already exist, like the excellent Box2D, the source code is not easy to understand and the implementation is a bit complex.  Other examples (equally great), like the line-line collision in the toxiclibs collection, use vector math which isn't great for us "creative programmers" (ie: those who got bad grades in high school math).  

Instead, these tools can be used as simple, one-line commands to determine whether two objects have collided.  Designed for simple games and interactive systems, they are intended to be building blocks for larger projects.

Enjoy!

- - -

HOW TO USE
The example sketches are more fully-featured uses of the collision functions.  To use the functions themselves, follow these steps:

1. Open the function you want to use (ex: "pointPoint.pde) - NOT the example file
2. Copy the code
3. Paste the code into your sketch after the end of the draw function

Note: you can also paste the code into a new tab, which will be a bit cleaner to use

- - -

CURRENT FUNCTIONS:
All functions return a simple true/false value whether there is collision or not.  In many cases, code is included to also return the point of collision.

+  Point/Point
+  Point/Rect
+  Point/Ball*

+  Rect/Rect
+  Ball/Ball*
+  Ball/Rect*

+  Point/Line
+  Line/Line
+  Ball/Line*

* A "ball" is defined as a circle - ellipses are really hard!

The included example sketches should demonstrate the basic functionality.

- - -

REQUESTS and BUG REPORTING
A few things that would be great, but were just a little (or a lot) complex to include at this point:

+ Ellipses
+ Triangles
+ Polygons
+ Curved lines (definitely not happening any time soon!)

A library may be in the works as well, but having never done anything like that before, it seemed better to release the code early and often.

Finding that something is missing?  Wish list?  Major error?  Little one?
Email me at mail [at] jeffreythompson [dot] org.

- - -

THANKS TO
Several online tutorials and examples were used for the more confusing examples.  A special thanks goes to:

Paul Bourke
http://paulbourke.net/geometry/lineline2d

+ Ibackstrom
  http://community.topcoder.com/tc?module=Static&d1=tutorials&d2=geometry2

+ Philip Nicoletti
  http://www.codeguru.com/forum/showthread.php?threadid=194400

+ Matt Worden
  http://vband3d.tripod.com/visualbasic/tut_mixedcollisions.htm

- - -

LICENSE and USE
This code is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.  Feel free to use and hack, but please give credit and let me know if you do something particularly fantastic!

- - -

www.jeffreythompson.org

