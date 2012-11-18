/*
POINT/BALL, BALL/BALL COLLISION DETECTION
 Jeff Thompson
 April 2011
 
 Demonstrates basic point/ball and ball/ball collision detection using a
 series of "if" statements and bounding boxes.
 
 Nearly all games are built on the intersection of objects; from complex 
 actions like gunfire, car collisions, or hitting a baseball to the very 
 simple like walking up to a wall without going through it or exerting 
 force on a box without pushing past its surface.  
 
 While it appears complex, collision detection is simply a series of “if” 
 statements that determine whether an object’s right, left, top, and bottom 
 sides are at or past the sides of another object.  
 
 In this case we are essentially drawing a rectangle around objects, 
 regardless of their shape; this “bounding box” is normally ~80% smaller than
 the object to prevent unrealistic collisions, especially for sprites or other 
 oddly-shaped objects.
 
 EXTRA CREDIT:
 
 + When you click on any part of Ball One's bounding box, the ball jumps to center
   on the mouse; try limiting the clickable area to a small section around the
   crosshairs
   
 + Rollover color?
 
 + As you can see, the bounding boxes are a bit large; try adding a variable
   to your "if" statements that shrinks the testing area to around 80%, but do
   so as a variable you can change in the global variables section
   
 + Collision detection between one object and and an array can be done through
   a for loop, iterating through the array and testing each object; complicated
   but very cool 
 
 www.jeffreythompson.org
 
 */

// basic global variables
float ballOneX, ballOneY, ballTwoX, ballTwoY;
int ballSize = 100;

// variable to store color, in this case for the bounding boxes
color boundColor = color(0);


void setup() {

  size(500,500);
  noStroke();
  smooth();

  // draw rectangles from the center, like ellipses
  // this will make drawing the bounding boxes easier
  rectMode(CENTER);

  // set initial location of balls
  ballOneX = 100;
  ballOneY = 100;
  ballTwoX = width-100;
  ballTwoY = height-100;

}


void draw() {

  // draw over screen at start of frame
  // note the placement, since we're drawing rectangles from the center
  fill(124,101,75);
  rect(width/2,height/2, width,height);

  // draw Ball Two
  fill(255,0,0, 200);
  ellipse(ballTwoX,ballTwoY, ballSize,ballSize);
  // bounding box
  stroke(boundColor, 100);
  noFill();
  rect(ballTwoX,ballTwoY, ballSize,ballSize);
  // crosshairs
  stroke(0, 100);
  line(ballTwoX-10,ballTwoY, ballTwoX+10,ballTwoY);
  line(ballTwoX,ballTwoY-10, ballTwoX,ballTwoY+10);
  // reset stroke to none
  noStroke();

  // point/ball collision (mouse, ball)
  // if mouse is over the bounding box, move Ball One,
  // otherwise ignore the click
  if (mousePressed &&                   // click
      mouseX >= ballOneX-ballSize/2 &&  // left
      mouseX <= ballOneX+ballSize/2 &&  // right
      mouseY >= ballOneY-ballSize/2 &&  // top
      mouseY <= ballOneY+ballSize/2) {  // bottom

      // set center position to mouse coords
      // note: not perfect
      ballOneX = mouseX;
      ballOneY = mouseY;

      // change fill color on click
      fill (0,74,139, 200);
  }
  else {               
    fill (0,174,239, 200);    // otherwise, set fill color to light blue
  }

  // draw Ball One
  ellipse(ballOneX, ballOneY, ballSize,ballSize);
  // bounding box
  stroke(boundColor, 100);
  noFill();
  rect(ballOneX,ballOneY, ballSize,ballSize);
  // crosshairs
  stroke(0, 100);
  line(ballOneX-10,ballOneY, ballOneX+10,ballOneY);
  line(ballOneX,ballOneY-10, ballOneX,ballOneY+10);
  // reset stroke to none
  noStroke();

  // ball/ball collision
  // if the bounding boxes overlap, change their color to white
  if (ballOneX + ballSize/2 >= ballTwoX - ballSize/2 &&  // right
      ballOneX - ballSize/2 <= ballTwoX + ballSize/2 &&  // left
      ballOneY + ballSize/2 >= ballTwoY - ballSize/2 &&  // top
      ballOneY - ballSize/2 <= ballTwoY + ballSize/2) {  // bottom

      boundColor = color(255);      // change bounding box color
  }
  else { 
      boundColor = color(0);        // otherwise, set to normal
  }
  
}

