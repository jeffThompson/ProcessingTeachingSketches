/*
OPENING AND SAVING FILES
 Jeff Thompson | 2012 | www.jeffreythompson.org
 
 A demonstration of Processing's built-in and overall very simple
 (but limited) open/save functions.  Note that more specific applications
 like only allowing certain types of files to be opened or adding a default
 extension for saving are not supported using this method.
 */

File f;
PImage img;

void setup() {
  size(300, 130);
  smooth();
  noStroke();
  textAlign(LEFT, CENTER); 
  frame.setResizable(true);    // allow the window to be resized as we load the image
}

void draw() {
  background(0);
  
  // if an image has been loaded, show it!
  if (img != null) {
    image(img, 0, 0);
    
    // a black background for the text
    fill(0, 200);
    rect(0,height-80, width, 80);
  }
  
  // basic explanatory text
  fill(255);
  text("o  =  open an image file (png, jpg, tiff)\n\ns  =  save the image file", 20, height-40);

}

// 'o' = open, 's' = save
void keyPressed() {

  // both input and output work basically the same:
  // the first argument will appear at the top of the dialog
  // the second is the name of the function we've created below
  // to handle the opening and saving of files

  if (key == 'o') {
    selectInput("Open...", "openFile");
  }
  else if (key == 's') {
    selectOutput("Save As...", "writeFile");
  }
}

// open an image file
void openFile(File f) {

  // if the file is successfully chosen...
  if (f != null) {

    // get the full path to the file and print
    String fullPath = f.getAbsolutePath();
    println("file: " + fullPath);

    // do a simple file extension check to see if it's a valid image file
    // this is by no means extensive or perfect, but should mostly work
    String[] extension = match(fullPath, "\\.(png|jpg|jpeg|tif|tiff)");
    if (extension != null) {
      img = loadImage(f.getAbsolutePath());      // load the image
      frame.setSize(img.width, img.height);      // set the window size to that of the image
    }
    // if the file appears not to be an image, let us know and do nothing
    else {
      println("you appear to be trying to load a non-image file!");
    }
  }

  // if the user cancels the open operation, we would normally do nothing...
  else {
    println("no file selected...");
  }
}

// save the current screen
void writeFile(File f) {

  // if we've successfully created a file path...
  if (f != null) {
    String fullPath = f.getAbsolutePath();
    println("saving: " + fullPath);

    // check if the file has an image extension
    String[] hasExt = match(fullPath, "\\.(png|jpg|jpeg|tif|tiff)");
    if (hasExt != null) {         // if it does, save normally
      save(fullPath);
    }
    else {                        // if it doesn't, add a default no-compression format
      save(fullPath + ".tiff");
    }
  }

  // if user cancels the process, we'd normally do nothing...
  else {
    println("save file canceled...");
  }
}

