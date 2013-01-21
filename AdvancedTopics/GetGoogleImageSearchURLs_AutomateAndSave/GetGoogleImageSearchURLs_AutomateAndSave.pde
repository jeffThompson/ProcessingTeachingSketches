
import java.net.HttpURLConnection;    // required for HTML download
import java.net.URL;
import java.net.URLEncoder;
import java.io.InputStreamReader;     // used to get our raw HTML source        

/*
GET GOOGLE IMAGE SEARCH URLs - AUTOMATE AND SAVE
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 A more advanced version of the 'GetGoogleImageSearchURLs' sketch - this one gets URLs 20 at a time (the
 max limit from Google), then downloads them to a folder.
 
 */

String searchTerm = "toast";          // term to search for
int numSearches = 2;                  // how many searches to do (limited by Google to 20 images each) 
String fileSize = "10mp";             // specify file size in mexapixels (S/M/L not figured out yet)
String source = null;                 // string to save raw HTML source code
String[] imageLinks = new String[0];  // array to save URLs to - written to file at the end
int offset = 0;                       // we can only 20 results at a time - increment to get total # of searches

void setup() {

  // format spaces in URL to avoid problems
  searchTerm = searchTerm.replaceAll(" ", "%20");

  // run search as many times as specified
  println("Retreiving image links (" + fileSize + ")...\n");
  for (int search=0; search<numSearches; search++) {
    // let us know where we're at in the process
    print("  " + (search+1) + " / " + numSearches + ":");

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
      in.close();                                                                                          // close input stream (also closes network connection)
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
      for (int i=0; i<m.length; i++) {                                                          // iterate all results of the match
        imageLinks = append(imageLinks, m[i][1]);
      }
    }

    // ** here we get the 2nd item from each match - this is our 'group' containing just the file URL and extension
    
    // update offset by 20 (limit imposed by Google)
    offset += 20;
  }

  // save the resulting URLs to a file (easier to see and save)
  saveStrings(searchTerm + "_URLs.txt", imageLinks);

  // all done!
  println("\nALL DONE!");
  exit();
}

