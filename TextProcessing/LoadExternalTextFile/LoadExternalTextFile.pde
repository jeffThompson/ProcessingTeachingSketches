
/*
LOAD EXTERNAL TEXT FILE - COUNT WORDS
Jeff Thompson | 2013 | www.jeffreythompson.org

A slightly more complex example, loading a much longer text from a file.  Here we
use the built-in loadStrings method to load the file as an array (list) of strings.

For a more powerful (and therefore complex) method, see BufferedReader (or the
"ReadUsingBufferedReader" example).

*/

// load a text file!
String filename = "TimeMachine.txt";      // create a variable for our filename - makes changing our code much easier later**
// inserting a println here can be useful when we're loading long files so we know what's happening...
String[] input = loadStrings(filename);   // load the file into an array - each line will be a string in our array

// ** NOTE: this file should be in your sketch's folder, or specify a full path

// go through the file line-by-line and count words
int wordCount = 0;                        // since we're using a for loop, we need a separate variable to count words over the entire array
int lineCount = 0;                        // while we're at it, let's see how many lines were in the file!
for (String s : input) {                  // iterate line-by-line, storing the current line as a string called 's'

  String[] words = split(s, ' ');         // split this line by spaces, into a list of words
  int wordsInThisLine = words.length;     // get the length of the resulting list (the # of words in this line)
  wordCount += wordsInThisLine;           // add to the total count (+= is the same as wordCount = wordCount + wordsInThisLine)
  lineCount++;                            // like +=, ++ is the same as lineCount = lineCount + 1
}

// when done, show results and exit!
println("Total word count: " + wordCount);
println("# of lines: " + lineCount);
exit();
