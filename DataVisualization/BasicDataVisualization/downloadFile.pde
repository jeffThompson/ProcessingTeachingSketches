/*
FUNCTION TO DOWNLOAD DATA FILE

Takes a single argument: a string for what the file should be named when saved

Built from a cleaned-up and annotated version of:
http://cookbooks.adobe.com/post_Download_a_file_from_a_URL_in_Java-17947.html

www.jeffreythompson.org
*/


void downloadFile(String fileToSaveAs) {

  try {

    // LET US KNOW WHAT'S HAPPENING
    println("Downloading file...");
    
    // SET UP URL and DOWNLOADING STREAM
    // must be in 'try' statement, since URL throws an MalformedURLException
    URL url = new URL("http://earthquake.usgs.gov/earthquakes/catalogs/eqs7day-M2.5.txt");
    url.openConnection();                          // create connection
    InputStream fileDownloader = url.openStream(); // and set up InputStream to receive data

    // SET UP FileInputStream TO WRITE DATA INTO A NEW FILE
    FileOutputStream downloadWriter = new FileOutputStream(sketchPath + "/data/" + fileToSaveAs);
    byte[] buffer = new byte[153600];      // array to store the data
    int bytesRead = 0;                     // count how many bytes we've read
    int totalBytesRead = 0;                // ... and how many bytes in total

    // DOWNLOAD THE FILE!
    while ((bytesRead = fileDownloader.read(buffer)) > 0) {    // -1 means we're at the end of the file
      
      downloadWriter.write(buffer, 0, bytesRead);              // write to file
      buffer = new byte[153600];                               // reset byte array
      totalBytesRead += bytesRead;                             // keep track of how much we've downloaded
    }
    
    // WHEN DONE, CLOSE STREAMS TO BE 'NICE'
    downloadWriter.close();
    fileDownloader.close();

    // LET US KNOW WE'RE DONE
    println("Finished downloading (" + totalBytesRead/1000 + "kb)\n ");
  }
  
  // IF ERRORS, PRINT TO SCREEN
  catch (MalformedURLException e) {
    println("Bad URL - please try again");
    e.printStackTrace();
    exit();                // quit, since this will be an error we can't recover from
  }
  catch (IOException e) {
    println("Error reading or writing file");
    e.printStackTrace();
    exit();
  }
}

