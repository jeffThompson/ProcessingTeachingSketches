/*
PARSE HTML
 Jeff Thompson
 March 2012
 
 A basic HTML parser - this code downloads the source code from a web page and
 creates an array of all the links and images on the site.  It can also automatically
 download the image files to your computer.
 
 While a full-fledged HTML parser must be very agile and adaptive (since source code
 can vary so much), our simple example can easily be tailored to specific sites.  Making
 a parser that could work as a web crawler or something similar would be much harder.
 
 For a Java-based HTML parser, try Java's JSoup library (or my example patch to
 do so within Processing (ParseHTML_WithJSoup.pde)... :)
 
 www.jeffreythompson.org
 */

// URL to load (either local or online - specify either below)
String urlLocal = "example.html";
String urlOnline = "http://www.jeffreythompson.org/Processing/example.html";


void setup() {

  // load the page source into an array; set up an empty array to put source code into
  String[] rawSource = loadStrings(urlLocal);    // download HTML source
  String[] source = new String[0];               // empty array to append lines to

  // if we were to print the raw source, you would notice lots of
  // extra spaces and blank lines - first we get rid of these
  // println(rawSource);
  for (int i=0; i<rawSource.length; i++) {

    // remove any whitespace at the start of the line (like tabs) and
    String tempLine = rawSource[i].trim();

    // test if it is a blank line; note we can't use the == to test
    // but must use the .equals() for strings - the ! means does not equal
    if (!tempLine.equals("")) {

      // if not blank, add to the end of the source array
      source = splice(source, tempLine, source.length);
    }
  }

  // print our cleaned up source code!
  // println(source);

  // now to extract some data!
  // this is a bit tricky, but essentially we're looking for certain tags
  // and returning anything contained within them

  // GET ALL LINKS
  // links are in the <a> tag, with the string href="<url>" holding the
  // actual link; note we use the \ to get the character " in the string
  String[] links = new String[0];
  for (int i=0; i<source.length; i++) {

    // to make things easier, we use the Pattern and Matcher classes from
    // Java - it doesn't really matter how this works, though it's useful to note
    // that we're not including quotes in the matching string above - this is because 
    // some html uses single quotes, some double
    Pattern p = Pattern.compile("<a href=(.*?)>");
    Matcher m = p.matcher(source[i]);                    

    // if there are matches...
    while (m.find ()) {

      // we just want the the second result (1), which is just the link url (likely more useful)
      String tempLine = m.group(1);                            // get links with quotes...
      tempLine = tempLine.substring(1, tempLine.length()-1);    // ... strip first and last characters (the quotes)
      links = splice(links, tempLine, links.length);           // ... add the results to the array!
    }
  }
  println("LINKS:");
  println(links);

  // GET ALL IMAGES
  // this works just like the links code above, but gets image URLs - however, the above code doesn't
  // take into account other elements in the HTML such as IDs which might be between the "<img" and the "src="
  // code or after the end of the image url; here we fancify our code a bit to accomodate such instances
  String[] images = new String[0];
  for (int i=0; i<source.length; i++) {

    // the additional .*? finds anything that starts with "<img", continues to "src=", and ends with "/>
    // for example: <img src='http://www.jeffreythompson.org/Processing/sampleImage.png' />
    Pattern p = Pattern.compile("<img.*?src=(.*?) .*?/>");
    Matcher m = p.matcher(source[i]);

    while (m.find ()) {
      String tempLine = m.group(1);
      tempLine = tempLine.substring(1, tempLine.length()-1);
      images = splice(images, tempLine, images.length);
    }
  }
  println("\nIMAGES:");
  println(images);

  // DOWNLOAD ALL IMAGES
  // using the array of image URLs, we can automatically download all image files
  // WARNING: it is not recommended to try this for an untested site, as it may 
  // try to download a TON of images - use at your own risk
  println("\nDOWNLOAD ALL IMAGES:");
  for (int i=0; i<images.length; i++) {

    // let us know where we're at in the process
    print("Downloading image " + (i+1) + "/" + images.length + "...");

    // download the image using a temporary PImage and the URL
    // this is a Processing-specific hack that doesn't use the MUCH more complicated Java
    // methods - it also seems to play nice with lots of file formats and will save into
    // whatever format you specify below (nice and convenience!)

    // NOTE: this only works for URLs that are specified with a full path; local URLs will
    // not work - this is completely possible but would require more complex code than
    // would make sense here...
    PImage tempImg = loadImage(images[i]);

    // save as #####.png - the nf() command adds leading zeros to the filename...
    tempImg.save(nf(i, 5) + ".png");
    print(" DONE!\n");
  }

  exit();
}

