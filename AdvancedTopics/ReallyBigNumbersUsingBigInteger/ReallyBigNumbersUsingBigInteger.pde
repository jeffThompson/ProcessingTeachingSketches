/*
 REALLY BIG NUMBERS (using BigInteger)
 Jeff Thompson
 
 Sometimes an int/float is too small; sometimes a long/double also just
 won't cut it.  In those cases, and when "fancy math" isn't necessary,
 a BigInteger is just right.
 
 Seen essentially as strings, you are limited only by your RAM.  A 
 few operations: add, subtract, multiply, divide, abs, modulus, pow, plus
 some cool ones like if the value is a probable prime number...
 
 For a full list of available methods, see the docs:
 http://docs.oracle.com/javase/1.4.2/docs/api/java/math/BigInteger.html
 
 www.jeffreythompson.org
 */

// we must import the BigInteger class from the math library
import java.math.BigInteger;

// create two new BigIntegers
BigInteger x = new BigInteger("1");    // since BigInts are ultimately seen as
BigInteger y = new BigInteger("20");   // strings, they are declared in double-quotes

// dispaly (note: no need to cast into any other type**)
println("FIRST\t" + x);
println("SECOND\t" + y);
println();

// ** note: for use in things like text(), must cast using x.toString()

// basic math
println("ADD\t" + x.add(y));            // both values must be BigInts (other types
println("SUBTRACT\t" + x.subtract(y));  // will throw an error)
println("MULTIPLY\t" + x.multiply(y));
println("DIVIDE\t" + x.divide(y));
println();

// ++ and -- operations
println("INCREMENT\t" + x.add(new BigInteger("1")));        // create temporary BigInts
println("DECREMENT\t" + x.subtract(new BigInteger("1")));   // to be used just here
println();

// a huge number that would be otherwise impossible
BigInteger biggestAsLong = new BigInteger("9223372036854775807");   // longest value a long can hold
println("HUGE\t" + biggestAsLong.add(new BigInteger("1")));         // add one!
println("MONSTEROUS\t" + biggestAsLong.pow(2));                     // really big :)

exit();
