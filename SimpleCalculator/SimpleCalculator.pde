/*
SIMPLE CALCULATOR
 Jeff Thompson
 November 2009
 
 A simple calculator project using all four math functions
 
 www.jeffreythompson.org 
 */

void setup()
{
  // no need for size or background since nothing is visual!

  // NUMBERS (change these to perform calculations)
  int num1 = 10;       // declare at least three variables
  int num2 = 20;
  int num3 = 30;
  int numAnswer = 0;  // your result

  // Addition - do this as a group, then let them do the others on their own
  numAnswer = num1+num2+num3;

  println("Addition: "+numAnswer);    // Label the answer so you know what it is!

  // Subtraction
  numAnswer = num1-num2-num3;

  println("Subtraction: "+numAnswer);

  // Multiplication
  numAnswer = num1*num2*num3;

  println("Multiplication: "+numAnswer);

  // Division
  numAnswer = num2/num1;

  println("Division: "+numAnswer);

}


