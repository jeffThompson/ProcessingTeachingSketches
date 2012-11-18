/*
SIMPLE CLOCK
Jeff Thompson
Fall 2011
*/

void setup() {
  size(600,600);
  smooth();
}

void draw() {
  
  // redraw the entire frame each time
  background(100);
  //fill(255, 5);
  // rect(0,0, width,height);
  
  int s = second();  // 0-59
  int m = minute();  // 0-59
  int h = hour();    // 0-23
  
  // VERSION 1 -- SQUARES
  // 3 squares that stand still and change color based on time
  noStroke();
  
  /*
  // hour
  // 0-255 and time 0-23
  fill(h * (255/24));
  rect(0,0, width/3,height);
  
  // minute
  fill(m * (255/60));
  rect(width/3,0, width/3,height);
  
  // second
  fill(s * (255/60));
  rect(width-width/3,0, width/3,height);
  */
  
  // VERSION 2 -- LINES
  int changingStroke;
  strokeWeight(2);
  
  // hours
  changingStroke = int(map(hour(), 0,23, 255,0));
  stroke(changingStroke); 
  line(0,h*(height/24), width/3,h*(height/24)-10);
  
  // minutes
  changingStroke = int(map(minute(), 0,59, 255,0));
  stroke(changingStroke); 
  line(width/3,m*(height/60), width-width/3,m*(height/60)-10);
  
  // seconds
  changingStroke = int(map(second(), 0,59, 255,0));
  stroke(changingStroke); 
  line(width-width/3,s*(height/60), width,s*(height/60)-10);
  
  // VERSION 3 -- CIRCLES
  noStroke();
  
  // hours
  fill(0);
  ellipse(width/2,height/2, h*(height/24),h*(height/24));
  
  // minutes
  fill(255,0,0, 127);
  ellipse(width/2,height/2, m*10,m*(height/60));
  
  // seconds
  fill(255, 50);
  ellipse(width/2,height/2, s*10,s*(height/60));
  
  // VERSION 4 -- for loop
  stroke(0);
  strokeWeight(1);
  
  // hour
  for (int i=0; i<=hour(); i++) {
    line((i*8)+10,10, (i*8)+10,20);
  }
  
  // minute
  for (int i=0; i<=minute(); i++) {
    line((i*8)+10,30, (i*8)+10,40);
  }
  
  // second
  for (int i=0; i<=second(); i++) {
    line((i*8)+10,50, (i*8)+10,60);
  }
  
  // extra credit: count as Roman numerals, with every 5th
  // element getting a slash rather than a vertical line
  
}
