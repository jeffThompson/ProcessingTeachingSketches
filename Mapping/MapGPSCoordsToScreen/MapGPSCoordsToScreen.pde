/*
MAP GPS COORDINATES TO THE SCREEN
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Uses the map() function to convert latitude/longitude to location on the
 screen. We also use a for loop to create accurate grid lines every 10 degrees.
 
 POSITION    DIRECTION              RANGE       MORE INFO
 Latitude    north(+) / south(-)    90,-90      http://en.wikipedia.org/wiki/Latitude
 Longitude   west(+) / east(-)      180,-180    http://en.wikipedia.org/wiki/Longitude
 
 CHALLENGE:
 1. Find some other coordinates to try - Wikipedia lists coordinates for all
    city pages!
 2. If you've used Processing before, try adding a label to the dot when the mouse
    hovers over it. 
 */

// GPS coordinates for Lincoln, Nebraska, USA
float lat = 40.4835;
float lon = -96.4031;

void setup() {

  // basic setup
  size(800, 400);
  background(0);
  smooth();

  // optionally, draw lat/lon lines across image
  float lonDist = width/36;      // every 10º - divide by 36 not 360
  float latDist = height/18;     // every 10º from 180
  stroke(100);
  for (int i=0; i<width; i+=lonDist) {
    line(i,0, i,height);
  }
  for (int i=0; i<height; i+=latDist) {
    line(0,i, width,i);
  }

  // convert from lat/lon to screen coordinates
  lat = map(lat, 90.0, -90.0, 0, height);
  lon = map(lon, -180.0, 180.0, 0, width);
  fill(255, 0, 0, 150);
  noStroke();
  ellipse(lon, lat, 30, 30);
}
