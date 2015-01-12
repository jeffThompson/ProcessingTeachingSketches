
/*
LOADING DATA, MAPPING VALUES
 Jeff Thompson | 2014 | www.jeffreythompson.org
 
 A starting point sketch that loads data, parses the results, 
 scales the values into usable ranges for color and screen
 coordinates, and draws the results to the screen.
 
 Here, we use the Equirectangular Projection, where every division of
 latitude/longitude is equally-spaced.  For more information on this
 projection, see:
 + http://en.wikipedia.org/wiki/Equirectangular_projection
 
 Map images from:
 + http://en.wikipedia.org/wiki/File:Equirectangular_projection_SW.jpg
 + http://commons.wikimedia.org/wiki/File:BlankMap-World6-Equirectangular.svg
 
 CHALLENGE:
 1. Try changing the parameters of the map() commands and see how
 it transforms your visualization. How can you play with scale, color,
 and other values to change what data is most prominent?
 
 2. Instead of using our local file, try loading realtime data from
 the USGS - just change the filename for a URL! Note: it would be a
 good idea to comment-out the println() command when using large data
 sets, as it can cause Processing to freak out and crash!
 
 URL: http://earthquake.usgs.gov/earthquakes/feed/csv/2.5/month
 
 */

String filename = "earthquakes.csv";
Table data;
PImage map;

void setup() {

  // BASIC SETUP
  size(1000, 500);    // this is the size of our map image
  background(255);    // set background to white


  // LOAD DATA
  // load the data into a Table object - we specify that the first
  // row is a header, which is both skipped and loaded as easy to
  // get parameters when iterating the data!
  data = loadTable(filename, "header");
  println("# of entries: " + data.getRowCount());


  // LOAD IMAGE
  // we can also load our map image for later - we could also 
  // set the size of our sketch using map.width and map.height
  map = loadImage("equirectangular.png");
  image(map, 0, 0);


  // ITERATE DATA, VISUALIZE!
  // using a 'for' loop, we go through each row (listing) in the data
  // and extract the magnitude and depth of each earthquake using
  // the Table object's getFloat() method - we can also extract
  // ints and strings, depending on our data set
  for (TableRow row : data.rows()) {
    float magnitude = row.getFloat("magnitude");
    float depth = row.getFloat("depth");
    println("magnitude: " + magnitude + ", depth: " + depth);


    // SCALE DATA FOR DRAWING ONSCREEN
    // magnitude is measured on the Richter scale in the range
    // of 0-10, so we can use that as the input range, scaling it
    // to a diameter of 5-100 pixels 
    magnitude = map(magnitude, 0.0, 10.0, 5.0, 100.0);

    // the depth range will vary depending on our data set, but
    // here we scale it from an input range of 0-200 to a useful
    // color range of 0-255
    depth = map(depth, 0.0, 200.0, 0.0, 255.0);


    // VISUALIZE!
    // first, set red value to depth, with a little transparency
    // so we can see the other data points more easily
    // then we place the circles randomly onscreen, using their
    // scaled magnitude for their diameters
    fill(depth, 0, 0, 200);
    noStroke();
    //ellipse(random(width), random(height), magnitude, magnitude);

    // BETTER - PLACE ON MAP!
    // our above version is great, but doesn't really give us any
    // context for the data, ie the location - here we also load
    // the longitude (x-axis) and latitude (y-axis) and scale those
    // values to screen coordinates
    float lon = row.getFloat("longitude");
    float lat = row.getFloat("latitude");

    lon = map(lon, -180.0, 180.0, 0, width);
    lat = map(lat, 90.0, -90.0, 0, height);
    ellipse(lon, lat, magnitude, magnitude);
  }
}

