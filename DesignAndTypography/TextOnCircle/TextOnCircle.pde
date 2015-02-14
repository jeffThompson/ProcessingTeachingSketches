
/*
TEXT ON CIRCLE
Jeff Thompson | 2015 | www.jeffreythompson.org

Writing text along a circle.

*/

String s =             "Hello, world!";     // some text to display
float startAngle =     radians(0);          // starting position (easier to think in degrees)
float letterSpacing =  radians(10);         // how far apart to make the letters
float dia =            300;                 // diameter of the circle

PFont font;


void setup() {
  
  // basic setup, create font
  size(600, 600);
  background(255);
  font = createFont("Helvetica", 24);
  textFont(font, 24);
  textAlign(CENTER);

  // draw circular path
  noFill();
  stroke(0, 100);
  ellipse(width/2,height/2, dia,dia);

  // draw text!
  fill(0);
  noStroke();
  pushMatrix();
  translate(width/2, height/2);            // move to center (can be any point)
  rotate(startAngle);                      // rotate to starting angle
  for (int i=0; i<s.length(); i++) {       // draw character-by-character
    pushMatrix();                          // local transform for each letter
    translate(-dia/2, 0);                  // move to edge of circle
    rotate(-HALF_PI);                      // rotate letters (note what happens if you don't)
    text(s.charAt(i), 0, 0);               // display the character
    popMatrix();
    rotate(letterSpacing);                 // move for next letter
  }
  popMatrix();
  
}



