
/*
DITHER
Jeff Thompson | 2017 | jeffreythompson.org

Old-school black-and-white dithering.

Lots of possible dithering algorithms exist, but this
one is the Bayer 8x8 method – not the fanciest but it's
computationally cheap and the code is fairly straightforward.

Via slightly modified version of this example: 
http://bazaar.launchpad.net/~philho/+junk/Processing/view/
head:/_QuickExperiments/_Interactive/Dithering/Dithering.pde

Lots more examples:
http://imagej.net/Dithering

*/


void setup() {
  size(800, 800);                
  PImage img = loadImage("Kitten.jpg");
  
  // dither it!
  // 4 = level for dithering (max = 5)
  // try playing with this value and see how the image changes 
  img = dither(img, 4);
  
  image(img, 0,0);
  save("DitheredKitten.png");    // jpg will leave weird artifacts... :(
}
  

PImage dither(PImage in, int level) {

  // anything above 5 doesn't result in 
  // better images and is very slow
  if (level > 5) level = 5;
  
  float f = 255.0 / (pow(2, 2*level) + 1);
  
  // let's do it
  in.loadPixels();
  for (int x=0; x<in.width; x++) {
    for (int y=0; y<in.height; y++) {      
      
      // calculate threshold for black/white pixel
      float thresh = ditherCalc(x, y, level) * f;
      
      // get average value for pixel
      color c = in.pixels[y * in.width + x];
      int r = c >> 16 & 0xFF;
      int g = c >> 8 & 0xFF;
      int b = c & 0xFF;
      float mean = (r + g + b) / 3.0;
      
      // set color of current px based on thresh
      if (thresh >= mean) in.pixels[y * in.width + x] = color(0);
      else                in.pixels[y * in.width + x] = color(255);
    }
  }
  in.updatePixels();
  return in;
}


int ditherCalc(int i, int j, int n) {
  if (n == 1) return (i % 2 != j % 2 ? 2 : 0) + j % 2;
  else        return 4 * ditherCalc(i % 2, j % 2, n-1) + ditherCalc(int(i/2), int(j/2), n-1);
}       