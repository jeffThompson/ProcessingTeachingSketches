/*
INCREASE MATRIX STACK
Via: http://wiki.processing.org/w/Matrix_stack

www.jeffreythompson.org
*/

// simple example sketch
void setup(){
  size(512, 512);
  noStroke();
}
 
void draw(){
  background(0);
  recursiveFunction(0);
}
 
void recursiveFunction(int fn){
  pushMatrix();
    translate(1,1);
    fill(255-fn*1,255-0.5*fn,fn*0.5,fn*1);
    rect(0,0,10,10);
    fn++;
    if(fn < 512){
      recursiveFunction(fn); 
    }
  popMatrix();
}
 
 
/**
deepmatrixstack taken from http://wiki.processing.org/index.php/Matrix_stack
to override the default stack just copy & paste the following code
   to your sketch
@author steve
*/
 
// adjust this value to whatever depth is actually necessary
public final int STACK_DEPTH = 512;
public float[][] matrixStack = new float[STACK_DEPTH][6];
public int matrixStackDepth;
 
// this version will override the built-in version pushMatrix function
public void pushMatrix() {
  if (matrixStackDepth == 512) {
    throw new RuntimeException("too many calls to pushMatrix()");
  }
  this.g.getMatrix().get(matrixStack[matrixStackDepth]);
  matrixStackDepth++;
}
 
// this version will override the built-in version popMatrix function
public void popMatrix() {
  if (matrixStackDepth == 0) {
    throw new RuntimeException("too many calls to popMatrix()" +
                               "(or too few to pushMatrix)");
  }
  matrixStackDepth--;
  PMatrix2D m = new PMatrix2D();
  m.set(matrixStack[matrixStackDepth]);
  this.g.setMatrix(m);
}
