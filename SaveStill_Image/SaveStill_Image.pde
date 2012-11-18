/*
"Save Still Images"
2009

This allows you to save stills of you project.  Formats available
and recommended for print are .tiff and .png (.jpg also possible
but not suggested for print).

The code is:

  save("your_filename.format");
  
  Be sure you have no spaces and non-letter characters except the _

Images are saved in your project's sketch folder, so look for them 
there.  Files with the same name will be over-written and without warning,
so be sure to add a number to the filename before saving new versions.

Add the following code to the END of your code, just before the closing "}"

www.jeffreythompson.org
*/

void setup(){

  // all your code here
  
  // this should be the last line
  save("jeffThompson_quilt.png");
  
  // optional: exit the program when done if all
  // you want to do is save the image
  exit();

}
