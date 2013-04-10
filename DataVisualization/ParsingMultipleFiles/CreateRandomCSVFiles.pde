
// create random CSV files
void createRandomFiles(int numFiles, int numLines) {
  for (int i=0; i<numFiles; i++) {
    String[] str = new String[numLines];
    for (int j=0; j<str.length; j++) {
      String s = "";
      s = Integer.toString(int(random(width)));
      s += "," + Integer.toString(int(random(height)));
      s += "," + Integer.toString(int(random(255)));
      s += "," + Integer.toString(int(random(255)));
      s += "," + Integer.toString(int(random(255)));
      str[j] = s;
    }
    saveStrings("dataFiles/" + i + ".csv", str);
  }
}

