
/*
EXTRACT FILENAME FROM FULL PATH
Jeff Thompson | 2012 | www.jeffreythompson.org

Gets the filename from a full path, including stripping
the file extension.  Great for saving files from within
subfolders to new locations with a new file extension.
*/

String s = "path/to/file.txt";

s = s.substring(s.lastIndexOf('/')+1, s.length());
println("Split for Mac:\t" + s);

s = s.substring(s.lastIndexOf('\\')+1, s.length());
println("Split for Windows:\t" + s);

s = s.substring(0, s.lastIndexOf('.'));
println("Remove extension:\t" + s);

exit();
