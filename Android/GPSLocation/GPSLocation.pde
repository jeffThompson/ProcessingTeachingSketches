import android.content.Context;              // required imports for GPS
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.location.Criteria;

import android.location.Geocoder;            // optional imports to get address from GPS coords
import android.location.Address;
import java.util.Locale;                     // note these is a Java import, not Android
import java.util.List;

/*
GPS LOCATION
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Get location data via GPS! Here we read the location when the
 user click-and-drags on the screen; a "smarter" version might update
 the GPS when the accelerometer is moved, or every N-seconds, etc.
 
 We also get the address from the GPS coordinates - note this returns
 an array of choices, which could be picked by the user; instead we
 just grab the first one for simplicity.
 
 Be sure to add the following to Android > Sketch Permissions...
 + ACCESS_FINE_LOCATION
 + INTERNET (for non-3G tablets, might not be required for phones?)
 
 Based (in part) on an example via:
 http://stackoverflow.com/a/2227299/1167783 
 
 CHALLENGE:
 1. Look through the Android API to parse just the postal code or some aspect of the address
 2. Can you map the latitude/longitude to a point on the screen?
 3. Can you reverse this process, moving a point on the screen, get it's mapped lat/long and
 look up the address at that point?
 4. Getting altitude from GPS is notoriously inaccurate - look at this example pulling
 data from the internet: 
 http://stackoverflow.com/questions/1995998/android-get-altitude-by-longitude-and-latitude
 */

double longitude, latitude;   // Android returns location as double, not float
String location;              // string to format location
String address;               // string of street address
PFont font;

void setup() {

  // basic setup and font loading
  orientation(LANDSCAPE);                // set to horizontal mode
  font = createFont("SansSerif", 72);    // createFont preferred over loadFont for Android
  textFont(font);
  textAlign(CENTER, CENTER);
  smooth();

  // starting message prompting us to get the location
  location = "[ click-and-drag to get gps location ]";
}

void draw() {
  background(150, 75, 0);
  fill(255);
  text(location, width/2, height/2);
}

// when the mouse is dragged (previous x/y different than the current position),
// update the current location
void mouseDragged() {
  getGPSLocation();
}


// function to load the location
void getGPSLocation() {
  // if GPS can be accessed, store in 'location' string
  try {
    // get GPS coords - a lot of steps, but basically we load the best provider (either 3G or
    // GPS) and get the current location!
    LocationManager lm = (LocationManager)getSystemService(Context.LOCATION_SERVICE);
    Criteria criteria = new Criteria();                          // default provider criteria
    String provider = lm.getBestProvider(criteria, false);       // can get a list of providers, or the best
    Location gpsLocation = lm.getLastKnownLocation(provider);    // location (last known if new isn't available)

    // parse coordinates from Location
    longitude = gpsLocation.getLongitude();
    latitude = gpsLocation.getLatitude();

    // parse coords into address; this involves several steps through the Android
    // API - likely easier to wrap this up into a function... 
    Geocoder geocoder = new Geocoder(this, Locale.getDefault());
    List<Address> addresses = geocoder.getFromLocation(latitude, longitude, 1);  // 1 = # of results to get
    if (!addresses.isEmpty()) {                                                  // if there is an address...
      Address addr = addresses.get(0);                                           // get from list...

      // address = addr.toString();        // could do this, but messy and long

      // go through all entries (can include street address, city, postal code, or even points of interest)
      for (int i=0; i<addr.getMaxAddressLineIndex(); i++) {
        address += addr.getAddressLine(i) + "\n";                                // add to address with newline character
      }
    }
    else {
      address = "[ no address found for this location, sorry! ]";                // let us know if we couldn't find an address
    }

    // done! format into a nice printable string
    location = latitude + " / " + longitude + "\n\n" + address;
  }

  // if we couldn't connect, set 'location' to an error message
  catch (NullPointerException npe) {
    location = "[ gps not available ]";
  }
  // problem loading address
  catch (IOException ioe) {
    // do nothing...
  }
}

