
import java.io.File;    // now required in Processing to use the File class
import java.net.URI;

/*
GET FILE SIZE
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Returns the size of a specified file in bytes, kb, or MB automatically!
 
 At the moment, this requires a full path (or using skethPath() as in this
 example) - suggestions to alleviate this welcome!
 */

void setup() {
  String filename = sketchPath("") + "GetFileSize.pde";
  String fileSize = getFileSize(filename);

  println(filename);
  println(fileSize);
  exit();
}

String getFileSize(String filename) {

  File f  = new File(filename);           // read into File object
  long fs = f.length();                   // get file size in bytes

  String fileSize = "";
  if (fs < 1024) {                        // less than 1 kb, measure in bytes
    fileSize += fs + " bytes";
  }
  else if (fs > 1024 && fs < 1048576) {   // 1 kb - .99 MB, measure in kb
    fs /= 1024;
    fileSize += fs + " kb";
  }
  else {
    fs /= fs/1048576;
    fileSize += fs + " MB";               // larger? measure in megabytes
  }

  return fileSize;
}
