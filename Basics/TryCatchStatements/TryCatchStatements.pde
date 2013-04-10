/*
TRY/CATCH STATEMENTS
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 One of the things that Processing does to tidy up your coding experience
 is saving you from Java's try/catch statements. Sometimes, however, you
 want to ignore errors (when parsing data, for example) or you are using
 a standard Java process and need to encapsulate in a try/catch.
 */

void setup() {

  // try to do something!
  try {
    int i = Integer.parseInt("one");
  }
  // catch statements capture specific errors and let you handle them as you wish
  catch (NumberFormatException nfe) {
    println("You can't make a number that string!");
  }
  
  // try something else...
  try {
    int[] example = new int[10];
    int i = example[11];    // item #11 is not in the array (only 10 items)
  }
  catch (ArrayIndexOutOfBoundsException aiobe) {
    println("That index is too big for the array!");
  }
  
  try {
    BufferedReader reader = createReader("NotARealFile.txt");
  }
  catch(Exception e) {
    // a generic exception will catch any and all errors, but is generally frowned upon
    println(e);
  }
}

