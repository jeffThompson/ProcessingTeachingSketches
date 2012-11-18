
int howMany = 10;              // how many copies to make of the file?
String whatFile = "test";      // what file do we manipulate (assumes .txt extension)

void setup() {

  String cmd = "sh CopyFiles.sh" + str(howMany) + whatFile;
  
  Runtime rt = Runtime.getRuntime();
  Process p = null;
  
  try { 
      p = rt.exec(cmd);
  }
  catch (IOException e) {
    System.out.println("Error reading file");
  }
  
  exit();
  
}

