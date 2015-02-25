
/*
SAVE STILL IMAGES
Jeff Thompson | 2015 | www.jeffreythompson.org

Saving images in Processing is easy!

FORMATS
Supported formats include jpg, png, tiff, and gif

WHERE?
Images are saved to your sketch folder by default, or you
can specify a folder (which will get created) or a full
path. Note that images will be overwritten without warning!

*/


void setup() {
  size(600,600);
  
  // draw something!
  background(0);
  fill(255);
  ellipse(width/2, height/2, 100,100);
  
  // save to the sketch folder - note we need the
  // file extension as well
  save("WhiteCircle.png");
  
  // save to a folder called "OutputFrames" which
  // will be created automatically
  // save("OutputFrames/WhiteCircle.png");
}


