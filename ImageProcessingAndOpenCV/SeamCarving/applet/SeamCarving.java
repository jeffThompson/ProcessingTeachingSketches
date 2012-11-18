import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class SeamCarving extends PApplet {

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

public void setup() {

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

public void draw() {

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


public int[] findPath(int bottomIndex, float[][] sums, int[] path) {

  // starting at the bottom index, go up row by row
  // looking for the smallest number, either to L,C, or R
  // of the current position
  int currentIndex = bottomIndex;
  for (int i=height-1; i>0; i-=1) {

    // if running the calculations on the row above to the L/R would
    // run us off the image (and cause an error), set the value to the edge
    if (currentIndex-1 <= 0) {
      path[i] = 0;
    }
    else if (currentIndex+1 >= width) {
      path[i] = width;
    }
    
    // otherwise, check the values above and above-L/R; use whichever has the
    // lowest value (energy) from the sums array
    else {
      float upL = sums[i-1][currentIndex-1];
      float upC = sums[i-1][currentIndex];
      float upR = sums[i-1][currentIndex+1];

      if (upC <= upL && upC <= upR) {      // prioritize center matches
        currentIndex += 0;
      }
      else if (upL < upC && upL < upR) {   // if left is the smallest
        currentIndex += -1;
      }
      else {                               // if right is the smallest
        currentIndex += 1;
      }

      // add to path array
      path[i] = currentIndex;
      // print(path[i] + " ");
    }
  }
  return path;
}

public int findStartPoint(float[][] sums, int padding) {
  
  // find smallest value in the last row
  float minValue = 1000;                        // temp value to start (much higher than likely
  for (int i=padding; i<width-padding; i++) {   // increment across bottom row **
    if (sums[height-1][i] < minValue) {         // if the current value is less than the previous low
      minValue = sums[height-1][i];             // update value (for future comparison)
      bottomIndex = i;                          // and update the index point
    }
  }
  
  // ** we pad the trip across on the L/R sides to avoid selecting the far edges
  //    and seems to avoid problems running offscreen
  
  // set current index in the sums array to a huge number so that it can't be chosen again
  sums[height-1][bottomIndex] = 1000;
  
  return bottomIndex;
}

public float[][] getSumsThroughImage() {

  // 2d array of the sums as we go down the image
  // see the Wikipedia entry listed in the head for
  // a good explanation of what's happening here
  float[][] sums = new float[height][width];

  // read first row
  for (int x=0; x<width; x++) {
    sums[0][x] = red(img.pixels[x]);
  }

  // read the rest
  for (int y=1; y<height; y++) {          // start with 1, since we already read 0
    for (int x=1; x<width-1; x++) {       // read from the 2nd to 2nd-to-last px

      float currentPx = red(img.pixels[y*width + x]);

      // test above L,C, and R sums
      float sumL = sums[y-1][x-1] + currentPx;
      float sumC = sums[y-1][x] + currentPx;
      float sumR = sums[y-1][x+1] + currentPx;
      if (sumL < sumC && sumL < sumR) {
        sums[y][x] = sumL;
      }
      else if (sumC < sumL && sumC < sumR) {
        sums[y][x] = sumC;
      }
      else {
        sums[y][x] = sumR;
      }
    }
  }

  // return the array of the sums of the image
  return sums;
}


public void runKernels(PImage hImg, PImage vImg) {

  float[][] vertKernel = { 
    { 
      -1, 0, 1
    }
    , 
    { 
      -1, 0, 1
    }
    , 
    { 
      -1, 0, 1
    }
  };
  float[][] horizKernel = { 
    {  
      1, 1, 1
    }
    , 
    {  
      0, 0, 0
    }
    , 
    { 
      -1, -1, -1
    }
  };

  // different kernels, but using the algorithm from
  // the Processing edge detection algorithm...

  // horizontally
  for (int y = 1; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) {
      float sum = 0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int pos = (y + ky)*img.width + (x + kx);
          float val = red(img.pixels[pos]);
          sum += horizKernel[ky+1][kx+1] * val;
        }
      }
      hImg.pixels[y*img.width + x] = color(sum);
    }
  }
  hImg.updatePixels();

  // .. and then again vertically
  for (int y = 1; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) {
      float sum = 0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int pos = (y + ky)*img.width + (x + kx);
          float val = red(img.pixels[pos]);
          sum += vertKernel[ky+1][kx+1] * val;
        }
      }
      vImg.pixels[y*img.width + x] = color(sum);
    }
  }
  vImg.updatePixels();

  // combine the two matrices
  for (int i=0; i<img.pixels.length; i++) {
    img.pixels[i] = color(red(hImg.pixels[i]) + red(vImg.pixels[i]));
  }

  // returns the image with pixels manipulated
  img.updatePixels();
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--hide-stop", "SeamCarving" });
  }
}
