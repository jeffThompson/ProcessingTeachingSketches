/*
BASIC DATA VISUALIZATION
 Jeff Thompson
 Fall 2011
 
 An interactive program visualizing recent earthquake data, automatically downloaded from the USGS
 weekly data.
 
 BASIC STEPS:
 1. Download file
 2. Get number of lines in the file (this is the # of earthquakes)
 3. Read data points (lat, long, magnitude) into arrays, scaling values as we do so
 4. Re-format the location strings
 5. Visualize!
 
 LATITUDE/LONGITUDE DETAILS:
 Latitude: 90 (north pole) > 0 (equator) > -90 (south pole)  -- this is the Y direction
 Longitude: 180 east > 0 (Prime Meridian) > -180 west        -- this is the X direction
 
 COLUMNS ARE:
 Source, Eqid, Version, Datetime (as a full string), Latitude, Longitude, Magnitude (strength), Depth, NST, Region
 
 DATA SOURCE:
 http://earthquake.usgs.gov/earthquakes/catalogs
 In this case, we're automatically downloading the 2.5+ earthquakes from the last 7 days
 
 MAP IMAGE SOURCE:
 Note that the lat/long grid is square and the landforms are distorted - using a normal projection would
 mean fancy math to get the locations correct: this is a kludge
 Image via Wikipedia user 'strebe' (licenced under a CreativeCommons license - thanks!)
 http://en.wikipedia.org/wiki/File:Equirectangular_projection_SW.jpg
 
 www.jeffreythompson.org
 */

// DATA READING VARIABLES
String filename = "earthquakes.csv";    // what to save the downloaded file as
BufferedReader reader;                  // BufferedReader to read in the file when downloaded
String tempLine;                        // string to store lines as they are read
int numLines = 0;                       // count number of lines in the file

// VISUALIZATION VARIABLES
int rectSize = 5;
float[] latitude;                       // latitude and longitude - set length later when we have number of lines
float[] longitude;
float[] magnitude;                      // ditto for strength of the quake
String[] location;                      // store text labels
PFont titleFont;                        // larger text for label
PFont detailFont;                       // smaller for descriptions
boolean alreadyDisplaying = false;
PImage worldMap;


void setup() {
  
  // DOWNLOAD DATA
  // see downloadFile.pde for details
  downloadFile(filename);

  // LOAD IMAGE FILE
  // load first to get image size > sketch dimensions
  worldMap = loadImage("EquirectangularProjection-1200pxDimmed.png");

  // BASIC SETUP
  size(worldMap.width, worldMap.height);
  background(255);
  noStroke();
  smooth();
  rectMode(CENTER);

  // FONT SETUP
  titleFont = createFont("HelveticaNeue-60.vlw", 60);
  detailFont = createFont("HelveticaNeue-12.vlw", 12);

  // FIRST, GET NUMBER OF LINES IN FILE
  // needed to set the length of arrays storing the data, but also useful when creating things 
  // like bar or line graphs that need to be evenly spaced across the screen, based on the # of data pts
  reader = createReader(filename);                         // load the file specified earlier
  println("Getting number of lines (may take a bit)...");
  try {
    while ( (tempLine = reader.readLine ()) != null) {     // run through until the end of the file
      numLines++;                                          // counting lines
    }
  }

  // CATCH ANY ERRORS READING THE FILE
  catch (IOException e) {
    println("ERROR READING FILE!");
  }

  // WHEN DONE, PRINT NUMBER OF LINES
  numLines -= 1;                              // subtract 1 since the first line isn't data
  println("Number of lines: " + numLines);

  // RE-0PEN THE FILE
  // since we've run through the file already, we re-open it to start again
  reader = createReader(filename);

  // INITIALIZE ARRAYS TO STORE DATA
  // store in a simpler format that we can read more quickly in draw()
  println("\nReading data into arrays (also may take a while)...");
  latitude = new float[numLines];
  longitude = new float[numLines];
  magnitude = new float[numLines];
  location = new String[numLines];

  // READ DATA INTO ARRAYS
  try {

    // read and skip the first line
    tempLine = reader.readLine();

    // read the rest of the data!
    for (int i=0; i<numLines; i++) {

      tempLine = reader.readLine();                     // read data in
      String[] splitValues = split(tempLine, ',');      // split at commas, save into temp array

      // scale values, then store - numbers are also converted from strings in this step
      latitude[i] = map(float(splitValues[6]), 90, -90, 0, height);      // scale to size of screen
      longitude[i] = map(float(splitValues[7]), -180, 180, 0, width);
      magnitude[i] = map(float(splitValues[8]), 0, 9, 255, 0);           // scale to RGB range

      // strip quotation marks and convert all words to uppercase (both look nicer) - remains a string
      location[i] = splitValues[11].toUpperCase();    // use Java's built-in uppercase conversion
      location[i] = location[i].substring(1, location[i].length() -1);
    }
  }
  catch (IOException e) {
    // no need to put something here, since we've already read the file once!
  }

  // LET US KNOW WE'RE DONE WITH THE GRUNT WORK
  println("Done! Time to see the results!");
}


