
import android.content.Context;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;

/*
GPS LOCATION
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Get location data via GPS.
 
 Based on an example via:
 http://stackoverflow.com/a/2227299/1167783
 
 CHALLENGE:
 1. 
 */

String location;
double longitude, latitude;
PFont font;

void setup() {
  orientation(LANDSCAPE);
  background(120, 75, 0);
  smooth();

  font = loadFont("Arial-72.vlw");
  textFont(font, 72);
  textAlign(CENTER, CENTER);

  try {
    LocationManager lm = (LocationManager)getSystemService(Context.LOCATION_SERVICE);
    Location gpsLocation = lm.getLastKnownLocation(LocationManager.GPS_PROVIDER);
    longitude = gpsLocation.getLongitude();
    latitude = gpsLocation.getLatitude();
    location = latitude + " / " + longitude;
  }
  catch (NullPointerException npe) {
    location = "[ gps not available ]";
  }
}

void draw() {
  background(150);
  fill(255);
  text(location, width/2, height/2);
}

