
/*
IF STATEMENTS
Jeff Thompson | 2015 | www.jeffreythompson.org

If/else statements can be used to compare two
values and control the flow of a program.

COMPARISONS
We use a set of special symbols to compare values:

>    greater than                2 > 1
<    less than                   1 < 2
>=   greater than or equal to    4 >= 2+2
<=   less than or equal to       1 <= 2+2 
==   equal to                    5 == 2+3
&&   and                         a < b && b >= 10
||   or                          a < b || b > c

*/


void setup() {
  
  // some variables to work with - try changing
  // them and see the results
  int a = 1;
  int b = 2;
  
  // compare the integers
  if (a == b) {                        // are the two numbers equal?
    println("A is equal to B!");
  }
  else if (a > b) {                    // is a larger than b?
    println("A is greater than B!");
  }
  else {                               // if not equal and a is not greater than b...
    println("B is greater than A!");
  }
  
  
  // booleans can be written using == but we can also
  // shorten it a bit (which many people find easier to read)
  boolean enjoyIfStatements = true;
  if (enjoyIfStatements) {                // if true
    println("I enjoy if statements!");
  }
  
  boolean dinnerTime = false;
  if (!dinnerTime) {                      // if false
    println("It is not dinner time...");
  }
  
  
  // string comparison is a little different
  String myName = "Jeff";
  String yourName = "Anne";
  if (myName.equals(yourName)) {
    println("We have the same name!");
  }
  else {
    println("We don't have the same name...");
  }
}


