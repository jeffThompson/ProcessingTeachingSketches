/*
REMOVE FILE EXTENSION
Jeff Thompson | 2012 | www.jeffreythompson.org

Simple: remove the filename from a file!
*/

String f = "output.txt";

// the magic happens here:
// 1.  f.lastIndexOf('.')      returns the position of the last period (here 6)
// 2.  f.substring(0, 6)       returns a portion of the string from 0 (start) to the final period
f = f.substring(0, f.lastIndexOf('.'));

// print the results!
println(f);
exit();
