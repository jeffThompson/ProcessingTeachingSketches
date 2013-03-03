
import android.content.Context;           // required imports for network connection
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

import java.util.regex.Matcher;           // imports for regular expressions, used
import java.util.regex.Pattern;           // here to parse links from HTML source

/*
INTERNET ACCESS
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Check internet connection, download a page, and parse the results!
 
 Requires the following permissions:
 1. INTERNET
 2. ACCESS_NETWORK_STATE
 
 CHALLENGE:
 1. Format a regular expression to just look for image file links
 */

String pageURL = "http://www.processing.org";   // don't forget the 'http://'
String[] htmlSource;                            // array to load HTML source

void setup() {
  
  // basic setup and font creation
  background(0,150,75);
  smooth();
  PFont font = createFont("Monospaced", 18);
  textFont(font);
  textAlign(LEFT, TOP);

  // check for internet connection
  ConnectivityManager connMgr = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
  NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();

  // if network connection is ok, load a page's source code
  if (networkInfo != null && networkInfo.isConnected()) {
    println("Network connection ok!");

    // load a page using Processing's loadStrings() method; run in a
    // try statement to catch problems with the URL, etc
    try {
      htmlSource = loadStrings(pageURL);   // load into an array!
    }
    catch (NullPointerException npe) {
      println("Couldn't load the URL - did you include 'http://'?");
    }
  }

  // no connection, display an error
  else {
    println("Network connection not available, sorry!");
  }
  
  // parse all links from the source code, display the results
  // note that using a HTML-parsing library like BeautifulSoup would
  // be much more reliable
  String links = "";
  Pattern p = Pattern.compile("<a href=\"(.*?)\"", Pattern.CASE_INSENSITIVE);
  for (String s : htmlSource) {
    Matcher m = p.matcher(s);
    while (m.find()) {
      links += m.group(1) + "\n";
    }
  }
  text(links, 20,20);
}

