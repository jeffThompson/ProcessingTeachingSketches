/*
ITERATION
 Jeff Thompson
 November 2009
 
 Guide to repetition of images - the hard and the easy way
 
 www.jeffreythompson.org 
 */

void setup()
{

  size(400,400);
  background(200);   // reminder, single number means gray
  strokeWeight(2);
  smooth();          // helps with diagonal lines too

  // Draw a row of four diagonal lines -- the hard way

  line(0,0, 100,400);      // X coord is off 100px between top and bottom,
  line(100,0, 200,400);    // making a diagonal line
  line(200,0, 300,400);
  line(300,0, 400,400);

  // Now the easier way (once you get the hang of it)

  // begin loop    type  initial val  until...    add a num to i (same as i=i+100)
  for             (int   i=0;         i<=300;     i+=100){
    // then do everything in the curly brackets
    line(i,0, i+100,400);
    // then repeats over and over until the middle value above is reached (300)

    // saves you four lines of code!
  }


  // Smaller lines - nested loops
  stroke(255);

  for (int x=0; x<=400; x+=10){
    for (int y=0; y<=400; y+=20){
      line(x,y, x+10,y+10);

      // saves you 800 lines of code!
    }
  }


  // Do the same with rectangles
  stroke(0);
  strokeWeight(1);
  noFill();

  for (int i=0; i<=400; i+=20){
    for (int j=0; j<=400; j+=5){
      rect(i,j, i+20,j+5);

      // save you 1600 lines of code!
    }
  }


  // One more example increasing the size of squares
  fill(255,0,0);

  for (int i=0; i<=400; i+=2){
    rect(i,i, i,i);
  }

  /*
  In-class assignment:
   
   Create patterns using for loops.
   */

}




