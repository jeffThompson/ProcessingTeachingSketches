
import processing.pdf.*;

void setup() {
  
  size(11*72, 17*72);                // 11 x 17" at screen resolution
  beginRecord(PDF, "MyFile.pdf");    // start pdf file

  // do some stuff here!
  for (int i=0; i<100; i++) {
    line(random(0,width), random(0,height), random(0,width), random(0,height));
  }
  
  endRecord();
  exit();        // that's it!
}



