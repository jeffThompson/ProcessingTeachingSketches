/*
BALL/BALL COLLISION WITH PYTHAGOREAN THEOREM
 Jeff Thompson
 April 2011
 
 www.jeffreythompson.org
 */

// "you" variables
float youX, youY;
int youSize = 100;
int clickBox = 20;                       // smaller box for click testing/dragging
color youColor = color(255,0,0, 200);
int youR = youSize/2;                    // radius
boolean clickOn = false;                 // used for better interaction; see code below
int prevMouseX, prevMouseY;              // store previous position to determine speed

// balls
float ballX,ballY;
int ballSize = 100;                      // how big are they?
int ballR = ballSize/2;                  // radius
color ballColor = color(255,127,0, 200);

// collision variables
float distX, distY, distance;           // find distance with Pythagorean Theorem
boolean collision = false;              // store when the two hit each other


void setup() {

  size(500,500);
  smooth();
  noStroke();

  // positions
  youX = width-100;
  youY = height-100;
  ballX = 100;
  ballY = 100;
}

void draw() {

  // fill screen
  fill(255);
  rect(0,0, width,height);


  // draw ball
  fill(ballColor);
  ellipse(ballX,ballY, ballSize,ballSize);
  
  
  // if clicked on, allow to drag around
  if (mousePressed &&                 // click
  mouseX >= youX-clickBox &&      // left
  mouseX <= youX+clickBox &&      // right
  mouseY >= youY-clickBox &&      // top
  mouseY <= youY+clickBox) {      // bottom

    clickOn = true;    // set to true, this will switch back when the mouse is released
  } 
  // if clickOn is true and coords aren't outside the frame
  if (clickOn) {
    youX = mouseX;
    youY = mouseY;

    prevMouseX = mouseX;
    prevMouseY = mouseY;
  }
  // when released, set to false; this is triggered in the mouseReleased function below


  // draw you
  fill(youColor);
  ellipse(youX,youY, youSize,youSize);
  // crosshairs
  stroke(0, 100);
  noFill();
  line(youX-10,youY, youX+10,youY);
  line(youX,youY-10, youX,youY+10);
  noStroke();


  // draw Pythagorean coordinates
  if (mousePressed) {
    stroke(0, 100);
    noFill();
    line(youX,youY, ballX,ballY);    // angle
    line(youX,youY, ballX,youY);     // horiz
    line(ballX,ballY, ballX,youY);   // vert
    noStroke();
  }


  // find distance between
  distX = abs(youX - ballX);
  distY = abs(youY - ballY);
  distance = sqrt(distX*distX + distY*distY);
  
  
  // check for collision based on radii
  if (youR + ballR > distance) {
    youColor = color(255,67,67, 200);
    ballColor = color(225,240,0, 200);
  }
  else {
    youColor = color(255,0,0, 200);
    ballColor = color (255,127,0, 200);
  }
  

}


void mouseReleased() {     // turn off dragging when the mouse is released
  clickOn = false;
}

