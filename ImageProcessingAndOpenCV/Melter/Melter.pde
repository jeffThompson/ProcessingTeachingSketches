import gifAnimation.*;

/*
MELTER
Jeff Thompson | 2012 | www.jeffreythompson.org

Melt your photos.

*/

// String filename = "taco.jpg";
String filename = "romney.jpg";
// String filename = "sunset.jpg";
// String filename = "cat.jpg";
// String filename = "obama.jpg";
// String filename = "rhino.jpg";

int numFrames = 60;
int numDrips = 4000;
GifMaker gif;

void setup() {
  
  // load an image, set size accordingly
  PImage img = loadImage(filename);
  size(img.width, img.height);
  
  // GifMaker setup stuff (remove input extension, rename to gif
  gif = new GifMaker(this, "melting-" + filename.substring(0, filename.lastIndexOf('.')) + ".gif");
  gif.setRepeat(0);
  
  // pick some random pixels to mess with
  int[] dripPixels = new int[numDrips];
  for (int i=0; i<numDrips; i++) {
    dripPixels[i] = int(random(0, width*height));
  }
  
  // iterate a bunch of frames
  for (int i=0; i<numFrames; i++) {
    
    // load pixels for processing
    img.loadPixels();
    
    // do something
    for (int d=0; d<dripPixels.length; d++) {
      int px = dripPixels[d];                  // get pixel location
      color c = img.pixels[px];                // get color
      if (px + width*i < width*height) {       // if px below isn't offscreen...
        img.pixels[px+width*i] = c;            // drip the pixel down
      }
    }
    
    // update and display the image
    img.updatePixels();
    image(img, 0,0);
    
    // add frame to the animation
    println(i + "/" + numFrames);
    gif.setDelay(1);
    gif.addFrame();
  }
  
  // all done!
  gif.finish();
  println("DONE!");
  exit();  
}
