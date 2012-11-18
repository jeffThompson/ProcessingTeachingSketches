/*
BASICS OF USING CLASSES - ANIMATED
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

  // object name = new Class name(arguments)
  // here we create an object at x,y that is 200px wide
  singleObject = new SingleObject(width/2, height/2, 200);

  for (int i=0; i<lotsOfObjects.length; i++) {

    int tempSize = 30;                                    // size for the circles
    int tempX = int(random(tempSize, width-tempSize));    // random x location
    int tempY = int(random(tempSize, height-tempSize));   // random y location
    float xDir = random(-5, 5);                           // direction of travel...
    float yDir = random(-5, 5);                           // ... notice we can mix int/float/etc

    // object name [location in array of these objects] = new Class name(arguments)
    lotsOfObjects[i] = new LotsOfObjects(tempX, tempY, tempSize, xDir, yDir);
  }
}

void draw() {

  background(255);

  // using the single object we created, display statically
  singleObject.display();

  // iterate the array of multiple objects, display in motion
  for (int i=0; i<lotsOfObjects.length; i++) {

    // while we could do this with another function in the class (and probably better to do so),
    // this shows that you can access the values from inside the class
    // the .<variable> is the name of that variable inside the class (ie: the x or y position, etc)
    if (lotsOfObjects[i].x-lotsOfObjects[i].ballSize/2 <= 0 || lotsOfObjects[i].x+lotsOfObjects[i].ballSize/2 >= width) {
      lotsOfObjects[i].xDir *= -1;    // reverse direction
    }
    if (lotsOfObjects[i].y-lotsOfObjects[i].ballSize/2 <= 0 || lotsOfObjects[i].y+lotsOfObjects[i].ballSize/2 >= height) {
      lotsOfObjects[i].yDir *= -1;
    }

    // move and display
    lotsOfObjects[i].moveAround();
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
  float xDir, yDir;      // and saves space when you have a lot of variablesU

  // initialize values for each
  LotsOfObjects(int x_, int y_, int ballSize_, float xDir_, float yDir_) {
    x = x_;
    y = y_;
    ballSize = ballSize_;
    xDir = xDir_;
    yDir = yDir_;
  }

  // a function to update the position based on the x,y direction
  void moveAround() {
    x += xDir;
    y += yDir;
  }

  // function that displays the balls
  void display() {
    fill(0, 100);
    ellipse(x, y, ballSize, ballSize);
  }
}
