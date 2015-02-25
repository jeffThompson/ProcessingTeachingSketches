
/*
TEXT & FONTS
Jeff Thompson | 2015 | www.jeffreythompson.org

LOADING A FONT:
1.  Go to Tools > Create Font...
2.  Select the font you would like to use
3.  Set the size – I find using a size 2x the max you intend
    to use helps keep the font looking nice, though very small
    type may benefit from a separate font at a smaller size
4.  Copy the resulting filename at the bottom
5.  Hit OK!

CHALLENGE:
1.  Text can be placed using variables instead of static strings – can
    you create a random string generator in the draw() section that updates
    a new string each frame? (Hint: characters can be represented by integers.
    Try Googling "ASCII table" for their values.
2.  Can you make it load from an array of words
    to build a more intelligent sentence?

*/

PFont font;    // the built-in PFont object handles text

void setup() {
  size(800,600);
  background(230, 150, 80);
  
  // see instructions at top for creating your font
  font = loadFont("ClarendonT-Medi-144.vlw");
  
  // to use your font, use textFont() to set the font and size
  // note you can have multiple PFonts for different faces but
  // only need one size for each
  textFont(font, 72);
  textAlign(CENTER);      // options = LEFT, CENTER, RIGHT
  
  // draw some text!
  // arguments: text to display, x/y position
  fill(0);
  noStroke();
  text("Hello, world!", width/2, height/2);
  
  // you can add line-breaks using the special \n character
  textFont(font, 24);
  text("The quick brown fox\njumped over the lazy dog.", width/2, height/2+40);
}

  
