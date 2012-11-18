/*
NUMBERS and MATH
 Jeff Thompson
 November 2009
 
 www.jeffreythompson.org 
 */

void setup() {

  // We don't need to change the size or background because there is nothing to display there.

  /*
  VARIABLES and TYPES IN PROCESSING
   Values can be stored in a variety of formats; some are better than others for certain tasks and some simply can't do things others can
   
   Integer (int):
   Whole numbers (ie: no decimal): 1, 45, 1024, etc
   Can be +/- from -2,147,483,648 to 2,147,483,648
   Less precise, but also use less memory to store and process
   
   Floating point number (float):
   Decimal values: 3.14, 9.5, etc
   Can be +/- from -3.40282347E+38 to 3.40282347E+38
   (34028234700000000000000000000000000000)
   More precise than ints (3/2 in ints will round, whereas in float format the result is 1.5)
   Floats are meant to mimic "real-world" values like temperature
   
   Character (char):
   A single letter: a, C, z, Q
   Chars are denoted by single quotes
   Chars also have numerical values (ASCII code)
   http://www.asciitable.com
   
   String:
   Strings are a set of chars: This is an example of a string.
   Strings are denoted by double-quotes
   Strings can be combined with the +-sign:
   "This" + "is" + "a" + "string" + "of" + "strings"
   There are a whole set of special functions for strings, such as split, match, etc
   NOTE: two strings cannot be compared using the ==, instead we have to use the built-in .equals function: str1.equals(str2)
   
   Boolean:
   This is the simplest form of variable in terms of memory
   True or false
   Useful for setting certain parameters, etc
   */


  // DECLARING VARIABLES
  // <type> <name> = <initial value>;
  int i = 9;
  float f = 3.14;
  char c = 'R';
  String s = "happiness is coding";  // note the capital S on String
  boolean b = true;


  // CASTING VARIABLES
  // ints may be cast to floats and vice versa:

  float f = 3.14;
  int i = int(f);

  int j = 90;
  float g = float(i);

  // to get a number from a string, it's a little more complex:
  String strNum = "30";
  int i = Integer.parseInt(strNum);	// note the capital Integer here, which is important
  String strNum = "30.5";
  float f = Float.parseFloat(strNum);
  
  
  /*
  One more type...
  ARRAYS
  A list of values, can be any of the types above
  Arrays are a convenient way to store large numbers of data in a clear and concised format
  
  To declare:
  <type>[] <name> = new <type>[<num elements>];	<-- this creates an empty array of a certain size
  or:
  <type>[] <name> = { <1>, <2>, <3>, <4>... <n> };	<-- set information by hand at the start
  */
  
  // example:
  int[] intArray = new int[10];
  String[] someStrings = { "This", "is", "a", "string", "array" };
  
  // To change a value at a certain index:
  // <name>[<index>] = <value>;
  intArray[0] = 25;
  someStrings[3] = "great";
  
}
  

