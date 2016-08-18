
/*
CROSSHATCH
Jeff Thompson | 2016 | jeffreythompson.org

Fill is cool, but crosshatching is way cooler :)

Draws a series of diagonal lines to fill an area.

*/

void setup() {
  size(600, 600);
  background(255);
  
  // arguments are start x/y, end x/y, the
  // line density, and to reverse or not
  stroke(0);
  hatch(30, 30, width-30, height-30, 10, false);
  hatch(30, 30, width-30, height-30, 10, true);
}


void hatch (int sx, int sy, int w, int h, int interval, boolean reverse) {

  // normal direction
  if (!reverse) {
    int ex = sx;               // end x position along start
    sx = sx + interval;        // offset by one interval
    int ey = sy + interval;    // same for end y
    
    while (true) {
      line(sx, sy, ex, ey);    // draw a line at the current position

      sx += interval;          // start x walks across
      if (sx > w) {            // when it hits the edge...
        sx = w;                // ... it stops
        sy += interval;        // ... and start y starts moving down
      }
      ey += interval;          // same for end y
      if (ey > h) {
        ey = h;
        ex += interval;
      }

      // when we've converged at the other
      // end, we are done!
      if (sx == ex && sy == ey) {
        return;
      }
    }
  } 

  // reverse
  // (basically the same as above, but working upward
  // in the y direction)
  else {
    int startY = sy;
    
    int ex = sx;
    sx = sx + interval;
    sy = h;
    int ey = sy - interval;
    
    while (true) {
      line(sx, sy, ex, ey);

      sx += interval;
      if (sx > w) {
        sx = w;
        sy -= interval;
      }
      ey -= interval;
      if (ey < startY) {
        ey = startY;
        ex += interval;
      }

      if (sx == ex && sy == ey) {
        return;
      }
    }
  }
}