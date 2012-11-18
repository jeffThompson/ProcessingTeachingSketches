/*
SIMPLE CLOCK
 Jeff Thompson
 November 2009
 
 An in-class assignment to make a clock using the second(), etc functions
 
 www.jeffreythompson.org
 */

void setup()
{
  size(600,600);
}

void draw()
{

  noStroke();
  //background(100,100,100);    // keeps images from drawing on top of each other
  fill(100,100,100,80);         // makes refresh semi-transparent
  rect(0,0, width,height);      // size of the entire screen

  smooth();

  int s=second();  // the "second();" variable returns the real time 0-59
  int m=minute();  // mintes 0-59
  int h=hour();    // hours 0-23


  // VERSION 1 -- Squares
  fill(h*10);        // makes fill color between 0-59
  rect(0,0, 200,600);

  fill(m*4);
  rect(200,0, 200,600);

  fill(s*4);
  rect(400,0, 200,600);



  // VERSION 2 -- Lines

  strokeWeight(2);          // Make thicker, easier to see
  stroke(0,0,0,127);        // Partially transparent, overlaps all colors
  line(s*10,0, s*10,200);   // Draw lines scaled between 0-600
  line(m*10,200, m*10,400);
  line(h*5,400, h*5,600);

  // try with trails - add square the size of canvas that is partially trans



  // VERSION 3 -- Circles

  // Hours - draw first so behind everything else
  noStroke();
  fill(0,0,0);
  ellipse(width/2,width/2, h*5,h*5);

  // Minutes
  fill(255,0,0,127);                    // Fills red with ~50% trans
  ellipse(width/2,width/2, m*10,m*10);  // Draws a circle starting at 300,300, is s*5 
  // (0-59 * 10 = max of 600 wide)
  // Seconds
  fill(255,255,255,50);
  ellipse(width/2,width/2, s*10,s*10);

  // try all at once

}

/*
In-class assignment:
 
 Make your own clock mechanism that displays the time using shapes, 
 stroke weights, colors, or a combination.
 
 Consider the overall shape of the canvas, the presentation elements, readability, etc.
 */







