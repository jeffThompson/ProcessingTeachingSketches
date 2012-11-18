
  // create a new file
  
  void setup() {
  
    File f;
    f = new File(filePath + "YourFile.txt");
    if (!f.exists()) {
      try {
        f.createNewFile();
      }
      catch (IOException e) {
        println(e);
      }
    }
  }

