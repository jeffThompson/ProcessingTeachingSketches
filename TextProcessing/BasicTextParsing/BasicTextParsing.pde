
/*
BASIC TEXT PARSING
Jeff Thompson | 2013 | www.jeffreythompson.org

A basic introduction to text-parsing using Processing.

Variable types we'll use here:
Char: short for 'character', a single typographical symbol like 'A' or ',' (noted with single-quotes)
String: a series of characters forming what usually look like sentences (noted with double-quotes)
Int: short for 'integer', or a whole number (ie: 1, 4, 293, etc)

What we're going to do in this example:
1. create a source sentence
2. get # of characters (single typographical symbols)
3. get # of words
4. count vowels

*/

// create a source sentence
String input = "It was the best of times, it was the worst of times.";

// get number of characters (includes spaces and punctuation)
int numCharacters = input.length();                 // set an integer (whole number) to the # of characters in the sentence
println("Number of letters: " + numCharacters);     // print the result below

// get number of words (a little tricker!)
String[] words = split(input, ' ');                 // split the sentence by spaces, or use splitTokens for multiple characters to split by
int numWords = words.length;                        // note we no not use the () for the length of arrays (# elements)
println("Number of words: " + numWords);

// count the vowels!
String lowercaseInput = input.toLowerCase();        // try without this - notice our algorithm skips the capital 'I' at the beginning of the sentence!
char[] letters = lowercaseInput.toCharArray();      // split the sentence into a list of characters (single typographical symbol)
int vowelCount = 0;                                 // create a variable to count vowels = we add 1 to this every time we find a vowel

// iterate over the letters array using a for loop
// for each character in the list, temporarily create a variable 'letter' and set it to the current character
// NOTE: there are lots of ways to do this - many that are better than this; for a few other (more advanced options)
// see Processing's built-in match/matchAll and the all-powerful 'regular expressions'
for (char letter : letters) {
  if (letter == 'a' || letter == 'e' || letter == 'i' || letter == 'o' || letter == 'u') {    // is it one of the vowels? the '||' means OR
    vowelCount = vowelCount + 1;                                                              // if so, add one (or use the ++ method)
  }
}
println("Number of vowels: " + vowelCount);

// quit when done!
exit();
