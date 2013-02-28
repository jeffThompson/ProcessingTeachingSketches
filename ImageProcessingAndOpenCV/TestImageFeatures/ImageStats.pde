
class ImageStats {

  PImage img;
  float[] red = new float[256];
  float[] green = new float[256];
  float[] blue = new float[256];

  ImageStats (String filename) {

    img = loadImage(filename);
    img.loadPixels();

    // create red, green, blue, and gray histograms
    for (int i=0; i<img.pixels.length; i++) {
      int bright = img.pixels[i] >> 16 & 0xFF;
      red[bright]++;
    }
    for (int i=0; i<img.pixels.length; i++) {
      int bright = img.pixels[i] >> 8 & 0xFF;
      green[bright]++;
    }
    for (int i=0; i<img.pixels.length; i++) {
      int bright = img.pixels[i] & 0xFF;
      blue[bright]++;
    }
  }

  // normalize 0.0 - 255.0
  void normalize(float low, float high) {
    float histMax = max(red);
    for (int i=0; i<red.length; i++) {
      red[i] = map(red[i], 0, histMax, low, high);
    }
    histMax = max(green);
    for (int i=0; i<green.length; i++) {
      green[i] = map(green[i], 0, histMax, low, high);
    }
    histMax = max(blue);
    for (int i=0; i<blue.length; i++) {
      blue[i] = map(blue[i], 0, histMax, low, high);
    }
  }

  // http://stackoverflow.com/a/596243  
  float getBrightness() {
    float brightness = 0;
    for (int i=0; i<img.pixels.length; i++) {
      float r = img.pixels[i] >> 16 & 0xFF;
      float g = img.pixels[i] >> 8 & 0xFF;
      float b = img.pixels[i] & 0xFF;
      brightness += (0.2126 * r) + (0.7152 * g) + (0.0722 * b);
    }
    return brightness/img.pixels.length;
  }

  // http://en.wikipedia.org/wiki/Contrast_%28vision%29#Michelson_contrast
  float getContrast() {
    float maxLum = 0;
    float minLum = 10000;
    for (int i=0; i<img.pixels.length; i++) {
      float r = img.pixels[i] >> 16 & 0xFF;
      float g = img.pixels[i] >> 8 & 0xFF;
      float b = img.pixels[i] & 0xFF;
      float brightness = (0.2126 * r) + (0.7152 * g) + (0.0722 * b);
      if (brightness > maxLum) maxLum = brightness;
      if (brightness < minLum) minLum = brightness;
    }
    return (maxLum - minLum)/(maxLum + minLum);
  }

  float getAcutance() {
    // essentially, run an edge-detection, then find mean of the result
    PImage edgeImg = createImage(img.width, img.height, RGB);
    edgeImg = edgeDetection(img, edgeImg);
    edgeImg.loadPixels();
    float acutance = 0;
    for (int i=0; i<edgeImg.pixels.length; i++) {
      acutance += edgeImg.pixels[i] >> 16 & 0xFF;
    }
    return acutance / edgeImg.pixels.length;
  }

  float widthToHeightRatio() {
    return (float)img.width/img.height;
  }

  // note this is not just value, but also color and saturation - in other words, while an
  // image may be high-contrast, if it has few color changes the result will be far lower
  float differenceAcrossImage() {
    float hDiff = 0;      // keep track of hue difference...
    float sDiff = 0;      // ...saturation
    float bDiff = 0;      // ... brightness

    for (int i=img.width; i<img.pixels.length-img.width; i++) {
      color r = img.pixels[i+1];
      color l = img.pixels[i-1];
      color u = img.pixels[i-img.width];
      color d = img.pixels[i+img.width];

      float h = hue(img.pixels[i]) - hue(r) - hue(l) - hue(u) - hue(d);
      float s = saturation(img.pixels[i])*4 - saturation(r) - saturation(l) - saturation(u) - saturation(d);
      float b = brightness(img.pixels[i])*4 - brightness(r) - brightness(l) - brightness(u) - brightness(d);

      hDiff += h;
      sDiff += s;
      bDiff += b;
    }
    hDiff = abs(hDiff / img.pixels.length);
    sDiff = abs(sDiff / img.pixels.length);
    bDiff = abs(bDiff / img.pixels.length);
    return (hDiff + sDiff + bDiff) / 3;
  }

  float averageSaturation() {
    float ave = 0;
    for (color c : img.pixels) {
      ave += saturation(c);
    }
    return ave/img.pixels.length;
  }

  float averageHue() {
    float ave = 0;
    for (color c : img.pixels) {
      ave += hue(c);
    }
    return ave/img.pixels.length;
  }

  float averageRed() {
    float ave = 0;
    for (color c : img.pixels) {
      ave += c >> 16 & 0xFFF;
    }
    return ave/img.pixels.length;
  }

  float averageGreen() {
    float ave = 0;
    for (color c : img.pixels) {
      ave += c >> 8 & 0xFFF;
    }
    return ave/img.pixels.length;
  }

  float averageBlue() {
    float ave = 0;
    for (color c : img.pixels) {
      ave += c & 0xFFF;
    }
    return ave/img.pixels.length;
  }

  color[] mostDominantColors(int steps) {
    PImage posterized = createImage(img.width, img.height, RGB);
    posterized.copy(img, 0, 0, img.width, img.height, 0, 0, img.width, img.height);
    posterized.filter(POSTERIZE, steps);
    posterized.loadPixels();
    Integer[] cast = new Integer[posterized.pixels.length];
    int i=0;
    for (int value : posterized.pixels) {
      cast[i++] = Integer.valueOf(value);
    }    
    Set<Integer> colors = new HashSet<Integer>(Arrays.asList(cast));
    color[] c = new color[0];
    for (color n : colors) {
      c = append(c, n);
    }
    return c;
  }

  // display the histogram
  void displayHistogram() {

    noStroke();
    fill(255, 0, 0, 150);
    beginShape();
    vertex(0, height);
    for (int i=0; i<256; i++) {
      int pos = int(map(i, 0, 255, 0, width));
      vertex(pos, height-red[i]);
    }
    vertex(width, height);
    endShape(CLOSE);

    fill(0, 255, 0, 150);
    beginShape();
    vertex(0, height);
    for (int i=0; i<256; i++) {
      int pos = int(map(i, 0, 255, 0, width));
      vertex(pos, height-green[i]);
    }
    vertex(width, height);
    endShape(CLOSE);

    fill(0, 0, 255, 150);
    beginShape();
    vertex(0, height);
    for (int i=0; i<256; i++) {
      int pos = int(map(i, 0, 255, 0, width));
      vertex(pos, height-blue[i]);
    }
    vertex(width, height);
    endShape(CLOSE);
  }
}

