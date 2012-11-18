/*
USING HASH MAPS TO PARSE TEXT
Jeff Thompson
February 2012

A HashMap is specifically designed for comparing and storing strings.  This example
is based on the Processing example, but uses a BufferedReader for more powerful
text processing.

www.jeffreythompson.org
*/

String filename = "dracula.txt";    // file to read
int minCount = 5;                   // don't print unless the frequency is above a certain threshold
HashMap words;                      // the HashMap object itself
BufferedReader reader;              // the BufferedReader object
String tempLine;                    // string to store the line read by the BufferedReader

void setup() {

  // create the HashMap and BufferedReader
  words = new HashMap();
  reader = createReader(filename);

  try {
    while ( (tempLine = reader.readLine ()) != null) {             // read each line until end of file

      String[] tempWord = splitTokens(tempLine, " ,.?!:;-\"()*");  // split at any of these punctuation marks

      // iterate through the array of words for each line
      for (int i=0; i<tempWord.length; i++) {
        
        // if the word has already been stored...
        if (words.containsKey(tempWord[i])) {
          Word w = (Word)words.get(tempWord[i]);    // set focus to the current word...
          w.count();                                // ... and update count
        }
        else {
          Word w = new Word(tempWord[i]);           // if it has not yet been stored, create a new one
          words.put(tempWord[i], w);                // and set the word into it
        }
      }
    }
  }
  
  // errors?
  catch (IOException e) {
    println("Error reading file, quitting...");
    exit();
  }

  // use the Iterator object to walk through the HashMap when done
  Iterator i = words.values().iterator();
  while (i.hasNext ()) {                        // so long as there are new words
    Word w = (Word) i.next();                   // get the next
    if (w.count > minCount) {                   // if the count is above the min threshold
      print(w.word + " (" + w.count + "), ");   // print the word and its count
    }
  }

  exit();
}

// instance of the HashMap
class Word {
  
  int count;
  String word;

  // store data
  Word (String s) {
    word = s;
    count = 1;
  } 

  // update count
  void count() {
    count++;
  }
}
