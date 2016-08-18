
/*
CROSSHATCH
Jeff Thompson | 2016 | jeffreythompson.org

Fill is cool, but crosshatching is way cooler! Draws
a series of diagonal lines to fill an area.

CHALLENGE:
+ Can you reverse the crosshatch direction? Add a boolean variable
  to the function to trigger the direction.
+ Can you apply this to an image's pixels?

*/

void setup() {
  size(600, 600);
  background(255);
  
  // arguments are start x/y, end x/y, the
  // line density, and to reverse or not
  stroke(0);
  hatch(30, 30, width-30, height-30, 10);
  hatch(30, 30, width-30, height-30, 10);
}


void hatch (float sx, float sy, float w, float h, float interval) {
  float ex = sx;             // end x position along start
  sx = sx + interval;        // offset by one interval
  float ey = sy + interval;  // same for end y

  while (true) {
    line(sx, sy, ex, ey);    // draw a line at the current position

    sx += interval;          // start x walks across
    if (sx > w) {            // when it hits the edge...
      sy += sx-w;            // ...move down by the remainder*
      sx = w;                // ...and stop x
    }
    
    // * right triangle math!
    //   if we just add the interval to sy, we'd get
    //   weird gaps, but because we're at 45º, we can
    //   just move down by sx-w (whatever would hang
    //   over the right edge) and our spacing stays
    //   the same
    
    ey += interval;          // same for end y
    if (ey > h) {
      ex += ey-h;
      ey = h;
      //ex += interval;
    }
    
    if (ex >= sx) return;
  }
}