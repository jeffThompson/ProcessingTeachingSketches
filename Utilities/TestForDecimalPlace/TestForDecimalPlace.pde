/*
TEST FOR DECIMAL PLACE
Jeff Thompson
Fall 2011

Sometimes you want to test for whether a number needs a decimal place

Example:you want to display "1" next to "3.5", but don't want "1" to
show up as "1.0".

www.jeffreythompson.org
*/

// value to test
float decimalToTest = 2.0;

// 'nf' trims to 10s place only (leaves a number like 2.0 from 2.05)
// this also returns a string, so we save a step!
String trimmedDecimal = nf(decimalToTest, 0,1);

// and get the last character in the string (length-1)
int test = int(trimmedDecimal.charAt(trimmedDecimal.length()-1));

// if the last digit is not 0 we need the floating-point precision (ex: 4.2)
// but if it's a 0 (ex: 9.0) then we don't!
if (test != 48) {    // 48 is the ASCII value for 0
  println(decimalToTest + " has decimal precision!");
}
else {
  // if it doesn't need the decimal place, convert to an int
  println(int(decimalToTest) + " doesn't need the decimal place!");
}

// quit, since there's nothing to see here
exit();

/*
// how to convert the float to a string, though we don't need this here...
String convertedToString = Float.toString(trimmedDecimal);
*/
