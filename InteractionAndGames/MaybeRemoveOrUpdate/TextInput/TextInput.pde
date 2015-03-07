
boolean newKey = true;

String baseURL = "http://www.weather.com/";
int[] inputZIP = new int[5];
String fullURL;


int numCount = inputZIP.length;

PFont font;
String tempZIP;


void setup() {

  size(500,500);
  smooth();

  font = loadFont("NewsGothicMT-48.vlw");
  textFont(font, 48);
  textAlign(CENTER, CENTER);
}


void draw() {

  background(255);

  if (keyPressed && newKey) {   // if key is pressed
    if (key >= '0' && key <= '9' && numCount > 0) {                            // if 0-9 only

      if (numCount > 0) {

        int tempKey = key - '0';

        inputZIP[inputZIP.length-numCount] = tempKey;    // reverse order!
        numCount--;                                      // increase numCount by one (up to 5)

        print("Current input: ");
        for (int i=0; i<inputZIP.length; i++) {
          print(inputZIP[i]);
        }
        print("\n");

        newKey = false;                                  // set to false until key is released
      }
    }
  }
  if (keyPressed) {
    if (key == 'p') {

      fullURL = baseURL;
      for (int i=0; i<inputZIP.length; i++) {
        fullURL += inputZIP[i];
      }
      println(fullURL);
      for (int i=0; i<inputZIP.length; i++) {
        inputZIP[i] = 0;                         // set all to 0
      }
      numCount = inputZIP.length;                // reset

      newKey = false;
    }
  }
  if (keyPressed) {
    if (key == 'o') {                    // delete clears
      numCount = inputZIP.length;                // reset
      for (int i=0; i<inputZIP.length; i++) {
        inputZIP[i] = 0;                         // set all to 0
      }
    }
  }

  fill(0);
  tempZIP = "";
  for (int i=0; i<inputZIP.length; i++) {
    tempZIP += inputZIP[i];
  }
  text(tempZIP, width/2, height/2);
}


// PREVENT RETRIGGERING A SINGLE KEY OVER AND OVER
void keyReleased() {
  if (key >= '0' && key <= '9') {
    newKey = true;
  }
}

