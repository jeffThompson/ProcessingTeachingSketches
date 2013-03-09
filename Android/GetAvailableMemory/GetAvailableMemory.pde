import android.app.ActivityManager;  // required import for "nice" memory
import java.lang.Runtime;            // required import for max memory

/*
GET AVAILABLE MEMORY
Jeff Thompson | 2013 | www.jeffreythompson.org

Gets the amount of memory available to your application - useful when
adding assets such as images or sounds. Here we get two values, the maximum
memory available to your app and the amount considered "nice". With many
devices, these numbers will be the same.

Via this very detailed post:
http://stackoverflow.com/a/9428660/1167783
*/

float maxMemory;    // variables for available memory available to your app
int niceMemory;

void setup() {
  background(0);
  smooth();
  
  // get the amount of memory available if you want to be nice to your app
  // other methods for ActivityManager:
  // http://developer.android.com/reference/android/app/ActivityManager.html
  ActivityManager am = (ActivityManager) getSystemService(ACTIVITY_SERVICE);
  niceMemory = am.getMemoryClass();
  
  // get the total amount of memory available, regardless of kindness
  // other methods for Runtime:
  // http://developer.android.com/reference/java/lang/Runtime.html
  Runtime rt = Runtime.getRuntime();
  maxMemory = rt.maxMemory() / 1048576;    // convert from bytes to MB
  
  // create a font and display the result
  PFont font = createFont("SansSerif", 72);
  textFont(font);
  textAlign(CENTER, CENTER);
  
  fill(255);
  String memory = "Memory (being nice): " + niceMemory + " MB\n";    // format a string for display
  memory += "Maximum memory: " + maxMemory + " MB";
  text(memory, width/2,height/2);
}
