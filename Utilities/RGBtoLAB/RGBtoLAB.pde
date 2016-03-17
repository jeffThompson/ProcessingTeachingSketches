
/*
RGB to LAB COLOR
 Jeff Thompson | 2015 | www.jeffreythompson.org
 
 Converts RGB color to LAB color model. Bonus: measuring
 the difference between two colors is best done with
 LAB color!
 
 Based on this great example:
 https://github.com/StanfordHCI/c3/blob/master/java/src/edu/stanford/vis/color/LAB.java
 
 */


void setup() {

  // convert from RGB to LAB color
  float[] lab = fromRGB(255, 0, 0);
  println(lab);

  // bonus: test the difference between two colors!
  float[] another = fromRGB(10, 255, 0);
  float diff = pow(lab[0]-another[0], 2) + pow(lab[1]-another[1], 2) + pow(lab[2]-another[2], 2);
  println(diff);

  exit();
}



float[] fromRGB(int _r, int _g, int _b) {
  // normalize RGB values
  double r = _r / 255.0;
  double g = _g / 255.0;
  double b = _b / 255.0;

  double binSize = 0;

  // D65 standard referent
  double X = 0.950470, Y = 1.0, Z = 1.088830;

  // map sRGB to CIE XYZ
  r = r <= 0.04045 ? r/12.92 : Math.pow((r+0.055)/1.055, 2.4);
  g = g <= 0.04045 ? g/12.92 : Math.pow((g+0.055)/1.055, 2.4);
  b = b <= 0.04045 ? b/12.92 : Math.pow((b+0.055)/1.055, 2.4);
  double x = (0.4124564*r + 0.3575761*g + 0.1804375*b) / X, 
    y = (0.2126729*r + 0.7151522*g + 0.0721750*b) / Y, 
    z = (0.0193339*r + 0.1191920*g + 0.9503041*b) / Z;

  // map CIE XYZ to CIE L*a*b* and return
  x = x > 0.008856 ? Math.pow(x, 1.0/3) : 7.787037*x + 4.0/29;
  y = y > 0.008856 ? Math.pow(y, 1.0/3) : 7.787037*y + 4.0/29;
  z = z > 0.008856 ? Math.pow(z, 1.0/3) : 7.787037*z + 4.0/29;

  double L = 116*y - 16, 
    A = 500*(x-y), 
    B = 200*(y-z);

  if (binSize > 0) {
    L = binSize * Math.floor(L / binSize);
    A = binSize * Math.floor(A / binSize);
    B = binSize * Math.floor(B / binSize);
  }

  float[] lab = { (float)L, (float)A, (float)B };
  return lab;
}