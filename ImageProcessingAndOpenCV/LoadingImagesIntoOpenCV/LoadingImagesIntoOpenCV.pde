import hypermedia.video.*;
import java.awt.Rectangle;

/*
LOADING IMAGES INTO OpenCV FOR FACE RECOGNITION
Jeff Thompson
April 2012

While the documentation for OpenCV and video is clear and easy, loading
still images is less well-explained.  Here we load a pre-existing file
in for face recognition; if found a red rectangle is drawn over the face.

Requires the Processing OpenCV library:
http://ubaa.net/shared/processing/opencv

www.jeffreythompson.org
*/

String filename = "FaceTest.jpg";                   // image file to load
// String filename = "NonFaceTest.jpg";             // other files to try...
// String filename = "KidsInMasks.jpg";             // will it work?
// String filename = "KidsFromBloodyBirthday.jpg";  // also very creepy...
// String filename = "ChimpFace.jpg";               // works ok on non-humans too

int contrast = 0;                                   // -128 to 128
int bright = 0;                                     // ditto
OpenCV oc;                                          // OpenCV object

void setup() {
  
  // get the image's dimensions to auto-set the size of the window
  // not the cleanest solution, but easy to read and is flexible
  PImage tempImage = loadImage(filename);
  
  // set window size to the same as the image
  size(tempImage.width, tempImage.height);

  // create OpenCV object and load the image file
  oc = new OpenCV(this);                             // create OpenCV object
  oc.allocate(tempImage.width, tempImage.height);    // allocate memory for image's pixels
  
  // read the image by copying the pixels into the OpenCV object
  oc.copy(tempImage.pixels, tempImage.width, 0,0, tempImage.width, tempImage.height, 0,0, tempImage.width, tempImage.height);
  oc.cascade(OpenCV.CASCADE_FRONTALFACE_ALT2);       // specify what kind of detection we're doing**
  
  // ** other options include 3 other front-face, profile face, full body, and others
  //    see the OpenCV documentation for the cascade() function for more information
  
  // do conversion as needed
  oc.convert(GRAY);           // convert to grayscale
  oc.contrast(contrast);      // adjust contrast if specified at the top
  oc.brightness(bright);      // ditto brightness
  
  // look for faces, load results into an array
  // first 3 arguments are scaling, minimum neighbors, ignore some edges (see docs)
  // last 2 arguments are minimum size in pixels (could be set based on the image size)
  Rectangle[] faces = oc.detect(1.2, 2, OpenCV.HAAR_DO_CANNY_PRUNING, 60,60);
  
  // draw the image to the screen
  image(oc.image(), 0,0);
  
  // if a face is found, draw a box around it
  println("FOUND " + faces.length + " FACE(S):");
  fill(255,0,0, 100);
  stroke(255);
  for (int i=0; i<faces.length; i++) {
    
    // draw the rectangle, let us know where
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    println((i+1) + ".  " + faces[i].x + "x," + faces[i].y + "y    (" + faces[i].width + " x " + faces[i].height + "px)");
  }
}

// be "nice" when quitting...
public void stop() {
  oc.stop();            // close OpenCV processes
  super.stop();         // ... and everything else too
}
