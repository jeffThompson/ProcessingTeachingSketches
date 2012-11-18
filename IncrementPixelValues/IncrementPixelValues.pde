/*
INCREMENT PIXEL VALUES
Jeff Thompson
April 2012

Increments pixel colors in washes of trippy goodness.

www.jeffreythompson.org
*/

int increment = 10;                // amount to add each increment
PImage img;                        // object to load image

void setup() {  
  img = loadImage("test.jpg");     // load the image
  size(img.width, img.height);     // set the size of the window to that of the image
}

void draw() {

  img.loadPixels();
  for (int i=0; i<img.pixels.length; i++) {       

    // increment red, green, and blue
    img.pixels[i] = color(red(img.pixels[i]) + increment, green(img.pixels[i]) + increment, blue(img.pixels[i]) + increment);    

    // if values are above 255, set that color back to 0
    if (red(img.pixels[i]) >= 255) {
      img.pixels[i] = color(0, green(img.pixels[i]), blue(img.pixels[i]));
    }
    if (green(img.pixels[i]) >= 255) {
      img.pixels[i] = color(red(img.pixels[i]), 0, blue(img.pixels[i]));
    }
    if (blue(img.pixels[i]) >= 255) {
      img.pixels[i] = color(red(img.pixels[i]), green(img.pixels[i]), 0);
    }
  }
  img.updatePixels();    // set the changes

  image(img, 0, 0);      // display the image!
}

