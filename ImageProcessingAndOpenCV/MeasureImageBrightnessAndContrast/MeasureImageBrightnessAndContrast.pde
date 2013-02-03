/*
MEASURE IMAGE BRIGHTNESS AND CONTRAST
Jeff Thompson | 2013 | www.jeffreythompson.org

Measures the overall contrast in an image using the Root Mean Square (RMS).

Based on this formula:
http://en.wikipedia.org/wiki/Contrast_%28vision%29#RMS_contrast
*/

// file to load (gray, mountain, truck)
String filename = "truck.jpg";

PImage img;
float brightness = 0;
float contrast = 0;

void setup() {
  
  img = loadImage(filename);
  size(img.width, img.height);
  image(img, 0,0);
  
  colorMode(RGB, 1.0);        // makes working with values easier, since RMS expects values 0-1
  loadPixels();               // load pixels into array, iterate!
  
  // find average brightness across image
  for (color c : pixels) {
    float r = c >> 16 & 0xFF;                                   // extract RGB values quickly (better than red(), etc)
    float g = c >> 8 & 0xFF;
    float b = c & 0xFF;
    brightness += (0.2126 * r) + (0.7152 * g) + (0.0722 * b);   // scales RGB to perceived brightness
  }
  brightness /= pixels.length;                                  // average result
  println("Average brightness: " + brightness);
  
  // find contrast by comparing average brightness with current value
  for (color c : pixels) {
    float r = c >> 16 & 0xFF;
    float g = c >> 8 & 0xFF;
    float b = c & 0xFF;
    float pxIntensity = (0.2126 * r) + (0.7152 * g) + (0.0722 * b);
    contrast += pow((brightness - pxIntensity), 2);
  }
  contrast /= pixels.length;
  println("Average contrast:   " + contrast);
}
