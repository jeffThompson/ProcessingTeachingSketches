/*
LOADING IMAGES
Jeff Thompson | 2013 | www.jeffreythompson.org

Loading images with Android is a bit nit-picky - your image
must be inside a 'data' folder or it may not load!

To see what memory is available to your app, depending on your
device, see the 'GetAvailableMemory' sketch.

Image via Wikipedia user Christian Nawroth:
http://en.wikipedia.org/wiki/File:ZugspitzeJubilaeumsgratHoellental.jpg
*/

PImage img;
int circleSize;

void setup() {
  orientation(LANDSCAPE); 
  img = loadImage("mountains.jpg");      // load image - MUST BE IN DATA FOLDER
  
  mouseX = width/2;
  mouseY = height/2;
  circleSize = min(width,height) / 3;    // make circle 1/3 of smallest dimension
}

void draw() {
  
  // alternatively, add two extra arguments to scale the image
  // to fit the screen (which will vary from device to device)
  image(img, 0,0, width,height);
  
  // draw a semi-transparent circle over the image!
  fill(0,150);
  ellipse(mouseX,mouseY, circleSize, circleSize);
}
