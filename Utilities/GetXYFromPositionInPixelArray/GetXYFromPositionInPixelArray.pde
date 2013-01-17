
/*
GET X/Y FROM POSITION IN PIXEL ARRAY
Jeff Thompson | 2013 | www.jeffreythompson.org

While the formula for finding the position in a pixel array from x/y
coordinates is well-documented:

  position = y*width + x;

Getting the reverse - x/y coordinates from a position, is not... :(
*/

void setup() {
  
  size(300,300);
  
  // an arbitrary position within the pixel array
  int position = int(random(0, width*height));

  int x = position % width;        // remainder from row
  int y = position / width;        // how many rows are we down?

  println(x + ", " + y);
}
