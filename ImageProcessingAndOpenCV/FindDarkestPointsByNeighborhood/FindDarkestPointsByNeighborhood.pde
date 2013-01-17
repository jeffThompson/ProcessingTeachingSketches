
/*
FIND DARKEST POINTS BY NEIGHBORHOOD/DISTANCE
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 An algorithm to find the darkest points in an image. 
 
 While a true centroid algorithm would likely be better, and is possible in Processing
 (and likely easiest using OpenCV), this is either computationally expensive (ie: slow)
 and/or requires external libraries and methods.
 
 Instead, this is a much lighter-weight example for finding the darkest single-pixel 
 points within blocks of the image, then compares those results to neighbors, removing
 ones that are too close to each other.
 
 OTHER RESOURCES
 + Fancier 'clustering algorithms':
     http://home.dei.polimi.it/matteucc/Clustering/tutorial_html/index.html
 + A few other ideas (including a Processing sketch that crashed for me) at StackOverflow:
     http://stackoverflow.com/questions/356035/algorithm-for-detecting-clusters-of-dots
 + A faster blurring method for Processing, which can be used in conjunction with the
   above examples:
     https://forum.processing.org/topic/fast-blurring
 
 */

float storeThresh = 30;         // points' color must be this dark to be stored (0-255)
float distThresh = 10;          // if too close to another point, don't store
int sampleSize = 20;            // divide image into square of this size (px)
PImage source, test;            // image objects to load, convert for testing

// resulting pointss (ArrayList for flexibility)
ArrayList<Integer> darkest = new ArrayList<Integer>();


void setup() {

  // load image (here from URL for tidiness) and other setup stuff
  source = loadImage("http://www.seriouseats.com/recipes/images/20120216-193359-dinner-tonight-steak-taco-salad-primary.jpg");
  size(source.width, source.height);
  smooth();
  noStroke();

  // copy pixels to another PImage for processing
  test = createImage(width, height, RGB);
  test.copy(source, 0, 0, width, height, 0, 0, width, height);
  test.filter(GRAY);  

  // go through image block-by-block, finding the darkest pixel and, if it
  // falls within 'storeThresh', store it to the ArrayList - this helps keep
  // our computation down, as we don't have to compare EVERY pixel with EVERY OTHER pixel!
  test.loadPixels();
  for (int x=0; x < width-sampleSize; x += sampleSize) {                  // go through in blocks
    for (int y=0; y < height-sampleSize; y += sampleSize) {

      // within each sample square, get the darkest pixel
      // if that pixel is dark enough, add it to the darkest!
      int darkX = 0;                                                      // variables for the darkest px's location
      int darkY = 0;
      float darkestValue = 255;                                           // set a 'world record' of 255 as a starting value
      for (int sx = x; sx < x+sampleSize; sx++) {                         // iterate through px block
        for (int sy = y; sy < y+sampleSize; sy++) {
          float currentDark = test.pixels[sy * width + sx] >> 16 & 0xFF;  // red value fine, since we're grayscale only
          if (currentDark < darkestValue) {                               // if darker than previously stored
            darkestValue = currentDark;                                   // store it's value and location
            darkX = sx;
            darkY = sy;
          }
        }
      }

      // if the result is dark enough, store it to the ArrayList! 
      if (darkestValue <= storeThresh) {
        darkest.add((darkY*width + darkX));    // store location as int in the centroid ArrayList
      }
    }
  }
  println("Found " + darkest.size() + " darkest");

  // cull the list, looking for pixels that are too close - if they are, delete the current
  println("Culling darkest for proximity...");
  for (int current = darkest.size()-1; current >= 0; current--) {    // always go backwards through an ArrayList
    int cx = darkest.get(current) % width;                           // current x/y position
    int cy = darkest.get(current) / width;
    for (int other = darkest.size()-1; other >= 0; other--) {        // compare with other points
      int ox = darkest.get(other) % width;                           // other x/y position
      int oy = darkest.get(other) / width;
      float d = dist(cx, cy, ox, oy);                                // distance between other and current
      if (d > 0 && d < distThresh) {                                 // if 'other' is not 'current' (dist=0) BUT we're too close
        darkest.remove(current);                                     // remove from ArrayList
      }
    }
  }
  println("Reduced list to " + darkest.size() + " darkest");


  // display darkest points on top of dimmed image (to more easily see)
  image(source, 0, 0);
  fill(255, 100);
  rect(0,0, width,height);

  // draw the darkest points as dots
  fill(0);
  for (Integer c : darkest) {
    ellipse(c % width, c/width, 4, 4);
  }
}
