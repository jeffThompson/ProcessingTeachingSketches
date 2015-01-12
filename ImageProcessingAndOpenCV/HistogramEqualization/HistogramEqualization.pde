
/*
HISTOGRAM EQUALIZATION
Jeff Thompson | 2014 | www.jeffreythompson.org

A good way to auto-contrast an image.

Based on (really, lifted and ported from):
http://zerocool.is-a-geek.net/java-image-histogram-equalization

*/


void setup() {
  
  // load input image, create output image
  PImage input = loadImage("test.png");
  PImage output = histogramEqualization(input);
  
  // show the results!
  size(input.width, input.height);
  image(output, 0,0);
}


// the main function (which calls two other functions below)
PImage histogramEqualization(PImage input) {
  
  // create a lookup table for equalization, create output image
  ArrayList<int[]> histogram = getHistogramEqualizationLookupTable(input);
  PImage output = new PImage(input.width, input.height, RGB);
  
  // go through pixel-by-pixel and set from lookup table
  input.loadPixels();
  output.loadPixels();
  for (int i=0; i<input.pixels.length; i++) {
    
    // here we extract the red value from the input, the look it up in the
    // lookup table
    int r = histogram.get(0)[ (input.pixels[i] >> 16 & 0xff) ];
    int g = histogram.get(1)[ (input.pixels[i] >> 8 & 0xff) ];
    int b = histogram.get(2)[ (input.pixels[i] & 0xff) ];

    // set to output image
    output.pixels[i] = color(r, g, b);
  }
  
  // all done!
  output.updatePixels();
  return output;
}


// creates an ArrayList "lookup table" for our image
ArrayList<int[]> getHistogramEqualizationLookupTable(PImage img) {
  
  // get an input histogram, create out lookup table
  ArrayList<int[]> imageHist = getImageHistogram(img);
  ArrayList<int[]> lookupTable = new ArrayList<int[]>();
  
  // arrays to count RGB values
  int[] rHist = new int[256];
  int[] gHist = new int[256];
  int[] bHist = new int[256];
  
  int sumR = 0;
  int sumG = 0;
  int sumB = 0;
  
  float scaleFactor = 255.0 / (img.width * img.height);
  
  for (int i=0; i<rHist.length; i++) {
    sumR += imageHist.get(0)[i];
    int valR = int(sumR * scaleFactor);
    if (valR > 255) rHist[i] = 255;
    else rHist[i] = valR;
    
    sumG += imageHist.get(1)[i];
    int valG = int(sumG * scaleFactor);
    if (valG > 255) gHist[i] = 255;
    else gHist[i] = valG;
    
    sumB += imageHist.get(2)[i];
    int valB = int(sumB * scaleFactor);
    if (valB > 255) bHist[i] = 255;
    else bHist[i] = valB;
  }
  
  lookupTable.add(rHist);
  lookupTable.add(gHist);
  lookupTable.add(bHist);
  
  return lookupTable;      
}


ArrayList<int[]> getImageHistogram(PImage img) {
  img.loadPixels();

  int[] rHist = new int[img.pixels.length];
  int[] gHist = new int[img.pixels.length];
  int[] bHist = new int[img.pixels.length];

  for (int i=0; i<img.pixels.length; i++) {
    int r = (int) img.pixels[i] >> 16 & 0xff;
    int g = (int) img.pixels[i] >> 8 & 0xff;
    int b = (int) img.pixels[i] & 0xff;

    rHist[r]++;
    gHist[g]++;
    bHist[b]++;
  }

  ArrayList<int[]> hist = new ArrayList<int[]>();
  hist.add(rHist);
  hist.add(gHist);
  hist.add(bHist);

  return hist;
}

