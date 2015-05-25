
/*
GRADIENT
Jeff Thompson | 2015 | www.jeffreythompson.org

Draws a gradient between two colors using a series 
of 1px-thick lines. The color is changed gradually 
using lerpColor(), which takes two colors and a 
value between 0-1 to set an intermediate color.

*/

color start = color(25,180,255);
color end =   color(215,150,0);


void setup() {
  size(800,800);
  
  // no background() command - gradient instead!
  for (int y=0; y<height; y++) {
    
    // we need a value between 0-1 for lerpColor()
    // here we use map() to convert y into the right range
    float interval = map(y, 0,height, 0,1);
    
    // set the color and draw a horizontal line
    color c = lerpColor(start, end, interval);
    stroke(c);
    line(0,y, width,y);
  }
}


