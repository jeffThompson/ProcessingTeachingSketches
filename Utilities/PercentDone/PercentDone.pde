
/*
PERCENT DONE
Jeff Thompson | 2013 | www.jeffreythompson.org

Update on progress in set increments! Very useful for long processes (ie pixel
processing, etc) but where updating every time would be overload.  Here we
count to 200, updating us every 10% of the way.
*/

int numItems = 200;                           // total # of items in the set
int updatePercent = 10;                       // update us every N %

for (int i=0; i<numItems; i++ ) {
  if (i % (numItems/updatePercent) == 0) {    // if we're at a specified increment...
    println(i);                               // print the current #
  }
}
