/*
LOADING CSV USING TABLES
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Working with tidy CSV files is great, but what about files with
 commas in the data? For example:
 
   "KING HENRY IV","The edge of war, like an ill-sheathed knife,"
 
 The line from "King Henry IV" by William Shakespeare includes a comma,
 which would throw off the built-in split() method!
 
 Using Processing's Table class, we can automate much of the ugliness
 found when using ill-formed or otherwise messy data. In this example,
 we load every line from Shakespeare's plays and count the total #
 of words.
 */

String filename = "ShakespearePlays.csv";
Table data;

void setup() {

  // load the data into a Table object - we specify that the first
  // row is a header, which is both skipped and loaded as easy to
  // get parameters when iterating the data!
  data = loadTable(filename, "header");
  println("# of entries: " + nfc(data.getRowCount()));

  // count the number of words in all plays!
  int wordCount = 0;
  for (TableRow entry : data.rows()) {      // iterate all rows (entries) in the file
    String line = entry.getString("Line");  // retrieve a data point using its label in the header line
    String[] words = line.split(" ");       // split that data by words
    wordCount += words.length;              // add to the total count
  }

  // print the results!
  println("# of words in all plays: " + nfc(wordCount));
}

