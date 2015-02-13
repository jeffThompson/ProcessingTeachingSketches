
/*
PONG WITH ARRAY LIST
 Jeff Thompson | 2015 | www.jeffreythompson.org
 
 A variation on the basic Pong game using ArrayList to
 store the balls in an object-oriented structure.
 
 Use the mouse to move your paddle, but don't let the
 balls get past you!
 
 */

int numBalls =  10;    // how many balls?
int score =     20;    // score gets to 0, you die :)

// our objects – a single paddle and an ArrayList of balls
Paddle paddle;
ArrayList<Ball> balls = new ArrayList<Ball>();

PFont font;            // for displaying the score


void setup() {
  size(800, 600);
  
  font = loadFont("JosefinSlab-Light-48.vlw");
  textFont(font, 48);

  // create a single instance of the Paddle class
  paddle = new Paddle();

  // a for loop to make lots of instances of the Ball class
  for (int i=0; i<numBalls; i++) {
    Ball b = new Ball();            // create a new Ball
    balls.add(b);                   // add it to the ArrayList
  }
}


void draw() {

  // basics: background and score
  background(0);
  fill(150);
  noStroke();
  text(score, 20,60);

  // update and draw the paddle
  paddle.update();
  paddle.display();

  // a nice way to iterate an ArrayList of objects
  for (Ball b : balls) {    
    b.update();
    b.display();
  }
  
  // BUT: if we want to remove an object from an ArrayList
  // while looping, we have to do it backwards!
  for (int i=balls.size()-1; i>=0; i-=1) {
    Ball b = balls.get(i);        // get each ball one-by-one
    boolean hit = b.checkHit();   // has it hit the edge?
    if (hit == true) {            // if so...
      score -= 1;                 // reduce the score by 1
      balls.remove(b);            // and remove it from the list
      if (score < 0) exit();      // if we're dead, quit
    }
  }
  
  // sometimes, randomly add a ball!
  if (random(1) < 0.01) balls.add(new Ball());
  
}


