/*
USING MODULUS
Jeff Thompson
April 2012

Modulus (%) returns the remainder of division, and can
be VERY useful for doing things like count in other
divisions, say by 3's like we do below.

www.jeffreythompson.org
*/

// count by 3's (0,1,2,0,1,2, etc)
print("ROWS:    ");
print(0 % 3 + " ");
print(1 % 3 + " ");
print(2 % 3 + " ");
print(3 % 3 + " ");
print(4 % 3 + " ");
print(5 % 3 + " ");
print(6 % 3 + " ");
print(7 % 3 + " ");
print(8 % 3 + " ");
// ... this will continue forever!

println("");

// the above example is great for going one
// direction, but let's say we want to count
// x,y coordinates - how do we get the y so
// we count 3px across, then a new row, 3px
// across, etc?

print("COLUMNS: ");
int y = 0;                  // temp value to count y position (start at 0)
for (int i=0; i<9; i++) {   // iterate across all positions (3x3 = 9)
  
  print(y + " ");           // print the result!
  
  // if we've reached the end of a line, increase the y value
  // note we do this AFTER printing the y since we don't want
  // to increment until the last value of the row is returned
  if (i%3 == 2) {            // if at the end of the row...
    y++;                     // add 1 to y
  }
}

exit();




