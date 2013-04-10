
// SPOILER ALERT!
// alphabetize the words when the 'a' key is pressed
/*
void keyPressed() {
  if (key == 'a') {
    for (Word w : words.values()) {
      char firstLetter = w.word.charAt(0);                                      // get first letter
      int pos = firstLetter - 97;                                               // 'a' = 97, convert from range 0-25
      w.x = (pos % 6) * (width/6) + random(-width/12,width/12) + width/6;       // position based on a 6x5 grid (30 spaces for 26 letters)
      w.y = (pos / 6) * (height/5) + random(-height/5,height/5) + height/5;     // add some random offset too
    }
  }
}
*/
