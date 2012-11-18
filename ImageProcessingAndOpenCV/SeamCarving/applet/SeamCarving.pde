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
String filename = "face.jpg";
// String filename = "mountainLake.jpg";
// String filename = "crowd.jpg";
// String filename = "missile.jpg";
// String filename = "sheep.jpg";

PImage img;
int bottomIndex;
boolean findNext = false;
float[][] sums;

void setup() {

  // load image
  img = loadImage(filename);
  // size(img.width, img.height);
  size(640,480);
  PImage hImg = createImage(img.width, img.height, RGB);
  PImage vImg = createImage(img.width, img.height, RGB);
  println("Image size: " + width + " x " + height + " px");

  // draw image and convert to grayscale
  image(img, 0, 0);
  filter(GRAY);
  img.loadPixels();

  // run kernels to create "energy map"
  runKernels(hImg, vImg);
  image(img, 0, 0);

  // sum pathways through the image
  sums = getSumsThroughImage();
}

void draw() {

  // use arrow keys to display seams through the image
  if (keyPressed && key == CODED) {
    if (keyCode == LEFT && bottomIndex-1 > 0) {
      bottomIndex -= 1;
      findNext = true;
    }
    else if (keyCode == RIGHT && bottomIndex+1 < width-1) {
      bottomIndex += 1;
      findNext = true;
    }
  }

  // if triggered, draw new seam(s)
  if (findNext) {
    image(img, 0, 0);
    loadPixels();

    // get start point (smallest value) - this is disabled here but would be used
    // in an automatic situation to find the next best seam (starting at the lowest energy
    // bottomIndex = findStartPoint(sums, 50);    // second arg is padding L/R
    // print(bottomIndex + " ");

    // find the pathway with the lowest information
    int[] path = new int[height];
    path = findPath(bottomIndex, sums, path);

    // draw the pathway!
    for (int j=0; j<height; j++) {
      pixels[j*width + path[j]] = color(255, 0, 0);
    }

    // when done, update pixels to display
    updatePixels();
    findNext = false;
  }
}

