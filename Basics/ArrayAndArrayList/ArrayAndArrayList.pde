
/*
ARRAYS AND ARRAY LISTS
Jeff Thompson | 2015 | www.jeffreythompson.org

Lists are great for storing data – an array
is good for basic, fixed-length data. ArrayLists,
a bit more complicated, are great when the number
of items you're storing will change when the code
is run.

*/


// ARRAY
// a list of a single type and fixed length

// it's declared like this:
String[] cities = new String[5];

// set items using their index (starts at 0)
cities[0] = "New York";
cities[1] = "Los Angeles";
cities[2] = "Chicago";
cities[3] = "Boston";
cities[4] = "Minneapolis";    // my home town!

// change an item the same way
cities[2] = "Seattle";

// get the # of items in the array using "length"
for (int i=0; i<cities.length; i++) {
  println(cities[i]);
}


// ARRAY LIST
// if you want a list of variable length, an ArrayList
// might be the best choice

// declaring an ArrayList is a little more complicated
ArrayList<String> fruits = new ArrayList<String>();

// set items using add()
fruits.add("apple");
fruits.add("orange");
fruits.add("banana");

// # of items is retrieved using size(), not length like an array
for (int i=0; i<fruits.size(); i++) {
  println(fruits.get(i));    // access items using get()
}

// remove an item using its index
fruits.remove(2);

// alternative syntax for iterating the ArrayList
for (String fruit : fruits) {
  println(fruit);
}


