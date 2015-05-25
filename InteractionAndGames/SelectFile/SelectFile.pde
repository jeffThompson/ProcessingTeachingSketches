
/*
SELECT FILE
Jeff Thompson | 2015 | www.jeffreythompson.org

While hard-coding filenames works ok for quick sketches
and prototypes, often you want to let the user select
a file interactively. The selectInput() command does
just that.

However, the way it works is a little confusing. Instead
of pausing your entire program while the user makes a
selection, it keeps going. This can cause errors when no
filename would cause an error, such as loading an image.

Here, we check to see if the input has been set yet in 
the draw() loop.

See also selectOutput() and selectFolder() for similar
functionality.

*/


// a string with the file's full path
String input;


void setup() {
  size(500,200);
  
  // the selectInput() command opens a prompt for the
  // user to select a file
  // the first argument is the text that appears at the top
  // of the window, the second is the name of the function
  // to run (ours is below the draw() loop)
  selectInput("Select a file...", "fileSelector");
}


void draw() {
  background(255);
  fill(0);
  noStroke();
  
  // test if the filename has been set yet
  // if not, display text letting us know
  if (input == null) {
    text("No file selected.", 20,height/2);
  }
  
  // if it has, display the file's path
  else {
    text(input, 20,height/2);
  }
  
}


// function to run when selectInput() is called
void fileSelector(File selection) {
  if (selection == null) {
    // window closed or user hit cancel button
  }
  else {
    input = selection.getAbsolutePath();
  }
}


