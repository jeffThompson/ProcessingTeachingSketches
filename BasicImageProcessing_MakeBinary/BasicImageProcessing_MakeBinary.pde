/*
BASIC IMAGE PROCESSING - MAKE BINARY
 Jeff Thompson
 April 2012
 
 Image processing isn't as difficult as it might seems - it's often just a matter
 of simple math applied to individual pixels.
 
 Here we load an image, iterate pixel-by-pixel, get an average color value, test
 that color, and set the pixels to a new value.
 
 This kind of image processing can lead to edge detection, blurring, and custom
 compression algorithms!
 
 www.jeffreythompson.org
 */

int thresh = 100;    // a value above which we set pixel to white, below to black
PImage img;          // the PImage variable is what Processing uses to store images

void setup() {

  // basic setup
  img = loadImage("test.png");    // first load the image
  size(img.width, img.height);    // the set the window size to that of the image

  // display the image
  image(img, 0, 0);                // arguments: PImage variable, x pos, y pos

  // get pixel data and process
  // we do this by accessing a special array called 'pixels' that
  // contains all the color data - it is linear and has no columns or
  // rows, so it can take a little getting used to (see FindDifferenceAcrossImage
  // for an example of how this works)
  loadPixels();
  for (int i=0; i<pixels.length; i++) {  // since pixels is an array, get # elements

    // store temporary values with colors from the pixels
    float r = red(pixels[i]);
    float g = green(pixels[i]);
    float b = blue(pixels[i]);
    
    // average into a single value
    float averageColor = (r + g + b)/3;

    // if the average is above the threshold, set color to white; otherwise black
    if (averageColor > thresh) {
      pixels[i] = color(255);      // we can change pixel values by changing the array's values
    }
    else {
      pixels[i] = color(0);
    }
  }
  
  // we must call the updatePixels() function to see the changes - this is
  // easy to forget and will cause you not to see your cool code
  updatePixels();
}

