/*
CHANGE CASE OF STRING
Jeff Thompson
Fall 2011

Converts a single letter, stored as a string, to the opposite case.

www.jeffreythompson.org
*/

String letter = "p";

void setup() {

  // STRING LETTER
  println("Original letter: " + letter);
  
  // FIND ASCII VALUE
  // must convert to char to find ASCII value
  int asciiVal = int(letter.charAt(0));
  println("ASCII value: " + asciiVal);
  
  // CHECK FOR CASE and CONVERT
  // if uppercase
  if (asciiVal >= 65 && asciiVal <= 90) {
    letter = letter.toLowerCase();
    println("Converted to lowercase: " + letter);
  }
  // if lowercase
  else if (asciiVal >= 97 && asciiVal <= 122) {
    letter = letter.toUpperCase();
    println("\nConverted to uppercase: " + letter);
  }
  
  exit(); 
}
