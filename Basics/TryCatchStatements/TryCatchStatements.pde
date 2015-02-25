/*
TRY/CATCH STATEMENTS
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Java's "try/catch" statements let you try running code and handle
 any errors in a particular way. Processing hides some of this to
 make coding easier.
 
 However, sometimes you want to watch for errors, or you're using
 standard Java code that requires a try/catch statement to work

 */


void setup() {
  
  // a basic example: try to get an item not in the array
  int[] example = new int[10];
  try {
    int i = example[11];          // item #11 is not in the array (only 10 items!)
  }
  // catch statements capture specific errors and let you handle them as you wish
  // here we use the general exception, which is returned as a variable "e"
  // so we can see what's happening
  catch (ArrayIndexOutOfBoundsException aiobe) {
    println("That index is too big for the array!");
    // println(aiobe);
  }
  
  // another example: attempting to convert the string "one" into an int
  try {
    int i = Integer.parseInt("one");
  }
  catch (NumberFormatException nfe) {
    println("Processing doesn't understand numbers written like that!");
    // println(nfe);
  }

  // a final example: using BufferedReader requires a try/catch
  try {
    BufferedReader reader = createReader("NotARealFile.txt");
  }
  // a generic exception will catch any and all errors, but is
  // generally frowned upon since it doesn't handle the specific error
  catch(Exception e) {
    println(e);
  }
}


