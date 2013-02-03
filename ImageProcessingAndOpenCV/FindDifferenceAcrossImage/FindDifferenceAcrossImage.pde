/*
FIND DIFFERENCE ACROSS IMAGE
 Jeff Thompson
 April 2012
 
 During discussion with a student about random image generation, where
 some random images seemed more random than others, we talked about a
 programmatic way of testing images.
 
 This patch generates a series of many randmom rectangles of random size,
 color, and transparency.  It then analyzes the pixels one by one and its
 neighbors.  We compare the colors using HSB (hue, saturation, and balance)
 instead of RGB, though it would be interesting to experiment and find the
 best algorithm (looking for hard edges, for example).
 
 The differences between pixels are summed and averaged when done.  This
 value is multiplied by 100 to normalize it into a more useable range.
 
 www.jeffreythompson.org
 */

int numRects = 4000;  // how many random rectangles to draw
int numTries = 5;     // how many times to test the average before quitting
int count = 1;        // keep track of the tries as we go
float thresh = 5.0;   // what average difference is acceptable?

void setup() {

  // where are we at in the attempts?
  println("DIFFERENCE ATTEMPT (" + count + "/" + numTries + "):");
  
  // basic setup stuff
  size(400, 400);
  noStroke();
  background(255);

  // set variables (do this in the setup so they get reset each time)
  float hDiff = 0;      // keep track of hue difference...
  float sDiff = 0;      // ...saturation
  float bDiff = 0;      // ... brightness
  float aveDiff = 0;    // ... and overall average

  // create lots of random shapes!
  for (int i=0; i<numRects; i++) {
    fill(random(0, 255), random(0, 255), random(0, 255), random(0, 150));
    rect(random(0, width), random(0, height), random(50, 150), random(50, 150));
  }

  // once drawn, read the pixels in one by one (we start offset by the width so
  // we can compare up/down without error)
  loadPixels();
  for (int i=width; i<pixels.length-width; i++) {

    // get pixel values for right, left, up, and down
    color r = pixels[i+1];
    color l = pixels[i-1];
    color u = pixels[i-width];
    color d = pixels[i+width];

    // compare values in all directions
    float h = hue(pixels[i])*4 - hue(r) - hue(l) - hue(u) - hue(d);
    float s = saturation(pixels[i])*4 - saturation(r) - saturation(l) - saturation(u) - saturation(d);
    float b = brightness(pixels[i])*4 - brightness(r) - brightness(l) - brightness(u) - brightness(d);

    // add to ongoing totals
    hDiff += h;
    sDiff += s;
    bDiff += b;
  }

  // find averages (here we also get the absolute values
  // to keep everything in the positive range)
  hDiff = abs(hDiff/pixels.length);
  sDiff = abs(sDiff/pixels.length);
  bDiff = abs(bDiff/pixels.length);
  aveDiff = (hDiff + sDiff + bDiff)/3;

  // how did we do?
  println("Hue:\t   " + hDiff * 100);
  println("Saturation:\t   " + sDiff * 100);
  println("Brightness:\t   " + bDiff * 100);
  println("Average:\t   " + aveDiff * 100);

  // update the display
  updatePixels();

  // from here, we can test the value and run the setup again
  // if it does not meet the requirement - would make sense to also
  // keep track of how many times we've tried, since a bad test case
  // could result in an infinite loop

  // if our average is too high and we haven't run the code too many times
  if (aveDiff*100 > thresh && count < numTries) {
    println("FAIL!\n");                          // note that we failed (and add a line break)
    count++;                                     // increment the count (avoid infinite loops)
    setup();                                     // and run the code again!
  }
  else if (count >= numTries) {                  // if we've tried too many times, stop
    println("\nPROCESS TIMED OUT - SORRY!");
  }
  else {
    println("\nSUCCESS!");                       // if we did succeed, we want to know it!
  }
}

