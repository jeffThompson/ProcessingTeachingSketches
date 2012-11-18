import org.jsoup.safety.*;
import org.jsoup.examples.*;
import org.jsoup.helper.*;
import org.jsoup.*;
import org.jsoup.parser.*;
import org.jsoup.select.*;
import org.jsoup.nodes.*;

/*
PARSING HTML WITH JSOUP
 Jeff Thompson
 March 2012
 
 A more complex but powerful example, this sketch leverages the JSoup library
 to parse HTML.  Here we automatically retrive all links and image URLs.
 
 While this isn't as pretty as the Processing-based version, it has the benefit
 of JSoup's super-flexible parsing.  Malformed HTML source code and other weirdness
 will not cause errors, making projects like web-crawlers possible.
 
 To add jsoup to your available libraries, download the current .jar file
 from: http://jsoup.org/download
 
 Rename from jsoup-1.6.2.jar (or whatever the current version is) to simply
 jsoup.jar.  Go to your Processing libraries folder (or create it if needed)
 and make a new folder called "jsoup" - in that folder make one called "library"
 and dump the .jar file inside.  Restart Processing and you're good to go!
 
 Documents > Processing > libraries > JSoup > library > jsoup.jar
 
 There are lots of other HTML parsing libraries, and Java's built-in Swing will
 work (no install needed), but JSoup is well-liked and the syntax is much cleaner.
 
 www.jeffreythompson.org
 */

// String url = "http://www.jeffreythompson.org/Processing/example.html";
String url = "http://www.cycling74.com";

// empty arrays to store links and images
String[] allLinks = new String[0];
String[] allImgs = new String[0];


void setup() {

  String[] source = loadStrings(url);

  for (int i=0; i<source.length; i++) {
    Document doc = Jsoup.parse(source[i]);

    // extract links and .png files
    // for a complete list of syntax for the select method, see:
    // http://jsoup.org/cookbook/extracting-data/selector-syntax
    Elements links = doc.select("a[href]");
    Elements imgs = doc.select("[src]");

    // iterate all links in the file; here we use a slightly different
    // format for the for loop - this means "for link in links" or
    // basically "get everything from 'links' one at a time"
    for (Element link : links) {

      // return just the link URLs
      String tempLink = link.attr("abs:href");                    // gets the 'href' attribute of the <a> tag
      if (!tempLink.equals("")) {                                 // if the link isn't blank ("")
        allLinks = splice(allLinks, tempLink, allLinks.length);   // append the result to the allLinks array
      }
    }

    // iterate all images too!
    for (Element img : imgs) {
      
      // the code actually returns anything with a 'src' attribute - this could also
      // be video, etc... check to see if the tag is 'img' using the string comparison
      // <string1>.equals(<string2>) since the == will not work for strings
      if (img.tagName().equals("img")) {

        // if a match, get the 'src' attribute of the <img> tag
        String tempSrc = img.attr("abs:src");
        if (!tempSrc.equals("")) {                                // again, skip any blank srcs
          allImgs = splice(allImgs, tempSrc, allImgs.length);     // append to array like above
        }
      }
    }
    
  }
  
  // print the results!
  println("ALL LINKS:");
  println(allLinks);
  
  println("\nALL IMAGES:");
  println(allImgs);

  exit();
}
