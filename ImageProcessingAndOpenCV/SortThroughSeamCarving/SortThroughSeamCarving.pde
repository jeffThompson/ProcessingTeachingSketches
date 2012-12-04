/* 
 SEAM CARVING (or "content aware scaling")
 Jeff Thompson
 March 2012
 
 Find the seam (pathway) with the lowest energy vertically through the
 image.  This is similar to the algorithm used for Photoshop's "content-aware
 scaling".
 
 TO USE:
 This version is interactive: use the L/R arrow keys to move across the image
 and see the seams from each point along the bottom.  Comments below indicate
 how this could be done automatically by finding the start point with the
 least cumulative energy one-by-one.
 
 Built heavily from examples on:
 http://en.wikipedia.org/wiki/Seam_carving#Dynamic_Programming
 
 www.jeffreythompson.org
 */

// file to read in:
// String filename = "mountainLake.jpg";
// String filename = "face.jpg";
// String filename = "crowd.jpg";
// String filename = "missile.jpg";
String filename = "sheep.jpg";

boolean reverseIt = true;

PImage img, original;
boolean findNext = false;
float[][] sums;
int bottomIndex = 0;

void setup() {

  // load image
  img = loadImage(filename);
  original = loadImage(filename);

  size(img.width, img.height);

  PImage hImg = createImage(img.width, img.height, RGB);
  PImage vImg = createImage(img.width, img.height, RGB);
  println("Image size: " + width + " x " + height + " px");

  // draw image and convert to grayscale
  image(img, 0, 0);
  filter(GRAY);
  img.loadPixels();    // updatePixels is in the 'runKernals'

  // run kernels to create "energy map"
  runKernels(hImg, vImg);
  image(img, 0, 0);

  // sum pathways through the image
  sums = getSumsThroughImage();

  image(img, 0, 0);
  loadPixels();
  for (bottomIndex = 0; bottomIndex+1 < width-1; bottomIndex++) {

    // get start point (smallest value) - this is disabled here but would be used
    // in an automatic situation to find the next best seam (starting at the lowest energy
    // bottomIndex = findStartPoint(sums, 50);    // second arg is padding L/R
    // print(bottomIndex + " ");

    // find the pathway with the lowest information
    int[] path = new int[height];
    path = findPath(bottomIndex, sums, path);

    // get the pixels of the path from the original image
    original.loadPixels();
    color[] c = new color[path.length];               // create array of the seam's color values
    for (int i=0; i<c.length; i++) {
      c[i] = original.pixels[i*width + path[i]];      // set color array to values from original image
    }

    c = sort(c);                                      // sort (use better algorithm later)
    if (reverseIt) {
      c = reverse(c);
    }
    
    for (int i=0; i<c.length; i++) {
      original.pixels[i*width + path[i]] = c[i];      // reverse! set the pixels of the original from sorted array
    }
    original.updatePixels();

    // draw the pathway!
    /*
    for (int j=0; j<height; j++) {
      pixels[j*width + path[j]] = color(255, 0, 0);
    }
    */
  }
  // when done, update pixels to display
  updatePixels();

  // display the result!
  image(original, 0, 0);
}

