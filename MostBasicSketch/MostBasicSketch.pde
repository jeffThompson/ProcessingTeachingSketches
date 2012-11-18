/*

Run a blank sketch, get a 100x100 light gray window.

"TITLE"
Author(s)
Date (or date range)

Simple description here

www.jeffreythompson.org
*/

void setup()                 // Initial and required statement
{                            // Everything contained in the curly brackets is part
                             // An easy error is not including the closing bracket

  size(600,600);             // Sets the overall "canvas" size
  background(255,0,0);       // Changes the background color
  
  // Spacing doesn't matter -- semicolons do!
  // Show how to check reference online -- highlight, ctl click, find in ref
  // Explain how even experts have to check the ref since they can't remember everything
  
  // Variables to declare later:
  int xCoord=140;
  int yCoord=120;
  
  
  println(Hello, World!);    // Makes an error
  println("Hello, World!");  // Needs quotes for words - prints below
  println(45);               // Numbers don't need quotes
  
  
  stroke(0,0,0);
  
  line(100,100,500,100);     // Draw a square with lines
  line(100,100,100,500);
  line(100,500,500,500);
  line(500,100,500,500);
  
  noStroke();                // No outline
  fill(100,0,0);             // Changes fill color
  rect(150,150,200,200);     // Draws a 300x300px rect starting at 150, 150
  
  // Show what happens when the coords are out of the window, then...
  
  // Shows how order makes a difference!
  
  // Show what happens if you forget to turn the stroke back on
  
  stroke(0,0,0);             // Adds outline to anything following
  strokeWeight(2);           // Width of outline is 2px
  noFill();                  // Fill clear (no fill)
  rect(250, 250, 200, 200);  // A 200x200px rect starting at 250, 250
  
  smooth();
  noStroke();                // Turns ouline off again
  fill(255,255,255);         // Fill with white
  ellipse(300, 300, 40, 40); // Draws a 40x40px ellipse starting at 300, 300
  
  // Add the smooth attribute above to see how it effects the ellips
  
  
  // Add the variables at the top
  // No need to explain ints, floats, etc yet - covered in the reading
  
  stroke(0,0,255);
  strokeWeight(2);
  
  point(120,120);              // Can type in coords, or...
  point(xCoord,yCoord);        // ...or use the variables
  point(xCoord+20,yCoord);     // Apply math to the variable
  point(xCoord+40,120);        // Variables and regular coords
  
  println(xCoord);
  
  
  // Use color picker to find a light blue
  fill(30,120,180);
  noStroke();
  // The "width" and "height" variables
  rect(20,20,width-200,height/18);
  
  // A few other shapes
  fill(0,0,0);
  triangle(20,550,20,580,200,580);     // top point, lower L, lower R
  
  fill(255,255,255,127);               // adds alpha channel for overlapping shapes
  quad(20,20, 80,80, 180,80, 120,20);  // upper L, lower L, lower R, upper R
  
}
