
/*
RUN APP IN COMMAND LINE WITH ARGUMENTS (MAC)
Jeff Thompson | 2013 | www.jeffreythompson.org

Sometimes, running a sketch exported as an application from
the command line can be helpful, like if you want to integrate
it into a much larger process via a shell script.

In addition, specifying parameters for the application is
very helpful - while creating a text file to be read is a viable
option, for simpler parameters we can simply pass them as
arguments via the 'args' array.

TO RUN:
1. Open Terminal
2. Move to application's location using the 'cd' command (we're looking
   for the .app)
3. Run the application using the following command:
      ./ApplicationName.app/Contents/MacOS/JavaApplicationStub
4. Your program should launch!
5. Now try again with two arguments for width and height
    ./ApplicationName.app/Contents/MacOS/JavaApplicationStub 200 200

*/

void setup() {
  
  // if there are 2 arguments, set them as width/height of sketch
  // note: we could format this any way we wanted, such as a single
  // argument for both separated by a space, or a comma, etc
  if (args.length == 2) {
    size(Integer.parseInt(args[0]), Integer.parseInt(args[1]));
  }
  else {
    size(400,400);          // default size in case no args are passed
  }
}

// display a message - any key exits
void draw() {
  background(0);
  fill(255);
  text("Arguments: window width/height", 30, height/2);
}

void keyPressed() {
  exit();
}

