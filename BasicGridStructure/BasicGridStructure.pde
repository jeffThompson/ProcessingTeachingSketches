/*
BASIC GRID STRUCTURE
 Jeff Thompson
 2010
 
 This will help you get used to making shapes located on a grid.
 
 Paste the noted section of code directly below the background() command or after
 variables are declared.
 
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

  // END COPY *****


  // Here's a little table and chair!

  stroke(0);

  fill(140,130,90);
  quad(200,150, 150,200, 150,300, 200,250);  // back
  quad(150,400, 150,300, 160,315, 160,390);
  quad(230,350, 230,440, 240,430, 240,340);
  quad(280,300, 270,310, 270,400, 280,390);
  quad(200,250, 200,350, 190,360, 190,260);
  quad(230,350, 230,340, 280,290, 280,300);  // seat R
  quad(400,550, 410,540, 410,400, 400,410);
  quad(500,310, 500,450, 490,460, 490,310);  // rear R leg
  quad(400,400, 400,410, 500,310, 500,300);  // front edge (R)
  fill(200,180,120);
  quad(150,200, 140,195, 190,145, 200,150);  // top of back
  quad(150,200, 140,195, 140,395, 150,400);  // front L leg
  quad(230,350, 220,345, 220,435, 230,440);
  quad(270,310, 270,400, 260,395, 260,320);
  quad(190,360, 180,355, 180,270, 190,260);
  quad(150,300, 230,340, 280,290, 200,250);  // seat top
  quad(150,300, 150,310, 230,350, 230,340);  // seat L
  quad(200,310, 200,450, 210,455, 210,315);  // front L leg
  quad(390,405, 390,545, 400,550, 400,410);  // front R leg
  quad(490,460, 480,455, 480,330, 490,320);
  quad(200,300, 400,400, 500,300, 300,200);  // tabletop
  quad(200,300, 200,310, 400,410, 400,400);  // front edge (L)
  fill(140,130,90);
  quad(210,455, 220,445, 220,320, 210,315);

  // ... end of table code.



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












