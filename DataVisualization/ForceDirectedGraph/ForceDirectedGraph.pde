/*
FORCE-DIRECTED GRAPH
Jeff Thompson | 2013 | www.jeffreythompson.org

Large data can mean too many decisions about where to put each piece - instead,
let's let the software decide! A force-directed graph places all data points in
random places, then uses a physics-like system to move them until everything
settles into place.

Here we visualize all words from Shakespeare's 117th sonnet.

CHALLENGE:
+ Can you improve our Word class? Could the font and circle be scaled to the
  word count? Some other improvement?

*/

String filename = "Sonnet117.txt";     // file to visualize
HashMap <String, Word> words;          // store words in a HashMap

void setup() {
  
  size(1200,800);
  
  // load text and form HashMap
  String[] text = loadStrings(filename);
  words = new HashMap<String, Word>();
  
  // load all words, add to HashMap
  for (String line : text) {
    String[] tokens = splitTokens(line, " ,.?!:;[]-");  // split by spaces and punctuation
    for (String word : tokens) {
      word = word.toLowerCase();                        // convert to lowercase (avoids duplicates)
      
      // if word already exists, update count
      if (words.containsKey(word)) {
        Word w = words.get(word);
        w.count();
      }
      // otherwise, create in a random position
      else {
        Word w = new Word(word, random(100,width-100), random(100,height-100));
        words.put(word, w);
      }      
    }
  }
  
  // create the font
  textFont(createFont("Georgia", 16));
  textAlign(CENTER, CENTER);
}

void draw() {
  background(150,140,130);

  // draw all words to screen, update position if needed  
  for (Word w : words.values()) {
    w.display();    
    w.move();
  }
}

// a special Word class that stores data about each individual word in the HashMap
class Word {
  
  String word;    // word itself
  int count;      // count 
  float x, y;     // position
  float size;     // size of circle
  
  Word (String _word, float _x, float _y) {
    word = _word;
    count = 1;
    x = _x;
    y = _y;
    size = textWidth(word) + textWidth("OOOO");    // add some extra padding around the word
  }
  
  void count() {
    count++;        // update count - easy!
  }
  
  void display() {
    noStroke();
    fill(255, 100);
    ellipse(x,y, size,size);
    fill(0, 200);
    text(word, x,y);
  }
  
  void move() {
    for (Word other : words.values()) {                          // iterate all words
      float d = dist(x, y, other.x, other.y);                    // find distance between the 2
      if (d != 0 && d < size/2 + other.size/2 + 4) {             // dist of 0 = the same word!
        PVector direction = new PVector(x-other.x, y-other.y);   // find direction between the 2
        direction.normalize();                                   // scale to range of 0-1 (not necessary, but keeps from moving too much)
        x += direction.x;                                        // add direction (separates words)
        y += direction.y;
        
        // if the data goes offscreen, keep in in place
        if (x < size/2) {
          x = size/2;
        }
        else if (x > width-size/2) {
          x = width-size/2;
        }
        if (y < size/2) {
          y = size/2;
        }
        else if (y > height-size/2) {
          y = height-size/2;
        }
      }
    }
  }
}



