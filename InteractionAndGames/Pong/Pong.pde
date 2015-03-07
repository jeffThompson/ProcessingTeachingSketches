
/*
PONG
 Jeff Thompson | 2015 | jeffreythompson.org
 
 A version of the classic videogame. In this example,
 we'll see how to control a paddle, to bounce off the 
 sides of the window and the paddles, and how to keep
 score.
 
 For a more complex but more flexible example, see
 "PongWithArrayList" for a version using object-
 oriented programming.
 
 
 CHALLENGE:
 +  How can you add the illusion of spin to the ball
    depending on your paddle's motion? Hint: use the
    built-in "pmouseX" and "pmouseY" to get the mouse's
    previous position, which gives you direction of
    movement!
 
 */

int ballSize =       12;         // how big to make the ball
int paddleWidth =    12;         // size of the paddle
int paddleHeight =   100;
float playerSpeed =  15.0;       // how fast do the paddles move?

float ballX, ballY;              // position of the ball onscreen
float ballSpeedX, ballSpeedY;    // speed (and direction) of the ball

float p1y, p2y;                  // player paddle position
int scoreP1, scoreP2;            // current score for both players

PFont font;                      // font for showing score


void setup() {
  size(800, 800);                   // set window size
  frame.setTitle("Pong");           // make window name look nice
  noStroke();                       // no outlines!

  // initialize variables
  ballX =             width/2;      // set ball to center of screen
  ballY =             height/2;
  ballSpeedX =        2.0;          // move ball to the right at a 45º angle
  ballSpeedY =        1.5;
  p1y = p2y =         height/2;     // set paddles at the center of the screen
  scoreP1 = scoreP2 = 0;            // start score at 0 for both players
  
  // setup font for displaying score
  font = createFont("Helvetica", 72);    // font name and size
  textFont(font, 72);
}


void draw() {
  // clear the screen every frame, draw the playing field and score
  background(0);
  fill(255, 100);
  rect(width/2 - 3, 0, 6, height);
  textAlign(LEFT, CENTER);
  text(scoreP1, 50,50);
  textAlign(RIGHT, CENTER);
  text(scoreP2, width-50,50);

  // draw the ball, update its position
  fill(255);
  ellipse(ballX, ballY, ballSize, ballSize);
  ballX += ballSpeedX;
  ballY += ballSpeedY;  

  // draw the paddles
  rect(0, p1y, paddleWidth, paddleHeight);
  rect(width-paddleWidth, p2y, paddleWidth, paddleHeight);

  // update paddle position using mouse for player 1
  // (player 2 is controlled by the keyboard - code is below)
  p1y = mouseY;

  // check for collision with the top/bottom of the screen, bounce
  if (ballY < 0 || ballY > height) {
    ballSpeedY *= -1.0;                // multiply by -1 = reverse direction!
  }

  // check if ball has gone past the sides 
  // if so update score and respawn the ball
  if (ballX < 0) {                     // if off the left side...
    scoreP2 += 1;                      // add to opponent's score
    newBall();                         // new ball using custom function (at the bottom)
  }
  else if (ballX > width) {
    scoreP1 += 1;
    newBall();
  }
  
  // check for collision with paddle
  // 1. tests if ball is at the paddle on the R/L
  // 2. tests if ball is below the top of the paddle
  // 3. tests if the ball is above the bottom of the paddle
  // if so, reverse the ball's direction
  if (ballX - ballSize/2 <= paddleWidth && ballY > p1y &&  ballY < p1y + paddleHeight) {
    ballSpeedX *= -1;
  }
  else if (ballX + ballSize/2 >= width-paddleWidth && ballY > p2y && ballY < p2y + paddleHeight) {
    ballSpeedX *= -1;
  }
}


// player 2 uses the arrow keys to move the paddle
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      p2y -= playerSpeed;          // minus = up
    }
    else if (keyCode == DOWN) {
      p2y += playerSpeed;          // plus = down
    }
  }
}


// a custom "function" to create a new ball
// this let's us re-use code more easily
void newBall() {
  ballX = width/2;
  ballY = height/2;
  ballSpeedX = random(0.5, 3.0);    // random speed!
  ballSpeedY = random(-2.0, 2.0);
}

