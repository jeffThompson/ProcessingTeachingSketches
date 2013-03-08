
class Surface {

  float ctrX, ctrY;
  float w, h;
  float rotationSpeed;
  Body body;
  RevoluteJoint joint;
  MouseJoint mouseJoint;
  color c;

  Surface (float _ctrX, float _ctrY, float _w, float _h, float _rotationSpeed, float restitution, color _c) {
    ctrX = _ctrX;
    ctrY = _ctrY;
    w = _w;
    h = _h;  
    rotationSpeed = _rotationSpeed;
    c = _c;

    Vec2 center = new Vec2(ctrX, ctrY);
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(_w/2);
    float box2dH = box2d.scalarPixelsToWorld(_h/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.restitution = restitution;      // once high bounce, one low
    fd.shape = sd;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    body.setAngularVelocity(rotationSpeed);

    // add revolute joint
    RevoluteJointDef rev = new RevoluteJointDef();
    Body world = box2d.getGroundBody();
    rev.initialize(body, world, world.getWorldCenter());
    rev.motorSpeed = rotationSpeed;
    rev.enableMotor = true;
    joint = (RevoluteJoint) box2d.world.createJoint(rev);

    /*MouseJointDef md = new MouseJointDef();
     md.bodyA = box2d.getGroundBody();
     md.bodyB = body;
     md.maxForce = 2000;
     mouseJoint = (MouseJoint) box2d.world.createJoint(md);*/
  }

  void update() {
    // Vec2 mouseCoords = box2d.coordPixelsToWorld(mouseX, mouseY);
    // mouseJoint.setTarget(mouseCoords);
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
    rect(0, 0, w, h);
    popMatrix();
  }
}