void draw() {

  // REDRAW EACH FRAME USING MAP IMAGE
  image(worldMap, 0, 0);

  // white space at bottom for info
  fill(255);
  rectMode(CORNER);                     // could remain CENTER, but makes it easier to understand
  rect(0, height, width, -85);
  stroke(255, 0, 0);                    // red line across the top
  strokeWeight(3);
  line(0, height-85, width, height-85);
  rectMode(CENTER);                     // reset the rectMode and strokeWeight for upcoming shapes
  strokeWeight(1);

  // READ DATA BACK FROM ARRAYS
  for (int i=0; i<numLines; i++) {

    // CHECK IF WE'RE ON A DATA POINT (and aren't already displaying data) - IF SO, DISPLAY THE LOCATION
    if (mouseX >= longitude[i]-rectSize/2 && mouseX <= longitude[i]+rectSize/2 &&
      mouseY >= latitude[i]-rectSize/2 && mouseY <= latitude[i]+rectSize/2 && 
      alreadyDisplaying == false) {

      // if so, display info...

      // MAGNITUDE
      textAlign(LEFT);
      textFont(titleFont);
      fill(255, 0, 0);
      text(nf(magnitude[i]/25.5, 0, 1), 20, height-20);  // nf trims the float value to 1 decimal place
      textFont(detailFont);
      fill(0);
      text("/ 9 MAGNITUDE", 120, height-20);

      // LOCATION
      textAlign(RIGHT);
      text(location[i], width-20, height-40);

      // while it may seems redundant to change these values back to lat/long range, it is
      // quicker to do this for one set performance the scaling for all the values each frame
      float tempLong = map(longitude[i], 0, width, -180, 180);
      float tempLat = map(latitude[i], 0, height, 90, -90);

      // test hemispheres and print coordinates (with + signs as well)
      if (tempLong <= 0 && tempLat <= 0) {                                       // SW
        text(tempLat + "S, " + tempLong + "W", width-20, height-20);
      }
      else if (tempLong > 0 && tempLat <= 0) {                                   // SE
        text(tempLat + "S, " + "+" + tempLong + "E", width-20, height-20);
      }
      else if (tempLong > 0 && tempLat > 0) {                                    // NE
        text("+" + tempLat + "N, " + "+" + tempLong + "E", width-20, height-20);
      }
      else if (tempLong <= 0 && tempLat > 0) {                                   // NW
        text("+" + tempLat + "N, " + tempLong + "W", width-20, height-20);
      }

      // TO PREVENT DISPLAYING MULTIPLE DATA POINTS FOR NEARBY EARTHQUAKES
      // set the 'alreadyDiplaying' flag
      alreadyDisplaying = true;

      // set fill color for this rectangle to red and draw
      fill(255, 0, 0, 100);
      noStroke(); 
      // scale exponentially: e^x = 2.7... the function for an exponential curve
      // 0 > 8103 is a hard-coded range for 0 > 9 Richter
      // 30 > 200 is the desired output range
      float tempMag = map(pow(2.718281828,(magnitude[i]/25.5)), 0,8103, 30,200);
      ellipse(longitude[i], latitude[i], tempMag,tempMag);
    }
    
    // otherwise, draw rectangles/lines
    else {

      // draw rectangles with fill color showing magnitude
      fill(magnitude[i],0,0, 200);
      stroke(255);
      rect(longitude[i], latitude[i], rectSize, rectSize);
    }
  }

  // AFTER ALL DATA IS READ, RESET THE 'alreadyDisplaying' FLAG
  alreadyDisplaying = false;
}

