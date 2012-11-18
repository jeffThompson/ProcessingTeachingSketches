/*
DOWNLOAD IMAGE FILE
Jeff Thompson
March 2012

Download and save an image from a URL - this is
a hack and only works in Processing; doing this
using normal Java methods is more complex (but
completely possible).

www.jeffreythompson.org
*/

// a normal PImage like loading locally
PImage img;

// url of the image file we want to load
String url = "http://www.jeffreythompson.org/Processing/sampleImage.png";

void setup() {
  
  // using loadImage and the url, we download the file
  println("Downloading image...");
  img = loadImage(url, "png");
  
  // save to a specified filename
  println("Saving file...");
  img.save("DownloadedImage.png");
  
  exit();
}
  
