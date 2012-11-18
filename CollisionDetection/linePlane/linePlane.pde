
/*
LINE/PLANE COLLISION - 3d
 Jeff Thompson
 
 Line to plane collision in 3d.  Use mouse to rotate view, arrow
 keys to move the line and watch the results!
 
 Based on examples from:
 http://gmc.yoyogames.com/index.php?showtopic=501626
 
 www.jeffreythompson.org
 */

// end of line (changed with arrow keys)
float lx, ly, lz;

// intersection points - start at 0
float sx = 0;
float sy = 0;
float sz = 0;

// rotation variables (grab with mouse to move)
float rotX = -5.0;
float rotY = -12.0;


void setup() {
  size(400, 400, P3D);
  smooth();

  lx = width;
  ly = height; 
  lz = width;

  // three points on the plane, followed by ends of the line
  intersect(0, height/2, 0, width, height/2, 0, 0, height/2, width, 0, 0, 0, lx, ly, lz);

  // print result
  println("Intersection: " + sx + ", " + sy + ", " + sz);
}

void draw() {
  background(32);
  lights();

  rotateX(rotY);
  rotateY(rotX);

  // draw the plane
  fill(255, 150, 0);
  noStroke();
  beginShape();
  vertex(0, height/2, 0);
  vertex(0, height/2, width);
  vertex(width, height/2, width);
  vertex(width, height/2, 0);
  endShape(CLOSE);

  // draw the line
  stroke(255);
  strokeWeight(2);
  line(0,0,0, lx,ly,lz);
  strokeWeight(1);

  // draw a dot at the intersection point!
  fill(255, 0, 0);
  noStroke();
  pushMatrix();
  translate(sx, sy, sz);
  sphere(5);
  popMatrix();
}

// arrow keys move the end of the line
void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      lx += 10;
    }
    else if (keyCode == LEFT) {
      lx -= 10;
    }
    else if (keyCode == UP) {
      lz -= 10;
    }
    else if (keyCode == DOWN) {
      lz += 10;
    }
  }
}

// on release, check intersection again and print the result!
void keyReleased() {
  if (key == CODED) {
    intersect(0, height/2, 0, width, height/2, 0, 0, height/2, width, 0, 0, 0, lx, ly, lz);
    println("Intersection: " + sx + ", " + sy + ", " + sz);
  }
}

// mouse moves your view
void mouseDragged() {
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}

// three points on the plane, followed by ends of the line (x,y,z)
void intersect(float ax, float ay, float az, float bx, float by, float bz, float cx, float cy, float cz, float px, float py, float pz, float qx, float qy, float qz) {

  // vector from A to C
  float ex = cx-ax;
  float ey = cy-ay;
  float ez = cz-az;

  // vector from A to B
  float fx = bx-ax;
  float fy = by-ay;
  float fz = bz-az;

  // cross product of E and F
  float nx = fy*ez-fz*ey;
  float ny = fz*ex-fx*ez;
  float nz = fx*ey-fy*ex;

  // normalize
  float m = sqrt(nx*nx+ny*ny+nz*nz);
  nx /= m;
  ny /= m;
  nz /= m;

  //get ray direction vector
  float dx = qx-px;
  float dy = qy-py;
  float dz = qz-pz;

  m = sqrt(dx*dx+dy*dy+dz*dz);
  dx /= m;
  dy /= m;
  dz /= m;

  // dot product of ray and normal
  // this tells us if the ray is pointing towards the plane
  m = dx*nx + dy*ny + dz*nz;

  // less than 0 means the vectors are opposed
  // more than 0 means the vectors point the same way
  // equal to 0 means they are perpendicular
  if (m < 0) {

    // get the vector from the ray to point A on the plane
    float gx = ax-px;
    float gy = ay-py;
    float gz = az-pz;

    // dot product of G and plane normal
    float t = gx*nx+gy*ny+gz*nz;

    // if we are on non-culled side of the plane
    if (t < 0) {
      // get distance to plane by dividing the two dot products
      float k = t/m;

      // find the point of intersection on the plane, return result
      sx = px+dx*k;
      sy = py+dy*k;
      sz = pz+dz*k;
    }
  }
}
