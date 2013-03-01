import android.content.Context;              // required imports for GPS
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;

/*
GPS LOCATION
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Get location data via GPS! Here we read the location once
 when the app starts; a "smarter" version might update the
 GPS when the accelerometer is moved, or every N-seconds, etc.
 
 Based on an example via:
 http://stackoverflow.com/a/2227299/1167783 
 */

String location;              // string to format location
double longitude, latitude;   // Android returns location as double, not float
PFont font;

void setup() {
  
  // basic setup and font loading
  orientation(LANDSCAPE);            // set to horizontal mode
  smooth();
  font = createFont("Arial", 72);    // createFont preferred over loadFont for Android
  textFont(font);
  textAlign(CENTER, CENTER);

  // if GPS can be accessed, store in 'location' string
  try {
    LocationManager lm = (LocationManager)getSystemService(Context.LOCATION_SERVICE);
    Location gpsLocation = lm.getLastKnownLocation(LocationManager.GPS_PROVIDER);
    longitude = gpsLocation.getLongitude();
    latitude = gpsLocation.getLatitude();
    location = latitude + " / " + longitude;
  }
  // if we couldn't connect, set 'location' to an error message
  catch (NullPointerException npe) {
    location = "[ gps not available ]";
  }
}

void draw() {
  
  // display the results!
  background(150, 75, 0);
  fill(0);
  text(location, width/2, height/2);
}

