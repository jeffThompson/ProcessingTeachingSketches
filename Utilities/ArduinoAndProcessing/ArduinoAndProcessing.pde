import processing.serial.*;    // load necessary libraries for serial
import cc.arduino.*;          // ... and Arduino communication

/*
ARDUINO and PROCESSING
Jeff Thompson
April 2011

Based on the "arduino_input.pde" example file.

You MUST load the "SimpleFirmata" sketch onto the Arduino for this sketch
to run; it is found in the Arduino IDE under Examples, Firmata, SimpleFirmata...

NOTE:
Putting anything into digital pins 0 and 1 may cause errors in communication,
since they are used as RX/TX (serial communication) - FYI.

www.jeffreythompson.org
*/

// create an Arduino object
Arduino arduino;

// digital input checkbox variables
int boxWidth;          // set later in setup using width of screen
int boxHeight;         // ditto

// analog input slider variables
int sliderWidth;       // set later in setup
int sliderHeight;      // ditto


void setup() {
  
  size(650,150);
  
  // start Arduino connection at 57600 baud rate
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  
  // set digital pin 0 to input
  arduino.pinMode(0, Arduino.INPUT);    // which pin, set to input
  
  // OR set all the digital pins using a for loop
  // note: analog pins do not require this step and can be read directly in draw
  for (int i=0; i<=13; i++) {
    arduino.pinMode(i, Arduino.INPUT);
  }
  
  // digital input box variables set using width and height
  boxWidth = width/13;
  boxHeight = height/3;
  
  // analog dial variables
  sliderWidth = boxWidth;      // nice and even with digital input
  sliderHeight = height/3;
  
  

}

void draw() {
  
  // redraw background
  noStroke();
  fill(0);
  rect(0,0, width,height);
  
  
  // read all the digital pins using a for loop
  for (int i=0; i<=13; i++) {
    
    // draw checkboxes, one for each digital pin
    stroke(0);
    fill(255);
    rect(i*boxWidth,0, boxWidth,boxHeight);    // draw across the screen
    
    // read digital pins
    if (arduino.digitalRead(i) == Arduino.HIGH) {    // if pin "i" is high
      
      // draw "X"
      line(i*boxWidth,0, i*boxWidth+boxWidth,boxHeight);    // upper R to lower L
      line(i*boxWidth,boxHeight, i*boxWidth+boxWidth,0);    // lower R to upper L
    } 
  }
  
  // read all analog pins using a for loop
  for (int i=0; i<=5; i++) {
    
    // draw slider frames
    fill(255);
    rect(i*sliderWidth,height-sliderHeight, sliderWidth,sliderHeight);    // same as checkboxes with height changed
    
    // store temp value of analog pin (cleans up our code, but is not necessary)
    // in the same step, we scale from 0-1023 to 0-sliderWidth
    int tempVal = int(map(arduino.analogRead(i), 0,1023, 0,sliderWidth));
    
    // draw red slider bars
    fill(255,0,0);
    rect(i*sliderWidth,height, sliderWidth,-tempVal);  // draw up from the bottom
  }  
  

}  
