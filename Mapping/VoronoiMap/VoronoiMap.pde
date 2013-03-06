import megamu.mesh.*;

/*
VORONOI MAP
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Using GPS coordinates of US state capitals, we draw a Voronoi diagram
 (http://en.wikipedia.org/wiki/Voronoi_diagram) using the capitals as
 seed points. This diagram is then masked to refit the US borders.
 
 Map image via:
 http://commons.wikimedia.org/wiki/File:USA_location_map.svg
 
 (aside: the US Air Force calls the continental US "CONUS")
 
 State capital GPS coordinates via a modified version of:
 http://www.xfront.com/us_states
 
 Requires Lee Byron's Mesh library; download here:
 http://leebyron.com/else/mesh
 */

float[][] points = new float[48][2];    // 48 states with 2 values each (x/y)
String[] gpsData;                       // string array of data from a csv file
Voronoi voronoi;
PImage map;
PImage mask;

void setup() {

  // load gps data and map image
  gpsData = loadStrings("StateCapitals.csv");
  map = loadImage("EquirectangularUSA.png");
  mask = loadImage("EquirectangularUSA-Mask.png");

  // basic setup
  size(map.width, map.height);
  smooth();
  noStroke();

  // display the map
  image(map, 0, 0);

  // extract points from the gps data, convert to screen coordinates
  for (int i=0; i<points.length; i++) {                                             // iterate all gps data
    String[] coords = split(gpsData[i+1], ",");                                     // split line - note +1 so we don't read the header in the file
    float longitude = map(Float.parseFloat(coords[2]), -125.5, -66.5, 0, width);    // convert to screen coordinates
    float latitude = map(Float.parseFloat(coords[1]), 50, 24, 0, height);           // these are "tuned" to the map
    points[i][0] = longitude;                                                       // x position
    points[i][1] = latitude;                                                        // y position
  }

  // draw Voronoi shapes
  voronoi = new Voronoi(points);
  MPolygon[] regions = voronoi.getRegions();
  for (int i=0; i<regions.length; i++) {
    fill(random(50, 255), random(0,150), 0, 200);  // random red/orange with a little transparency
    stroke(255);
    regions[i].draw(this);
  }
  
  // draw a mask on top to redraw the US country boundaries
  image(mask, 0,0);

  // draw the capitals as dots
  fill(255);
  noStroke();
  for (int i=0; i<points.length; i++) {
    ellipse(points[i][0], points[i][1], 8, 8);
  }
}

