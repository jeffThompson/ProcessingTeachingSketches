// in a regular Java app, you would need to import this library
// import java.util.*;

/*
CALENDAR AND DATE
 Jeff Thompson  |  2012  |  www.jeffreythompson.org
 
 Demonstrates the basics of setting up a date and adding
 to it in Java.
 */

int startMonth = 8;          // Jan = 1, Dec = 12 (compensated for in the code below)
int startDay = 30;           // day of mont (1-31)
int startYear = 2012;        // full year

Calendar calendarForward;    // calendar object for moving forward in time
Calendar calendarBackward;   // ditto for back in time
Format f;                    // format for displaying the date (specified in setup)

void setup() {
  size(500, 300);
  smooth();
  textAlign(LEFT, CENTER);
  frameRate(10);                // slow things down so we can see what's happening

  // create calendar objects for forward and backward
  // note: Calendar object uses January as 0, so we -1 here for convenience/clarity
  calendarForward = new GregorianCalendar(startYear, startMonth-1, startDay);
  calendarBackward = new GregorianCalendar(startYear, startMonth-1, startDay);
  
  // create the format we want for the date - try some of the examples below,
  // or see the full documentation: 
  // http://docs.oracle.com/javase/6/docs/api/java/text/SimpleDateFormat.html
  f = new SimpleDateFormat("MM/dd/yy");                // 01/30/12
  // f = new SimpleDateFormat("EEEE, MMMM d, yyyy");   // Wednesday, July 4, 1992
  // f = new SimpleDateFormat("MM - yyyy G");          // March - 2012 AD
}

void draw() {
  background(0);

  // format as a Date object, then format that as a string
  // using the SimpleDateFormat specified in the setup
  String forwardDate = f.format(calendarForward.getTime());

  // note we do two things in one step, avoiding the messy casting
  // of the calendar to a Date object - could be done in two steps
  // if desired, such as below:
  Date d = calendarBackward.getTime();
  String backwardDate = f.format(d);

  // display the results!
  fill(255);
  text("Forward:    " + forwardDate + "\n\nBackward:  " + backwardDate, 50, height/2);

  // add a day to the forward calendar, add -1 days to the backward (no subtract function)
  calendarForward.add(Calendar.DAY_OF_MONTH, 1);
  calendarBackward.add(Calendar.DAY_OF_MONTH, -1);
}

