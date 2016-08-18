
/*
STRING TO COLOR
 Jeff Thompson | 2016 | www.jeffreythompson.org
 
 Converts an arbitrary-length string into a unique
 color. Useful for visualization or other situations
 where color needs a maximum range from a variety
 of inputs.
 
 Via some help here:
 http://stackoverflow.com/a/37931228/1167783
 
 */

void setup() {  
  size(600, 600);
  
  // try changing the string!
  color c = stringToColor("Hello world!");
  background(c);
}


color stringToColor(String s) {

  // min/max values that the hash could be
  int minHash = MIN_INT;
  int maxHash = MAX_INT;
  
  // ** however, if the string is less than
  // six characters long, we have to build a
  // string of the same length as our input 
  // to get the min/max hash values
  if (s.length() < 6) {
    String minH = "";
    String maxH = "";
    for (int i=0; i<s.length(); i++) {
      minH += " ";    // smallest possible char value = 32 in ascii
      maxH += "~";    // largest = 126 in ascii
    }
    minHash = minH.hashCode();
    maxHash = maxH.hashCode();
  }

  println("Min/max hash: ", minHash + " / " + maxHash);
  println("String hash:  ", s.hashCode());

  // put into color range, make sure it doesn't go over
  int maxColor = unhex("FFFFFF");
  int c = int(map(s.hashCode(), minHash, maxHash, 0, maxColor));
  c = constrain(c, 0, maxColor);
  
  // print the results as RGB
  println("RGB color:     " + (c >> 16 & 0xFF), (c >> 8 & 0xFF), (c & 0xFF));
  
  return color(c);
}