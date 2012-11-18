/*
TABLE and CHAIR
Jeff Thompson
Fall 2011

www.jeffreythompson.org
*/

void setup() {
 
  size(500,500);
  background(255);
  noStroke();
  
  /*************************************************/
  // PERSPECTIVE VARIABLES
  
  int pOffset = 50;    // perspective offset
  int lOffset = 5;     // for legs

  /*************************************************/
  // LEGS 
  
  fill(50);
  rect(50,260, 10,150);    // left leg (front edge)
  rect(340,260, 10,150);  // right leg (front edge)
  
  fill(70);
  // left leg (right edge)
  //   UL      LL      LR                      UR
  quad(60,260, 60,410, 60+lOffset,410-lOffset, 60+lOffset,260-lOffset);
  // right leg (rt edge)
  //   UL       LL       LR                       UR
  quad(350,260, 350,410, 350+lOffset,410-lOffset, 350+lOffset,260-lOffset);

  /*************************************************/
  // TOP
  
  fill(100);
  rect(50,250, 300,10);    // top (front edge)
  fill(150);
  // top
  //   LL      LR       UR                       UL
  quad(50,250, 350,250, 350+pOffset,250-pOffset, 50+pOffset,250-pOffset);
  fill(200);
  // top right edge
  //   UL       LL       LR                       UR
  quad(350,250, 350,260, 350+pOffset,260-pOffset, 350+pOffset,250-pOffset);
 
  /*************************************************/ 
  // APRON
  
  fill(80);
  rect(60,260, 280,10);    // front
  
}












