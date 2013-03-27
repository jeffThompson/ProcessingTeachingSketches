
import processing.pdf.*;             // import required PDF export library

/*
PDF EXPORT
Jeff Thompson | 2013 | www.jeffreythompson.org

Save a vector PDF file, which can easily be edited in Illustrator.

Note: this will overwrite any existing files, so beware!
*/

void setup() {
  
  size(11*72, 17*72);                // 11 x 17" at screen resolution  
  beginRecord(PDF, "MyFile.pdf");    // start pdf file
  
  // note we can skip the background() command if you want it
  // to be transparent!

  // draw some stuff here!
  for (int i=0; i<1000; i++) {
    line(random(0,width), random(0,height), random(0,width), random(0,height));
  }
  
  endRecord();      // end recording, file is saved in your sketch folder
}



