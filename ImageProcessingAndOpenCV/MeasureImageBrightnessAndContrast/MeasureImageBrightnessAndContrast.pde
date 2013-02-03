/*
MEASURE IMAGE BRIGHTNESS AND CONTRAST
Jeff Thompson | 2013 | www.jeffreythompson.org

Measures the overall brightness and contrast in an image.

NOTE: this is average for both measures, meaning localized areas of 
extreme brightness/contrast may throw off the measurements.

Contrast based on this formula:
http://en.wikipedia.org/wiki/Contrast_%28vision%29#RMS_contrast

Thanks to Amnon Owed for helping figure out the contrast/RMS algorithm!
https://forum.processing.org/topic/calculate-image-contrast-using-root-mean-square-rms#25080000001971367
*/

// file to load (gray, mountain, truck)
String filename = "truck.jpg";

boolean normalizeRange = true;    // normalize results to range of 0-1
PImage img;
float brightness = 0;
float contrast = 0;

void setup() {
  
  img = loadImage(filename);
  size(img.width, img.height);
  image(img, 0,0);
  loadPixels();                   // load pixels into array, iterate!
  
  // find average brightness across image
  for (color c : pixels) {
    float r = c >> 16 & 0xFF;                                                 // extract RGB values quickly (better than red(), etc)
    float g = c >> 8 & 0xFF;
    float b = c & 0xFF;
    brightness += (0.2126 * r) + (0.7152 * g) + (0.0722 * b);                 // scales RGB to perceived brightness
    if (normalizeRange) {
      brightness /= 255.0;                                                    // normalize to 0-1
    }
  }
  brightness /= pixels.length;                                                // average result
  println("Average brightness: " + brightness);
  
  // find contrast by comparing average brightness with current value
  for (color c : pixels) {
    float r = c >> 16 & 0xFF;
    float g = c >> 8 & 0xFF;
    float b = c & 0xFF;
    float pxIntensity = (0.2126 * r) + (0.7152 * g) + (0.0722 * b);
    if (normalizeRange) {
         pxIntensity /= 255.0;                                                // normalizes to range 0-1
    }
    contrast += pow((brightness - pxIntensity), 2);
  }
  contrast /= pixels.length;
  println("Average contrast:   " + contrast);
}
