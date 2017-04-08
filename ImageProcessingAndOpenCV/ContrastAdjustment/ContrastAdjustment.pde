
/*
CONTRAST ADJUSTMENT
 Jeff Thompson | 2012/17 | www.jeffreythompson.org
 
 A simple algorithm to adjust image contrast.
 
 Mostly via:
 http://stackoverflow.com/q/13500289/1167783
 
 */

int amount = 0;    // -255 to 255


void setup() {
  size(400, 300);
  
  PImage input = loadImage("cat.jpg");
  input = adjustContrast(input, amount);
  image(input, 0,0);
}


PImage adjustContrast(PImage img, int contrast) {
  contrast = constrain(contrast, -255,255);
  float amt = (255.0 + contrast) / 255.0;
  amt *= amt;
  
  img.loadPixels();
  for (int i=0; i<img.pixels.length; i++) {
    float r = img.pixels[i] >> 16 & 0xFF;
    float g = img.pixels[i] >> 8 & 0xFF;
    float b = img.pixels[i] & 0xFF;
    
    r /= 255.0;
    g /= 255.0;
    b /= 255.0;
    
    r = (((r - 0.5) * amt) + 0.5) * 255.0;
    g = (((g - 0.5) * amt) + 0.5) * 255.0;
    b = (((b - 0.5) * amt) + 0.5) * 255.0;
    
    r = r > 255 ? 255 : r;
    r = r < 0 ? 0 : r;
    
    g = g > 255 ? 255 : g;
    g = g < 0 ? 0 : g;
    
    b = b > 255 ? 255 : b;
    b = b < 0 ? 0 : b;
    
    img.pixels[i] = color(r, g, b);
  }
  
  img.updatePixels();
  return img;  
}