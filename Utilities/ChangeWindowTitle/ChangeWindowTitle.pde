/*
CHANGE WINDOW TITLE
Jeff Thompson | 2013 | www.jeffreythompson.org

*/

void setup() {
  size(500,500);  
  frame.setTitle("My Cool Window!");    // simple!
}

// or, try something cool (mousePressed requires a draw() section)
void draw() {
}

void mousePressed() {
  frame.setTitle("CLICK!");
}

void mouseReleased() {
  frame.setTitle("My Cool Window!");
}
