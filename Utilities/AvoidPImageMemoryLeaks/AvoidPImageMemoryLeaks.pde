
/*
AVOID PIMAGE MEMORY LEAKS
Jeff Thompson | 2013 | www.jeffreythompson.org

The PImage object has caused lots of problems for those working with large
numbers of images, even when they are loaded one at a time into the same
PImage!  While Java should do 'garbage collection' and delete the previous
data, for some reason this does not happen in this case.

To solve this, we can use the g.removeCache(imageVariable) command!

Built from PhiLho's excellent suggestion:
https://forum.processing.org/topic/pimage-memory-leak-example#25080000001807951

*/

boolean manuallyDeleteImage = true;                // test it!

void setup() {
  size(400, 400);
}

// re-create the PImage each frame - without 'removeCache' we quickly
// run out of memory!
void draw() {
  
  PImage img = createImage(width, height, RGB);    // create a new PImage - shouldn't cause any problems, right?
  image(img, 0, 0);                                // display
  
  if (manuallyDeleteImage) {
    g.removeCache(img);                              // delete from memory manually
    println(frameCount + ":\t" + g.getCache(img));     // prove to us the PImage is no longer in existence!
  }
}

