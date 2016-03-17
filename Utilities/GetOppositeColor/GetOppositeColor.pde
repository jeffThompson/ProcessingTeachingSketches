
import java.awt.Color;

/*
GET OPPOSITE COLOR
Jeff Thompson | 2015 | www.jeffreythompson.org

Takes an RGB color and find the complimentary one!

*/


color initial = color(255,0,0);


void setup() {
  size(400, 400); 
  noStroke();
  
  fill(initial);
  rect(0, 0, width/2, height);
  
  color opposite = getOppositeColor(initial);
  fill(opposite);
  rect(width/2, 0, width/2, height);
}


color getOppositeColor(color c) {
  float[] hsv = new float[3];
  Color.RGBtoHSB(c>>16&0xFF, c>>8&0xFF, c&0xFF, hsv);
  hsv[0] = (hsv[0] + 0.5) % 1.0;
  
  // low/high value? adjust that too
  if (hsv[2] < 0.1 || hsv[2] > 0.9) {
    hsv[2] = (hsv[2] + 0.5) % 1.0;
  }
  
  return Color.HSBtoRGB(hsv[0], hsv[1], hsv[2]);
}

 