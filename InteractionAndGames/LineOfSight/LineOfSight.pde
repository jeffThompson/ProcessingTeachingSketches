
/*
LINE OF SIGHT
Jeff Thompson | 2015 | www.jeffreythompson.org

Hide behind objects! This example uses a simple algorithm to
test of you can be seen by drawing a line between you and
another object – if that line collides with an obstacle, you 
are hidden; if not, you can be seen.

To test the collision, we just check line/line collision between
the line-of-sight and all four edges of the object.

CHALLENGES:
+  Can you wrap up the four line/line tests into a single function?
+  This system isn't quite perfect, especially when you're right
   at the edge of the obstacle. Can you come up with a better test
   that takes this into account? Hint: try two lines that are tangent
   to "you".
+  Can you make this work if the obstacle is rotated?

*/

float obstacleSize = 100;        // size of the obstacle you can hide behind

PVector you, other, obstacle;    // position for you, the other person, and the obstacle
String seeYou;                   // text to display if you're seen or hidden
PFont font;


void setup() {
  size(500,500);
  rectMode(CENTER);    // makes drawing the obstacle a little easier...
  
  // initial location for everything
  you = new PVector(100,100);
  other = new PVector(width-100, height-100);
  obstacle = new PVector(width/2, height/2);
  
  // font setup
  font = createFont("Helvetica", 14);
  textFont(font, 14);
  textAlign(CENTER);
}


void draw() {
  background(50);
  
  // obstacle
  noStroke();
  fill(255,150,150);
  rect(obstacle.x, obstacle.y, obstacleSize,obstacleSize);
  
  // you
  fill(255,0,0);
  ellipse(you.x, you.y, 50,50);
  you.x = mouseX;
  you.y = mouseY;
  
  // other
  fill(0,150,255);
  ellipse(other.x, other.y, 50,50);
  
  // line between the two
  // (not necessary, just for visualizing)
  stroke(255,150);
  line(you.x, you.y, other.x, other.y);
  
  // check if in line of sight – if ANY of these are true, you are hidden
  boolean top =    lineLine(you.x,you.y, other.x,other.y, obstacle.x-obstacleSize/2,obstacle.y-obstacleSize/2, obstacle.x+obstacleSize/2,obstacle.y-obstacleSize/2);
  boolean left =   lineLine(you.x,you.y, other.x,other.y, obstacle.x+obstacleSize/2,obstacle.y-obstacleSize/2, obstacle.x+obstacleSize/2,obstacle.y+obstacleSize/2);
  boolean bottom = lineLine(you.x,you.y, other.x,other.y, obstacle.x-obstacleSize/2,obstacle.y+obstacleSize/2, obstacle.x+obstacleSize/2,obstacle.y+obstacleSize/2);
  boolean right =  lineLine(you.x,you.y, other.x,other.y, obstacle.x-obstacleSize/2,obstacle.y-obstacleSize/2, obstacle.x-obstacleSize/2,obstacle.y+obstacleSize/2);
  
  // change text at bottom depending on whether you are seen or not
  if (top || left || bottom || right) {
    seeYou = "WHERE DID YOU GO?";
  }
  else {
    seeYou = "I SEE YOU!";
  }
  
  // display hidden or seen text
  fill(255);
  noStroke();
  text(seeYou, width/2, height-30);
}


