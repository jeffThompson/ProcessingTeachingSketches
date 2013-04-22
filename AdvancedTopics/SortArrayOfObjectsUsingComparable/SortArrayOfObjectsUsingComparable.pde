import java.util.Arrays;        // required import for sorting arrays

/*
SORT ARRAY OF OBJECTS USING COMPARABLE
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Sorts an array of objects by a certain parameter using Java's Comparable; here
 we sort a list of chili peppers by their hottness rating.
 
 Chili pepper data via:
 https://en.wikipedia.org/wiki/List_of_Capsicum_cultivars
 */

Pepper[] peppers = new Pepper[4];    // an array of Pepper objects

void setup() {

  // create our data
  peppers[0] = new Pepper("anaheim", 500);
  peppers[1] = new Pepper("jalepeno", 8000);
  peppers[2] = new Pepper("habanero", 35000);
  peppers[3] = new Pepper("poblano", 2000);

  // sort the array
  Arrays.sort(peppers);

  // print the results!
  println("Sort by hottness...");
  for (Pepper p : peppers) {
    println(p.hottness + ": " + p.name);
  }    
  exit();
}

// our Pepper class, which holds the pepper's name and hottness rating
class Pepper implements Comparable<Pepper> {
  String name;
  int hottness;

  Pepper (String _name, int _hottness) {
    name = _name;
    hottness = _hottness;
  }

  // the compareTo method will do the sorting
  int compareTo(Pepper other) {
    return this.hottness - other.hottness;    // easy, right?

    // for descending order, reverse the operation like this
    //return other.hottness - this.hottness;
  }
}

