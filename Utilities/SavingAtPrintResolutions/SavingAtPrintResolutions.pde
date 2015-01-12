
/*
SAVING AT PRINT RESOLUTIONS
Jeff Thompson | 2014 | www.jeffreythompson.org

I like pixels, but sometimes you want to print a sketch's
output and control the page dimensions in inches or centimeters.

Here we specify the dimensions of a square at a specific
resolution. For example:

A 10-inch square at 72ppi will render at 720px
A 10-inch square at 300ppi will render at 3,000px

NOTE:
Since 72ppi is the default, your image will save larger at a
lower resolution. Open your resulting image in Photoshop and
change the resolution with "Resample" turned off. Once changed,
you will see the dimensions change back to 10".

*/

int dimension =   10;      // dimensions (in any unit - here we use inches)
int resolution =  300;     // output resolution (see note above)


void setup() {
  println("Drawing a " + dimension + "-inch square at " + resolution + " ppi...");
  
  // multiply dimension by resolution to get image size
  // here we're drawing a square
  size(dimension * resolution, dimension * resolution);
  background(0);
  
  // save the results so we can look in Photoshop!
  save(dimension + "-inSquare_" + resolution + "ppi.png");
}
