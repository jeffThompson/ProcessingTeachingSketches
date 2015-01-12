/*
RUN CODE ON APPLICATION EXIT
Jeff Thompson | 2012 | www.jeffreythompson.org

Harder than it looks...
*/

void setup() {
  size(500, 500);
  prepareExitHandler();    // prepare our exit handler
}

void draw() {
  // do something while we wait
  background(0);
  stroke(255);
  line(0, 0, width, height);
  line(width, 0, 0, height);
  
  // try the various exit methods (command-Q, escape key, x-button on app bar)
}

// a rather ugly solution, but works great
// via: https://forum.processing.org/topic/run-code-on-exit
void prepareExitHandler () {
  Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
    public void run() {
      try {
        println("stopping...");
        stop();
      } 
      catch (Exception ex) {
        ex.printStackTrace();     // not much else we can do if there's an error at this point...
      }
    }
  }
  ));
}
