/*
First Iteration Example
 Jeff Thompson
 November 2009
 
 A simple (but complicated) wasy to draw repeated shapes
 
 www.jeffreythompson.org
 */

void setup()
{
  size(600,600);
  background(100,100,100);

  // noLoop();
}

void draw()  // Temorarily put the "noLoop();" in setup
{

  int xCoord = 100;
  int yCoord = 100;
  int m = 3;          // "m" is a multiplier to increase the variable
  // by having this we can change one number and apply it to a whole system

  line(xCoord, yCoord, xCoord*m, yCoord*m);  // draws a simple line

  // ... but if we copy/paste this line and add some simple math

  line(xCoord, yCoord, xCoord*m, yCoord*m);
  xCoord = xCoord+10;
  line(xCoord, yCoord, xCoord*m, yCoord*m);
  xCoord = xCoord+10;
  line(xCoord, yCoord, xCoord*m, yCoord*m);
  xCoord = xCoord+10;
  line(xCoord, yCoord, xCoord*m, yCoord*m);
  xCoord = xCoord+10;
  line(xCoord, yCoord, xCoord*m, yCoord*m);
  xCoord = xCoord+10;
  line(xCoord, yCoord, xCoord*m, yCoord*m);
  xCoord = xCoord+10;
  line(xCoord, yCoord, xCoord*m, yCoord*m);
  xCoord = xCoord+10;
  line(xCoord, yCoord, xCoord*m, yCoord*m);
  xCoord = xCoord+10;

  // Other variables could be added in to further complicate our system


  // Could also be applied to something like color, for example:

  int rColor = 0;  // Red color value
  int xValue = 0;  // To increment the X value across the canvas

  fill(rColor, 0, 0);
  rect(xValue,200, 100,200);
  rColor = rColor+40;   // add 40 to the red part of the color
  xValue = xValue+100;  // then add 100 (the width of the square) to the X value

  // Then repeat 5 more times

  fill(rColor, 0, 0);
  rect(xValue,200, 100,200);
  rColor = rColor+40;
  xValue = xValue+100;
  fill(rColor, 0, 0);
  rect(xValue,200, 100,200);
  rColor = rColor+40;
  xValue = xValue+100;
  fill(rColor, 0, 0);
  rect(xValue,200, 100,200);
  rColor = rColor+40;
  xValue = xValue+100;
  fill(rColor, 0, 0);
  rect(xValue,200, 100,200);
  rColor = rColor+40;
  xValue = xValue+100;
  fill(rColor, 0, 0);
  rect(xValue,200, 100,200);
  rColor = rColor+40;
  xValue = xValue+100;

  // Random values - spice it up!

  // this is the basic syntax: random(0,255); - creates a random number between 0-255
  // however this is simpler

  float randFloatColor=random(0,255);
  int randColor = int(randFloatColor);

  xValue = 0;  // re-declare xValue 

  fill(randColor, 0, 0);
  rect(xValue,0, 100,200);
  xValue = xValue+100;
  randFloatColor=random(0,255);    // no longer needs "float" in front, just changing value
  randColor = int(randFloatColor);

  // Repeat five more times

  fill(randColor, 0, 0);
  rect(xValue,0, 100,200);
  xValue = xValue+100;
  randFloatColor=random(0,255);
  randColor = int(randFloatColor);   

  fill(randColor, 0, 0);
  rect(xValue,0, 100,200);
  xValue = xValue+100;
  randFloatColor=random(0,255);
  randColor = int(randFloatColor);   

  fill(randColor, 0, 0);
  rect(xValue,0, 100,200);
  xValue = xValue+100;
  randFloatColor=random(0,255);
  randColor = int(randFloatColor);   

  fill(randColor, 0, 0);
  rect(xValue,0, 100,200);
  xValue = xValue+100;
  randFloatColor=random(0,255);
  randColor = int(randFloatColor);   

  fill(randColor, 0, 0);
  rect(xValue,0, 100,200);
  xValue = xValue+100;
  randFloatColor=random(0,255);
  randColor = int(randFloatColor);    

  delay(1000);    // don't forget to remove the "noLoop()" function

}

/*
In-class assignment:
 
 Create three rows or columns of shapes (rects, triangles, circles, lines, etc) using
 iterative math (adding to a value)
 
 Change the color or stroke of each successive shape also using math
 
 Use the random() and delay() functions to make the color or size shift
 
 Feel free to use the above as a template
 
 */


