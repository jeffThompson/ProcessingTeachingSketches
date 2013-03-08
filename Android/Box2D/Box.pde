
class Box {
  
  Body body;
  float w, h;
  color c;
  
  Box (float x, float y, color _c) {
    w = random(8, 16);
    h = random(8, 16);
    c = _c;
    makeBody(new Vec2(x,y), w,h);
  }
  
  void makeBody(Vec2 center, float w_, float h_) {
    
    // define a polygon (ie: rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    
    // parameters that affect physics
    fd.density = 1;
    fd.friction = 1.0;        // high friction
    fd.restitution = 0.01;    // very low bounce

    // define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    // give it some initial random velocity
    body.setLinearVelocity(new Vec2(0, random(2, 5)));    // straight down
    body.setAngularVelocity(random(-5, 5));               // random spin
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
  
  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      killBody();
      return true;
    }
    return false;
  }
  
  void applyForce(Vec2 force) {
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);                  // P5 is clockwise, Box2D is counter - we flip here
    
    fill(c);
    noStroke();
    rect(0,0, w, h);
    popMatrix();
  }
}
