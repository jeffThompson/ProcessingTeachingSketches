/*
POSTERIZE and DOWNSAMPLE IMAGE
 Jeff Thompson
 February 2012
 
 Divides the image's color into discreet steps using the pixel's brightness.
 
 www.jeffreythompson.org
 */
 
String filename = "StarryNight.jpg";
PImage p;

void setup() {

  // load image and set size of screen to same
  p = loadImage(filename);           // load
  size(p.width, p.height);           // set size to that of the image
  colorMode(HSB, 255);               // allows us to access the brightness of a color

  // draw image to screen and access it's pixel values
  image(p, 0, 0);

  pixelateImage(80);    // argument is resulting pixel size
  posterizeImage(20);   // argument is the step size for posterization
  
  // save("PixelatedAndPosterized_" + filename);
}

void pixelateImage(int pxSize) {
 
  // use ratio of height/width...
  float ratio;
  if (width < height) {
    ratio = height/width;
  }
  else {
    ratio = width/height;
  }
  
  // ... to set pixel height
  int pxH = int(pxSize * ratio);
  
  noStroke();
  for (int x=0; x<width; x+=pxSize) {
    for (int y=0; y<height; y+=pxH) {
      fill(p.get(x, y));
      rect(x, y, pxSize, pxH);
    }
  }
}

void posterizeImage(int rangeSize) {
  
  // the built-in filter(POSTERIZE) works ok, but this is a bit more tweakable...  
  // iterate through the pixels one by one and posterize
  loadPixels();
  for (int i=0; i<pixels.length; i++) {

    // divide the brightness by the range size (gets 0-rangeSize), then
    // multiply by the rangeSize to step by that value; set the pixel!
    int bright = int(brightness(pixels[i])/rangeSize) * rangeSize;
    pixels[i] = color(bright);
  }
  updatePixels();
}

