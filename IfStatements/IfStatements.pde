/*
IF STATEMENTS
Jeff Thompson
March 2012

www.jeffreythompson.org
*/

void setup() {
  
  int a = 90;
  int b = 1000;
  int c = 3;
  
  if (a < b) {
    println("a is less than b");
  }
  else {
    println("b is less than a");
  }
  
  if (a == b) {
    println("a equals b");
  }
  else if (a == c) {
    println("a equals c");
  }
  else if (b == c) {
    println("b equals c");
  }
  else {
    println("none of the values are equal");
  }
  
  String str1 = "This is a string";
  String str2 = "This is a another string";
  
  if (str1.equals(str2)) {
    println("str1 is the same as str2");
  }
  else {
    println("str1 is NOT the same as str2");
  }
}
