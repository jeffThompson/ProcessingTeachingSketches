
import java.util.Iterator;

/*
USING JAVA'S Iterator TO REMOVE ELEMENTS FROM ArrayList
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 While using a for loop to go through an ArrayList is often ok, if
 you want to remove items this can cause problems.  Instead, we use
 Java's built-in Iterator class to remove all multiples of 5!
 */

// create an ArrayList and store a bunch of numbers!
ArrayList<Integer> nums = new ArrayList<Integer>();
for (int i=0; i<25; i++) {
  nums.add(i);
}

// go through and remove multiples of 5 from the ArrayList!
Iterator<Integer> iter = nums.iterator();
while (iter.hasNext ()) {
  if (iter.next().intValue() % 5 == 0) {    // tests for multiples of 5
    iter.remove();
  }
}

// print the results so we can see that this worked!
for (int i=0; i<nums.size(); i++) {
  print(nums.get(i) + ", ");
}
println("");

//////////////////
// this version (while it doesn't use an Iterator), allows us to
// compare all values in an ArrayList to all others, removing ones
// that are too close to each other.
// mostly via: http://stackoverflow.com/a/14389321/1167783

// reset our array and fill with random values
nums.clear();
for (int i=0; i<25; i++) {
  int rand = int(random(255));
  nums.add(rand);
  print(rand + ", ");  
}
println();

// create a new ArrayList to store values that AREN'T too close
// note that this is safest, since we don't remove items while iterating
ArrayList<Integer> results = new ArrayList<Integer>();
all: for (Integer current : nums) {    // this uses a 'label' so we can continue to the outer loop
  for (Integer other : results) {      // go through all other items
    if (abs(current - other) < 5) {    // if the difference is below a certain threshold, ignore
      continue all;                    // break out and to the 'add' code below
    }
  }
  results.add(current);                // if we're still here it means the values are far enough apart: add to the results!
}
nums = results;                        // set the original array to the results (for cleaner coding)

// print the results to compare!
for (int i=0; i<nums.size(); i++) {
  print(nums.get(i) + ", ");
}

exit();
