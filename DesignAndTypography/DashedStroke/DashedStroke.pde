import java.awt.Graphics2D;    // required imports for dashed lines
import java.awt.BasicStroke;

/*
DASHED STROKE
Jeff Thompson | 2013 | www.jeffreythompson.org

Draw dashed strokes! Uses Java AWT for VERY easy stroke patterns on any shape!

Cap otpions (ends of the lines):
CAP_BUTT, CAP_ROUND, CAP_SQUARE

Corner options:
JOIN_BEVEL, JOIN_MITER, JOIN_ROUND

Built from an example by davebol (with a very cool random stroke pattern!):
http://processing.org/discourse/beta/num_1202486379.html

Two BasicStroke arguments not used here:
+ 3rd-to-last argument (1.0f) is the miter limit
+ last argument (0.0f) is the dash's "phase", or offset starting point

More details? See the Javadoc:
http://pages.cs.wisc.edu/~hasti/cs368/JavaTutorial/jdk1.2/api/java/awt/BasicStroke.html
*/

float[] dash = { 15.0, 20.0, 5.0, 20.0 };    // an array that defines the stroke pattern (on, off)
float weight = 4.0;                          // stroke's weight

void setup() {
  
  // basic setup
  size(500,500);
  background(0);
  
  // set colors for stroke and fill as usual
  stroke(255);
  fill(255, 150, 0);
  
  // create the stroke!
  Graphics2D g2 = ((PGraphicsJava2D)g).g2;    // create instance of Graphics2D for the BasicStroke
  BasicStroke stroke = new BasicStroke(weight, BasicStroke.CAP_SQUARE, BasicStroke.JOIN_MITER, 1.0f, dash, 0.0f);
  g2.setStroke(stroke);
  
  // draw something!
  rectMode(CENTER);
  rect(width/2, height/2, 240,240);
}
