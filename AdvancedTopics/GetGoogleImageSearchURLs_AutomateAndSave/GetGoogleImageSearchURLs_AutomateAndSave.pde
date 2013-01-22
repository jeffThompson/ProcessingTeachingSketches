
import java.net.HttpURLConnection;    // required for HTML download
import java.net.URL;                  // ditto, etc...
import java.net.URLConnection;
import java.net.URLEncoder;
import java.io.InputStreamReader;     // used to get our raw HTML source
import java.io.File;

/*
GET GOOGLE IMAGE SEARCH URLs - AUTOMATE AND SAVE
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 A more advanced version of the 'GetGoogleImageSearchURLs' sketch - this one gets URLs 20 at a time (the
 max limit from Google), then downloads them to a folder.  Other goodies (like auto-increment filename)
 are in the code below!
 
 Some other good-looking resources:
 https://developers.google.com/custom-search/docs/xml_results?hl=en
 
 */

// term to search for (use spaces to separate terms)
String searchTerm = "mountain grass";

int numSearches = 10;                 // how many searches to do (limited by Google to 20 images each) 
String fileSize = "10mp";             // specify file size in mexapixels - S/M/L not figured out yet :)
boolean saveImages = true;            // save the resulting images?

String source = null;                 // string to save raw HTML source code
String[] imageLinks = new String[0];  // array to save URLs to - written to file at the end
int offset = 0;                       // we can only 20 results at a time - increment to get total # of searches
int imgCount = 0;                     // count saved images for creating filenames
String outputTerm;


void setup() {

  // format spaces in URL to avoid problems; convert to _ for saving
  outputTerm = searchTerm.replaceAll(" ", "_");
  searchTerm = searchTerm.replaceAll(" ", "%20");

  // any images already stored in this folder? if so, start our count at the highest value
  // to avoid overwriting any files
  File previous = new File(sketchPath("") + outputTerm);
  if (previous.exists() && previous.isDirectory()) {
    println("Updating image filenames to avoid overwriting existing files!");
    File[] allFiles = previous.listFiles();
    String lastEntry = allFiles[allFiles.length-1].getName();                                           // get final file (by necessity this will be alpha order)  
    String lastNumber = lastEntry.substring(lastEntry.lastIndexOf('_')+1, lastEntry.lastIndexOf('.'));  // split from _ to .
    imgCount = offset = Integer.parseInt(lastNumber) + 1;                                               // update the count and offset so we don't overwite!
  }

  // run search as many times as specified
  println("Retreiving image links (" + fileSize + ")...\n");
  for (int search=0; search<numSearches; search++) {
    
    // let us know where we're at in the process
    print("  " + ((search+1)*20) + " / " + (numSearches*20) + ":");

    // get Google image search HTML source code; mostly built from PhyloWidget example:
    // http://code.google.com/p/phylowidget/source/browse/trunk/PhyloWidget/src/org/phylowidget/render/images/ImageSearcher.java
    print(" downloading...");
    try {
      URL query = new URL("http://images.google.com/images?gbv=1&start=" + offset + "&q=" + searchTerm + "&tbs=isz:lt,islt:" + fileSize);
      HttpURLConnection urlc = (HttpURLConnection) query.openConnection();                                // start connection...
      urlc.setInstanceFollowRedirects(true);
      urlc.setRequestProperty("User-Agent", "");
      urlc.connect();
      BufferedReader in = new BufferedReader(new InputStreamReader(urlc.getInputStream()));               // stream in HTTP source to file
      StringBuffer response = new StringBuffer();
      char[] buffer = new char[1024];
      while (true) {
        int charsRead = in.read(buffer);
        if (charsRead == -1) {
          break;
        }
        response.append(buffer, 0, charsRead);
      }
      in.close();                                                                                         // close input stream (also closes network connection)
      source = response.toString();
    }
    // any problems connecting? let us know
    catch (Exception e) {
      e.printStackTrace();
    }

    // extract image URLs only, starting with 'imgurl'
    println(" parsing...");
    if (source != null) {
      // built partially from: http://www.mkyong.com/regular-expressions/how-to-validate-image-file-extension-with-regular-expression
      String[][] m = matchAll(source, "imgurl=(.*?\\.(?i)(jpg|jpeg|png|gif|bmp|tif|tiff))");    // (?i) means case-insensitive
      if (m != null) {                                                                          // did we find a match?
        for (int i=0; i<m.length; i++) {                                                        // iterate all results of the match
          imageLinks = append(imageLinks, m[i][1]);                                             // add links to the array**
        }
      }
    }

    // ** here we get the 2nd item from each match - this is our 'group' containing just the file URL and extension

    // update offset by 20 (limit imposed by Google)
    offset += 20;
  }

  // save the resulting URLs to a file (easier to see and save)
  println("\nWriting URLs to file...");
  saveStrings("urlLists/" + searchTerm + "_URLs.txt", imageLinks);

  // and/or save them!
  // note that this could be done all in the parsing step, but we do this here for clarity
  if (saveImages) {
    println("\nSaving images to disk (this may take a while)...");
    for (String link : imageLinks) {

      // run in a 'try' in case we can't connect to an image
      try {

        // get file's extension - format new filename for saving (use name with '_' instead of '%20'
        String extension = link.substring(link.lastIndexOf('.'), link.length()).toLowerCase();
        if (extension.equals("jpeg")) {        // normalize jpg extension
          extension = "jpg";
        }
        else if (extension.equals("tif")) {    // do the same for the unlikely case of a tiff file
          extension = "tiff";
        }
        String outputFilename = outputTerm + "_" + nf(imgCount, 5) + extension;
        println("  " + imgCount + ":\t" + outputFilename);

        // load and save!
        PImage img = loadImage(link);
        img.save(sketchPath("") + outputTerm + "/" + outputFilename);
        imgCount++;
      }
      catch (Exception e) {
        println("    error downloading image, skipping...\n");    // likely a NullPointerException
      }

      // looking for something fancier? try: 
      // http://www.avajava.com/tutorials/lessons/how-do-i-save-an-image-from-a-url-to-a-file.html
    }
  }

  // all done!
  println("\nALL DONE!");
  exit();
}

