/*
CONTRAST ADJUSTMENT
 Jeff Thompson | 2012 | www.jeffreythompson.org
 
 A simple algorithm to adjust image contrast.
 */

float increment = 0.5;    // amount to adjust contrast each time the arrow keys are hit
float contrast = 127;     // 0 - 255
PImage source, copy;

void setup() {
  source = loadImage("cat.jpg");
  copy = loadImage("cat.jpg");          // a copy to store the unaltered pixels (ie: non-destructive editing)
  size(source.width, source.height);
}

void draw() {
  image(source, 0, 0);
}

PImage adjustContrast(PImage img, float contrast) {

  // ensure our contrast is in a legal range of 0-255
  contrast = constrain(contrast, 0.0, 255.0);

  // find difference from center (127), equal to the adjustment we make to the image!
  float adjustment = map(contrast, 0, 255, -127, 127);
  println(adjustment);

  img.loadPixels();
  for (int i=0; i<img.pixels.length; i++) {

    // get RGB values from the pixels and adjust
    float r = img.pixels[i] >> 16 & 0xFF;    // faster equivelant to red() command
    float g = img.pixels[i] >> 8 & 0xFF;     // ditto green
    float b = img.pixels[i] & 0xFF;          // and blue! 

    // decrease contrast by moving into center (easier)
    if (adjustment < 0) {
      r = map(r, 0, 255, adjustment, 255-adjustment);
      g = map(g, 0, 255, adjustment, 255-adjustment);
      b = map(b, 0, 255, adjustment, 255-adjustment);
    }
    // increase contrast by moving away from center (a bit more complicated
    else {
      if (r > 127) {
        r = map(r, 0, 255, 127+adjustment, 255);
      }
      else {
        r = map(r, 0, 255, 0, 127-adjustment);
      }
      
      if (g > 127) {
        g = map(g, 0, 255, 127+adjustment, 255);
      }
      else {
        g = map(g, 0, 255, 0, 127-adjustment);
      }
      
      if (b > 127) {
        b = map(b, 0, 255, 127+adjustment, 255);
      }
      else {
        b = map(b, 0, 255, 0, 127-adjustment);
      }
    }

    img.pixels[i] = color(r, g, b);
    // println(r + ", " + g + ", " + b);
  }
  img.updatePixels();
  return img;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      contrast += increment;
      source = adjustContrast(copy, contrast);
    }
    else if (keyCode == DOWN) {
      contrast -= increment;
      source = adjustContrast(copy, contrast);
    }
  }
  else if (key == 32) {
    setup();
  }
}

