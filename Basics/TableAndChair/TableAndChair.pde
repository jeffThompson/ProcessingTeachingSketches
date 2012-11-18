/*
"Table and Chair"
Jeff Thompson
March 2010
www.jeffreythompson.org

A simple drawing of a table and chair.

www.jeffreythompson.org
*/

void setup(){
  size(600,600);
  smooth();

  PFont font;
  font = loadFont("SansSerif-12.vlw");
  textFont(font, 12);
  textAlign(CENTER);

}

void draw(){
  background(255);
  noCursor();

  // COPY THE FOLLOWING CODE *****  

  stroke(225);                       // line (stroke) color, change for darker bground

  for(int i=0; i<width; i+=10){      // automatically scales to size and
    line(i,0, i,height);             // draws vertical lines every 10px
  }  

  for(int j=0; j<height; j+=10){
    line(0,j, width,j);              // draws horizontal lines
  }

  stroke(180);                       // darkens lines and
  for(int i=0; i<width; i+=100){     // draws every 100px
    line(i,0, i,height);             // vertical
  }

  for(int j=0; j<height; j+=100){
    line(0,j, width,j);              // horizontal
  }

  // COPY THIS FOR CURSOR LABELING *****
  // If using, this code must be at the very end of your draw() loop

  fill(255,0,0);
  noStroke();
  triangle(mouseX,mouseY, mouseX-5,mouseY-5, mouseX+5,mouseY-5);
  stroke(180);
  fill(255);
  rect(mouseX-43,mouseY-25, 86, 20);
  fill(180);
  String position = ("x:" + mouseX + ", " + "y:" + mouseY);
  text(position, mouseX, mouseY-10);

  // END COPY *****

}


