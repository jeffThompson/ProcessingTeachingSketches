
// a hex color value - the #-sign is optional
String hexColor = "#FFFFFF";

// strip the # if present
String[] testForPoundSign = match(hexColor, "#");
if (testForPoundSign != null) {
  println("Removing pound sign from start of value...");
  hexColor = hexColor.substring(1,7);
}

// get r,g,b values using substring; argument '16' specifies
// the values returned are from hex values
int r = Integer.valueOf(hexColor.substring(0,2), 16);
int g = Integer.valueOf(hexColor.substring(2,4), 16);
int b = Integer.valueOf(hexColor.substring(4,6), 16);

// print the result
println(r + ", " + g + ", " + b);
exit();
