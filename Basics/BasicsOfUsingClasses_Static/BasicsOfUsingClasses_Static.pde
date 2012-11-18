/*
BASICS OF USING CLASSES - STATIC
Jeff Thompson
March 2012

www.jeffreythompson.org
*/

// create an instance of a single object
// the class is called SingleObject, the instance called singleObject
// this caps/non-caps convention is typical, though sometimes a bit confusing...
SingleObject singleObject;

// here we create an array of lotsOfObjects (100 of them)
LotsOfObjects[] lotsOfObjects = new LotsOfObjects[100];


void setup() {

  size(800, 800);
  smooth();
  noStroke();
  background(255);

  // object name = new Class name(arguments)
  // here we create an object at x,y that is 200px wide
  singleObject = new SingleObject(width/2, height/2, 200);

  for (int i=0; i<lotsOfObjects.length; i++) {

    int tempSize = 30;                                    // size for the circles
    int tempX = int(random(tempSize, width-tempSize));    // random x location
    int tempY = int(random(tempSize, height-tempSize));   // random y location
    
    // also create a random color with transparency!
    color tempColor = color(random(0,255), random(0,255), random(0,255), random(0,255));

    // object name [location in array of these objects] = new Class name(arguments)
    lotsOfObjects[i] = new LotsOfObjects(tempX, tempY, tempSize, tempColor);
  }

  // NOW DISPLAY!

  // using the single object we created, display statically
  singleObject.display();

  // iterate the array of multiple objects, display in motion
  for (int i=0; i<lotsOfObjects.length; i++) {
    lotsOfObjects[i].display();
  }
}

class SingleObject {

  // these are the arguments expected when creating the object
  // they are also referenced later, so name in a descriptive way
  int x;
  int y;
  int ballSize;

  // this initializes the object (happens when it is created in the setup
  // the arguments here are temp values - adding the _ after just denotes that
  SingleObject(int x_, int y_, int ballSize_) {
    x = x_;
    y = y_;
    ballSize = ballSize_;
  }

  // here we define a function of the SingleObject class that displays
  // the circle - this could be anything
  void display() {
    fill(255, 0, 0, 100);
    ellipse(x, y, ballSize, ballSize);
  }
}

class LotsOfObjects {

  // location and size
  int x, y, ballSize;    // listing on the same line is a bit cleaner
  color ballColor;       // different value types are listed separately

  // initialize values for each
  LotsOfObjects(int x_, int y_, int ballSize_, color ballColor_) {
    x = x_;
    y = y_;
    ballSize = ballSize_;
    ballColor = ballColor_;
  }

  // function that displays the balls
  void display() {
    fill(ballColor);
    ellipse(x, y, ballSize, ballSize);
  }
}
