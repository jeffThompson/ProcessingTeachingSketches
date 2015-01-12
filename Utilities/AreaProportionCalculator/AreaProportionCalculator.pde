/*
* AREA PROPORTION CALCULATOR
* Jeff Thompson
*
* Given an initial size and a target area, what are the
* dimensions of the target rectangle?
*
* Long side = sqrt(Target Area / (Initial Long Side/Initial Short Side) )
*
* Needed:
* 1. Original dimensions (with this, we get the ratio of the sides)
* 2. Target area
*
* www.jeffreythompson.org
*/

// change variables below
float longSide = 8;          // initial dimensions
float shortSide = 10;
float targetArea = 8784330;   // output area
String units = "inches";

void setup() {
  
  // do "the math"
  float ratio = longSide/shortSide;
  float resultingLongSide = sqrt(targetArea/ratio);
  float resultingShortSide = targetArea/resultingLongSide;
  
  // change the "3" below to adjust the number of decimal places given
  println("Given an initial rectangle of:     " + nfc(longSide,3) + " x " + nfc(shortSide,3) + " " + units);
  println("And a target area of:              " + nfc(targetArea,3) + " square " + units);
  println();
  println("The resulting dimensions:          " + nfc(resultingLongSide, 3) + " x " + nfc(resultingShortSide, 3) + " " + units);
  
  // quit, since there's nothing to display
  exit();
}

