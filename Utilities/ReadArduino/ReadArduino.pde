import processing.serial.*;

/*
READ FROM ARDUINO
 Jeff Thompson
 March 2011
 
 Reads serial data sent from the Arduino.  Requires the Processing serial library (load
 using Sketch, Import Library...).
 
 In this case, we're looking for a list of 8 values; the first
 6 are from digital switches and will be either 0/1, the second
 two will be analog values from potentiometers and will be
 between 0-1025.
 */

// create and name the serial connection (we're calling this 
// one "myPort", as in the serial library tutorials
Serial myPort;

// how many pins to be read in
int numValues = 8;
int currentValues [] = new int[numValues];  // store those values in an array


void setup() {

  // declare size and anything else in the setup needed here
  size(500,500);

  // list all available serial ports
  // you will want to run just this first, to see what
  // port to use
  println(Serial.list());

  // choose which serial port to connect to
  // this can be predefined, if you know what port your
  // Arduino will connect to
  myPort = new Serial(this, Serial.list()[0], 9600);  // last value is baud rate
}


void draw() {

  // clear screen for new info
  background(150);  

  // read from serial connection
  while (myPort.available() > 0) {  // so long as there is something connected, bring in values

    // use a for loop to get all the values
    for (int i=0; i<numValues; i++) {
      currentValues[i] = myPort.read();     // read info from the port
    }

    /**************************************************************************/
    // do something interesting with the values you've brought in
    // example: here we draw bars for each incoming value, scaled to the input

    int spacer = 3;  // how much space between the bars

    // spit out each value using a for loop
    for(int i=0; i < numValues; i++) {

      // set rectangle size to screen and scale to screen
      int rectWidth = width/(numValues+2);  // # items + 2 for a border
      int rectHeight = int(map(currentValues[i], 0, 1025, 0, height-rectWidth*2));    // scale current value

      // draw a red rectangle if the pin goes high (for digital inputs), draw below the base
      fill(255,0,0);
      noStroke();
      if (rectHeight >= 0) {
        rect(i*rectWidth+rectWidth, height-rectWidth+spacer, rectWidth-spacer, 5);  // draw to fill area
      }

      // draw a black rectangle, with height scaled to the sensor value
      fill(0);
      stroke(0);
      rect(i*rectWidth+rectWidth, height-rectWidth, rectWidth-spacer, -rectHeight);  // neg height to draw up from bottom
    }
  }
}

