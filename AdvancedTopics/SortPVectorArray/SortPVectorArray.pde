
/*
SORT PVECTOR ARRAY
Jeff Thompson | 2014 | www.jeffreythompson.org

While sorting custom objects can be more easily accomplished
using the Comparator class, for built-in objects like PVector
it's a little trickier.

Note: this sorts by the PVector's 'y' variable - if you want
to sort by 'x' or 'z', you'll need to change the function.

Based, in part, on this:
http://thilinasameera.wordpress.com/2011/06/01/sorting-algorithms-sample-codes-on-java-c-and-matlab

*/


void setup() {

  // create 3 random PVectors
  PVector[] vertices = { 
    PVector.random3D(), PVector.random3D(), PVector.random3D()
  };
  
  // print unsorted array
  println("UNSORTED");
  for (PVector v : vertices) println(v);

  // sort!
  vertices = countingSort(vertices);
  
  // print sorted array!
  println("\n" + "SORTED");
  for (PVector v : vertices) println(v);
}

// a reusable function to sort an array of PVectors
// change instances of 'y' variable to sort by x/z
PVector[] countingSort(PVector[] in) {
  float j = 0;
  PVector tmp;
  
  for (int i=0; i<in.length; i++) {
    j = i;
    for (int k = i; k<in.length; k++) {
      if (in[int(j)].y > in[k].y) {
        j = k;
      }
    }
    tmp = in[i];
    in[i] = in[int(j)];
    in[int(j)] = tmp;
  }
  return in;
}

