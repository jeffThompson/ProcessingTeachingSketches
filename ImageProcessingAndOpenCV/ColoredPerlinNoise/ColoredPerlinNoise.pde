
/*
COLORED PERLIN NOISE
 Jeff Thompson | 2016 | jeffreythompson.org
 
 Perlin noise can generate very realistic, smooth
 randomness that other methods like Brownian
 motion can't. The Processing examples include
 (under Basics > Math...) a 1D, 2D, and 3D example.
 
 This example adds shifting color, using the HSB
 color model for smooth transitions.
 
 */

// the "resolution" of the noise
float inc = 0.008;

// "rate of change" for the noise
float zInc = 0.1;

// min/max values for noise
float hueMin =    0;      // hue
float hueMax =    255;
float satMin =    100;    // saturation
float satMax =    255;
float brightMin = 200;    // brightness
float brightMax = 220;

// keep track of x/y noise position
float hxOff, hyOff, sxOff, syOff, bxOff, byOff;
float zOff = 0;
float h, s, b;


void setup() {
  size(600, 600);
  colorMode(HSB, 255);
  noiseDetail(4, 0.01);
}


void draw() {
  // each frame, run through the noise()
  // function, generating pixels to fill
  // the screen

  loadPixels();
  hxOff = sxOff = bxOff = 0;

  for (int x=0; x<width; x++) {
    hxOff += inc;
    sxOff += inc;
    bxOff += inc;

    hyOff = syOff = byOff = 0;
    for (int y=0; y<height; y++) {
      hyOff += inc;
      syOff += inc;
      byOff += inc;

      // create hue value from noise(), then
      // map to the desired range
      h = noise(hxOff, hyOff, zOff) * 255;
      h = map(h, 0, 255, hueMin, hueMax);

      // same for saturation and brightness too
      s = noise(sxOff, syOff, zOff) * 255;
      s = map(s, 0, 255, satMin, satMax);
      b = noise(bxOff, byOff, zOff) * 255;
      b = map(b, 0, 255, brightMin, brightMax);
      pixels[x + y*width] = color(h, s, b);
    }
  }
  updatePixels();
  zOff += zInc;

  // show the value of the center pixel
  stroke(255);
  line(width/2, height/2, 80, height-80);
  fill(255);
  noStroke();
  ellipse(width/2, height/2, 8, 8);

  h = hue(pixels[pixels.length/2]);
  s = saturation(pixels[pixels.length/2]);
  b = brightness(pixels[pixels.length/2]);
  text(int(h) + ", " + int(s) + ", " + int(b), 30, height-50);
}