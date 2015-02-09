
/*
PLACING IMAGES
Jeff Thompson | 2015 | www.jeffreythompson.org

Supported file formats:
JPG, PNG, GIF, TIFF

Note that files supporting transparency (like PNG) retain
transparency when imported - our donut has a nice clear
background!

*/

PImage img;    // PImage object lets us load and display image files

void setup() {
  size(800,600);
  background(255,200,150);
  
  // load image – file MUST be in sketch folder, otherwise specify a full path
  img = loadImage("donut.png");
  
  // display the image!
  image(img, width/2, height/2);
  
  // lots of random donuts at random placement + sizes
  // note we can access the image's dimensions using width and height
  for (int i=0; i<100; i++) {
    float ratio = random(0.1, 1.0);
    image(img, random(width), random(height), img.width * ratio, img.height * ratio);
  }
  
}

