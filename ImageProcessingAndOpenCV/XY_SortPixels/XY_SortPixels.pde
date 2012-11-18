
String[] files = { 
  "ocean.jpg", "field.jpg", "tucan.jpg"
};
PImage img;

void setup() {

  for (String currentFile : files) {
    img = loadImage(currentFile);
    size(img.width, img.height);

    String justFilename = currentFile.substring(0, currentFile.lastIndexOf("."));

    img = sortX(img);
    image(img, 0, 0);
    save("sorted/" + justFilename + "_X.png");

    img = loadImage(currentFile);
    img = sortY(img);
    image(img, 0, 0);
    save("sorted/" + justFilename + "_Y.png");

    img = loadImage(currentFile);
    img = sortX(img);
    img = sortY(img);
    image(img, 0, 0);
    save("sorted/" + justFilename + "_XY.png");
  }
  exit();
}

PImage sortX(PImage img) {
  // sort in horizontal lines
  img.loadPixels();
  for (int y=0; y<img.height; y++) {

    color[] c = new color[img.width];

    for (int x=0; x<img.width; x++) {
      c[x] = img.pixels[y*width + x];
    }

    c = sort(c);

    for (int x=0; x<img.width; x++) {
      img.pixels[y*width + x] = c[x];
    }
  }
  img.updatePixels();
  return img;
}

PImage sortY(PImage img) {
  // sort vertically
  img.loadPixels();
  for (int x=0; x<img.width; x++) {

    color[] c = new color[img.height];

    for (int y=0; y<img.height; y++) {
      c[y] = img.pixels[y*width + x];
    }

    c = sort(c);

    for (int y=0; y<img.height; y++) {
      img.pixels[y*width + x] = c[y];
    }
  }
  img.updatePixels();
  return img;
}

