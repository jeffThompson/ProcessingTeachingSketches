/*
READ KML FILES
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 KLM files, a growing standard used by Google Earth, are common
 for map data. They are stored in an XML format, a nested data
 structure similar to HTML. This format isn't as easy to
 parse as CSV, but provides more human-readable data.

 In this example, we load the river forecast for the US - the dots
 are readings in rivers, the size determined by the height of
 the water. 
 
 LOCATION (furthest points)         ACTUAL        USED HERE
 Eastern coast of Maine             -66.4413      -66.5
 Western coast of Washington state  -125.0330     -125.5
 Northern tip of Minnesota          50.2101       50
 Southern tip of Florida            24.3000       24
 
 Data source (a truncated version of an otherwise very large file):
 http://water.weather.gov/ahps/download.php
 
 Map image via:
 http://commons.wikimedia.org/wiki/File:USA_location_map.svg
 
 */

String filename = "RiverForecast.kml";    // KLM file to load
River[] rivers = new River[0];            // an array of custom River objects*
String[] location, state, value;          // temporary arrays for parsing data from the file
PImage mapImage;                          // image to put the data on

// *custom objects are created using the River class at the bottom; it allows
//  multiple data points to be stored in a single object and retrieved more easily.

void setup() {
  
  // load the map and set the screen to its size
  mapImage = loadImage("EquirectangularUSA.png");
  size(mapImage.width, mapImage.height);
  image(mapImage, 0,0);                                  // display the map

  // load the data, create River objects for each reading
  String[] rawFile = loadStrings(filename);              // load the data into a list of strings
  float maxRiverReading = 0;                             // keep track of maximum river depth (scale dots accordingly)
  for (int i=0; i<rawFile.length; i++) {                 // go through file line-by-line
    String reading = rawFile[i];
    if (reading.contains("<![CDATA[")) {                 // start of data listing
      location = match(rawFile[i+3], "</b>(.*?)<br>");   // extract location, state, and value for each point
      state = match(rawFile[i+4], "</b>(.*?)<br>");
      value = match(rawFile[i+5], "</b>(.*?)\\sft");
    }
    else if (reading.contains("<Point>")) {               // get coordinates from the line after "<Point>"
      String[] gps = match(rawFile[i+1], "<coordinates>(.*?)</coordinates>");
      
      // run in a try statement - if there's an error, it will just skip the listing and continue
      try {
        rivers = (River[])append(rivers, new River(location[1], state[1], value[1], gps[1]));  // add to array of rivers
        
        // if the most recent river's depth is greater than any others, store that value
        if (rivers[rivers.length-1].value > maxRiverReading) {
          maxRiverReading = rivers[rivers.length-1].value;
        }
      }
      catch (NullPointerException npe) {
        // error parsing data, skip!
      }
    }
  }
  
  // draw dots at each reading!
  noStroke();
  fill(150,75,0, 80);
  for (River river : rivers) {                                          // iterate all rivers...
    float longitude = map(river.longitude, -125.5, -66.5, 0, width);    // convert to screen coordinates
    float latitude = map(river.latitude, 50,24, 0, height);             // these are "tuned" to the map
    float value = map(river.value, 0,maxRiverReading, 5,60);            // convert depth to a usable value
    ellipse(longitude, latitude, value, value);                         // draw the dot!
  }
}

// special River object to store data about each river - easier to store and add to!
class River {
  
  // data for each river
  String location, state;
  float value;
  float longitude, latitude;

  River(String _loc, String _state, String _value, String _gps) {
    location = _loc;
    state = _state;
    value = Float.parseFloat(_value);
    String[] gps = split(_gps, ", ");
    longitude = Float.parseFloat(gps[0]);
    latitude = Float.parseFloat(gps[1]);
  }
}
