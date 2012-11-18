/*
 ADD COMMAS TO NUMBERS AS STRINGS
 Jeff Thompson
 
 Adds commas to string representations of numbers (like 
 nfc but for strings from BigInts, etc).
 
 www.jeffreythompson.org
 */

void setup() {

  String s1 = addCommas("123");
  String s2 = addCommas("1234");
  String s3 = addCommas("1234567890");

  println(s1);
  println(s2);
  println(s3);

  exit();
}

String addCommas(String s) {

  // if the number is large enough to warrant commas
  if (s.length() > 3) {
    String result = "";                     // store the result
    char[] c = s.toCharArray();             // convert the string to a char array
    c = reverse(c);                         // reverse (due to laziness but easier to understand)
    for (int i=c.length-1; i>=0; i-=1) {    // walk backwards through array
      if (i%3 == 0 && i != 0) {
        result += c[i] + ",";               // insert commas at specified location
      }
      else {
        result += c[i];                      // non-comma spots, simply add to string
      }
    }
    return result;
  }

  // if not large enough, just spit back out
  else {
    return s;
  }
}

