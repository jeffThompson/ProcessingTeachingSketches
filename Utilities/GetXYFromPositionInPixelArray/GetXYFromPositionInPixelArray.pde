
/*
GET X/Y FROM POSITION IN PIXEL ARRAY
Jeff Thompson | 2013 | www.jeffreythompson.org

While the formula for finding the position in a pixel array from x/y
coordinates is well-documented:

  position = y*width + x;

Getting the reverse - x/y coordinates from a position, is not.

  1. get # rows down (divide position by width)
  2. using y, we can extract the remainder using our above equation
*/

void setup() {
  
  size(300,300);
  
  // an arbitrary position within the pixel array
  int position = int(random(0, width*height));

  int y = position/width;        // how many rows are we down?
  int x = position - y*width;    // remainder from finding y

  println(x + ", " + y);
}
