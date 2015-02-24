/*
PUSHING
Jeff Thompson
April 2011

www.jeffreythompson.org
*/

// "you" variables
float youX, youY;
int youSize = 100;
int clickBox = 20;           // smaller box for click testing/dragging
boolean clickOn = false;     // used for better interaction; see code below
int prevMouseX, prevMouseY;  // store previous position to determine speed

// balls
int numBalls = 1;                      // how many balls?
int ballSize = 10;                      // how big are they?
float[] balls = new float[numBalls*2];  // set up array

// collision variables
float distX, distY, distance;           // find distance with Pythagorean Theorem


void setup() {
  
  size(500,500);
  smooth();
  noStroke();
  
  // set you to center
  youX = width/2;
  youY = height/2;
  
  // fill balls array
  for (int i=0; i<balls.length; i+=2) {
    balls[i] = random(0,width);          // x coord
    balls[i+1] = random(0,height);       // y coord
  }
  
}

void draw() {
  
  // fill screen
  fill(255);
  rect(0,0, width,height);
  
  
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
  fill(255,0,0);
  ellipse(youX,youY, youSize,youSize);
  // crosshairs
  stroke(0, 100);
  noFill();
  line(youX-10,youY, youX+10,youY);
  line(youX,youY-10, youX,youY+10);
  noStroke();
  

  // look for collision with "you" and draw balls
  fill(0);
  for (int i=0; i<balls.length; i+=2) {
    
    // find distance
    distX = youX - balls[i];
    distY = youY - balls[i+1];
    distance = sqrt(distX*distX + distY + distY);
    if (keyPressed) {
      if (key == 32) {
        println(distance);
      }
    }  
    
    // check for collision with "you"
    if (distance <= (youSize/2)+(ballSize/2)) {
          
          balls[i] -= 1;
    }
    
    // draw balls
    ellipse(balls[i],balls[i+1], ballSize,ballSize);
  }
  
  /*
  // look for collision with "you" and draw balls
  fill(0);
  for (int i=0; i<balls.length; i+=2) {
    
    // check for collision with "you"
    if (youX+youSize/2 >= balls[i]-ballSize/2 &&
        youX-youSize/2 <= balls[i]+ballSize/2 &&
        youY+youSize/2 >= balls[i+1]-ballSize/2 &&
        youY-youSize/2 <= balls[i+1]+ballSize/2) {
          
          // test which side of the ball you're on, then move
          // in that direction
          if (youX < balls[i] || youX > balls[i]) {
            balls[i] += mouseX - prevMouseX;
          }
          // else if (youX > balls[i]) {
          //   balls[i] -= 1;
          // }
          else if (youY < balls[i+1] || youY > balls[i+1]) {
            balls[i+1] += mouseX - prevMouseX;
          }
          // else if (youY > balls[i+1]) {
          //   balls[i+1] -= 1;
          // }
    }
    
    // draw balls
    ellipse(balls[i],balls[i+1], ballSize,ballSize);
  }
  */
  
}

  
void mouseReleased() {     // turn off dragging when the mouse is released
  clickOn = false;
}
