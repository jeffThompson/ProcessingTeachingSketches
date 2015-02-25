
/*
FUNCTIONS
Jeff Thompson | 2015 | www.jeffreythompson.org

Being clear and concise: these are some of the marks of
great code. But big projects can get very messy, so we
can offload code into "funtions".

Processing is actually full of functions: setup(), rect(),
etc are all functions!

STRUCTURE
The function can return a variable or "void", meaning
it doesn't return anything. The structure of a function
looks like this:

  type name(type argument1, type argument2) {
    // some code
  }

CHALLENGE
1.  Can you make a function to compute they Pythagorean
    theorem? What input arguments would you need?
2.  Can you make a function to draw a 4 rectangles of
    random colors next to each other? Hint: this will
    return the type "void".

*/


void setup() {
  size(600,600);
  
  // use a function to compute the area of the window
  int area = computeArea(width, height);
}


// our function, which returns an integer
// arguments are also two ints for width and height
// to compute the area
int computeArea(int w, int h) {
  int area = w * h;  // calculate area
  return area;       // return the result!
}


