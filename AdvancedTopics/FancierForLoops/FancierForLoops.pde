/*
FANCY 'FOR' LOOPS
Jeff Thompson | 2012 | www.jeffreythompson.org

Adding extra variables and other goodies to basic 'for' loop.
Results print as (0,0) (0,1) etc
*/

// TWO VARIABLES, ONE INCREMENT
print("2 var / 1 inc:     ");
for (int i=0, j=0; i<10; i++) {        // variables separated by comma
   print("(" + i + ", " + j + ") ");   // note 'j' does not increase!
}
println("\n-----");

// TWO VARIABLES, TWO INCREMENTS
// note that we only stop when 'i' reaches a certain point ('j' is ignored)
print("2 var / 2 inc:     ");
for (int i=0, j=0; i<10; i++, j+=5) {    // add one to i, 5 to j
  print("(" + i + ", " + j + ") ");
}
println("\n-----");

// TWO TEST CONDITIONS
// || stops when both are true
print("|| (both true):    ");
for (int i=0, j=0; i<10 || j<10; i++, j+=5) {
  print("(" + i + ", " + j + ") ");
}
println("\n-----");

// && stops when one or the other is true
print("&& (either true):  ");
for (int i=0, j=0; i<10 && j<10; i++, j+=5) {
  print("(" + i + ", " + j + ") ");
}
println("\n-----");

println("DONE!");
exit();
