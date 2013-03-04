/*
MAP OVERLAY - PICKING YOUR PROJECTION
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 With GPS data in hand, placing a dot on a map can be more challenging
 than simply mapping coordinates to the screen size. The style of
 projection for your map can making this a trivial or very difficult
 process.
 
 Here, we use the Equirectangular Projection, where every division of
 latitude/longitude is equally-spaced.  For more information on this
 projection, see:
 http://en.wikipedia.org/wiki/Equirectangular_projection
 
 Map images from:
 http://en.wikipedia.org/wiki/File:Equirectangular_projection_SW.jpg
 http://commons.wikimedia.org/wiki/File:BlankMap-World6-Equirectangular.svg
 
 First, we load a sample GPS location for a "sanity-test" to make sure our
 system is working. Then we pull live earthquake data from the US Geological
 Service (USGS) from their real-time data; the data used here is earthquakes
 from the last 30 days that were magnitude 2.5 or greater:
 http://earthquake.usgs.gov/earthquakes/feed/csv/2.5/month
 
 Get more versions of thie data at:
 http://earthquake.usgs.gov/earthquakes/feed
 
 A historical version of this data is saved in the sketch folder for those
 without reliable internet connections or in case the USGS service is removed.
 
 CHALLENGE:
 1. Can you map the magnitude (intensity) of the earthquake from the data file
 to the size of the dot?
 */

// GPS coordinates for Lincoln, Nebraska, USA
// we use this data to test our projection
float lat = 40.4835;
float lon = -96.4031;

// load realtime data from the internet (or an offline file, if you prefer)
String[] earthquakes = loadStrings("http://earthquake.usgs.gov/earthquakes/feed/csv/2.5/month");

// load map images
PImage mapSatellite;
PImage mapMonochrome;

void setup() {

  // load images
  mapSatellite = loadImage("Equirectangular-Satellite.png");
  mapMonochrome = loadImage("Equirectangular-Monochrome.png");

  // basic setup
  size(mapSatellite.width, mapSatellite.height);    // set screen to the image size
  smooth();
  noStroke();

  // convert test coords from lat/lon to screen coordinates
  lat = map(lat, 90.0, -90.0, 0, height);
  lon = map(lon, -180.0, 180.0, 0, width);
}

void draw() {

  // draw the map image to screen
  image(mapMonochrome, 0, 0);

  // display test coordinates
  fill(0, 75, 150, 150);
  ellipse(lon, lat, 25, 25);

  // go through the earthquake file and display the data
  for (int i=1; i<earthquakes.length; i++) {              // load all but the first line (header for the file)

    // parse the data line-by-line
    String[] earthquake = split(earthquakes[i], ",");     // split at commas into an array
    float latitude = Float.parseFloat(earthquake[1]);     // latitude is item 2 (index 1) in the list
    float longitude = Float.parseFloat(earthquake[2]);    // get longitude too - note we have to parse the String of the number to a float
    latitude = map(latitude, 90.0, -90.0, 0, height);     // convert to screen coordinates, just like above
    longitude = map(longitude, -180.0, 180.0, 0, width);

    // draw the dot!
    fill(150, 75, 0, 150);
    ellipse(longitude, latitude, 5, 5);
  }
}
