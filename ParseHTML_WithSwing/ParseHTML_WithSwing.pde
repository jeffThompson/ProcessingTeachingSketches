import javax.swing.text.html.*;
import javax.swing.text.Element;
import javax.swing.text.ElementIterator;
import java.net.URL;
import java.io.Reader;

/*
HTML PARSER USING JAVA'S SWING LIBRARY
 Jeff Thompson
 March 2012
 
 A more complex but powerful example, this sketch leverages Java's built-in
 Swing library to parse HTML.  Here we automatically retrive all image URLs.
 
 While this isn't as pretty as the Processing-based version, it has the benefit
 of Swing's super-flexible parsing.  Malformed HTML source code and other weirdness
 will not cause errors, making projects like web-crawlers possible.
 
 Built heavily from this example by Kevin Cole (kudos!):
 http://www.rkcole.com/articles/swing/HTMLParser.html
 
 www.jeffreythompson.org
 */

String urlToLoad = "http://www.processing.org";

void setup() {

  // we run everything within a generic try statement, since many of these
  // commands throw a multitude of exceptions - just easier this way
  try {

    // create a new URL object to load (like a string but specific to URLs and
    // can be checked for proper form) - this is the required format for Swing
    URL url = new URL(urlToLoad);
    
    // load the page source using the HTMLReader
    HTMLEditorKit kit = new HTMLEditorKit();
    HTMLDocument doc = (HTMLDocument) kit.createDefaultDocument();
    doc.putProperty("IgnoreCharsetDirective", Boolean.TRUE);
    Reader HTMLReader = new InputStreamReader(url.openConnection().getInputStream());
    kit.read(HTMLReader, doc, 0);

    // create an iterator to step through the source code
    ElementIterator it = new ElementIterator(doc);
    
    // HTML element (another specific type of object used by Swing)
    Element elem;

    // got through file using a while loop - run until the next element returns null
    while ( (elem = it.next()) != null) {
      
      // test for the kind of tag we're looking for, in this case images
      if (elem.getName().equals("img")) {
        
        // a complex command: create a string with the source of the images
        String s = (String)elem.getAttributes().getAttribute(HTML.Attribute.SRC);
        
        // if the string returns something (an image source), print the result
        if (s != null) {
          println(s);
        }
      }
    }
  }
  
  // any problems along the way, quit
  catch (Exception e) {
    println("Error reading URL, quitting...");
    exit();
  }

  exit();
}

