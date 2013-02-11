
import java.util.Arrays;
import java.util.Set;
import java.util.HashSet;

/*
 
X   Complexity
X   Brightness
    Saturation
    Dominant Hue (diff than overall colors via posterization)
~   Contrast
X   W/H ratio
X   Top N colors
    Sharpness/blurriness (http://stackoverflow.com/a/7767755)
    
 */

// files to try: black, blurry, gray, mountain, truck
String filename = "mountain.jpg";
ImageStats stats;

void setup() {
  
  stats = new ImageStats(filename);
  
  float brightness = stats.getBrightness();
  println("Brightness:           " + brightness);

  float contrast = stats.getContrast();
  println("Contrast:             " + contrast);
  
  float acutance = stats.getAcutance();
  println("Acutance:             " + acutance);
  
  float widthToHeight = stats.widthToHeightRatio();
  println("Width/Height Ratio:   " + widthToHeight);
  
  float diffAcross = stats.differenceAcrossImage();
  println("Diff Across Image:    " + diffAcross);
  
  color[] mostDominant = stats.mostDominantColors(4);  // num colors
  println(mostDominant.length + " Most Dominant Colors:");
  for (int i=0; i<mostDominant.length; i++) {
    println("  " + (mostDominant[i] >> 16 & 0xFF) + ", " + (mostDominant[i] >> 8 & 0xFF) + ", " + (mostDominant[i] & 0xFF));
  }

  // display the image
  PImage img = loadImage(filename);
  size(img.width, img.height);
  image(img, 0, 0);
  filter(POSTERIZE, 4);
  
  /*
  noStroke();
  fill(mostDominant);
  rect(0,0, width, 30);
  stroke(0, 100);
  line(0,30, width,30);
  */
  
  stats.normalize(0.0, 255.0);
  stats.displayHistogram();
}
