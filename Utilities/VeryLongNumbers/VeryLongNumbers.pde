
import java.math.BigInteger;

/*
VERY LONG NUMBERS
Jeff Thompson | 2015 | www.jeffreythompson.org

Long numbers can be difficult to work with. Here are some
options to make it a little easier.

All examples below use one-million as their value. Note that
they all should print the same number :)

*/

// a long, hard to read number
int longNumber = 1000000;
println("A long #:            " + longNumber);

// scientific notation
// note this returns a floating point number
// for an int, you must cast it like below
int scientificNotation = (int) 1e6;     // 1 followed by 6 0s
println("Scientific notation: " + scientificNotation);

// use _ as a thousands separator
// works only on Java 7+ :(
// int thousandsSeparator = 1_000_000;
// println("Thousands separator: " + thousandsSeparator);

// REALLY big numbers can use the BigInteger class, which stores
// the numbers as a string (and is limited only to your computer's memory)
// for a full example, see Advanced Topics > Really Big Numbers
BigInteger b = new BigInteger("1000000");
println("BigInteger:          " + b);


