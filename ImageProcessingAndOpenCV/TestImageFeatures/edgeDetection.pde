
PImage edgeDetection(PImage img, PImage edgeImg) {
  float[][] kernel = {{ -1, -1, -1 }, 
                      { -1, 9, -1 }, 
                      { -1, -1, -1 }};
  
  for (int y = 1; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) {
      float sum = 0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int pos = (y + ky)*img.width + (x + kx);
          float val = red(img.pixels[pos]);
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      edgeImg.pixels[y*img.width + x] = color(sum, sum, sum);
    }
  }
  edgeImg.updatePixels();
  return edgeImg;
}

