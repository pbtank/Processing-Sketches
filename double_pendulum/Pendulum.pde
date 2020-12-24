class Pendulum {
  
  PVector position;
  PVector origin;
  float r;
  float angle;
  float aVelocity;
  float aAcceleration;
  
  float ballr;
  float damping;
  
  boolean dragging = false;
  
  Pendulum(PVector origin_, float r_, float angle_) {
    
    origin = origin_.get();
    position = new PVector();
    r = r_;
    angle = angle_;
    
    aVelocity = 0.0;
    aAcceleration = 0.0;
    damping = 0.995;
    ballr = 48.0;
  }
  
  void go() {
    update();
    drag();
    display();
  }
  
  void update() {
    if (!dragging) {
      float gravity = 0.4;
      aAcceleration = (-gravity / r) * sin(angle);
      aVelocity += aAcceleration;
      aVelocity *= damping;
      angle += aVelocity;
    }
  }
  
  void display() {
    position.set(r*sin(angle), r*cos(angle), 0);
    position.add(origin);
    
    stroke(0);
    strokeWeight(2);
    line(origin.x, origin.y, position.x, position.y);
    ellipseMode(CENTER);
    fill(175);
    if (dragging) fill(0);
    ellipse(position.x, position.y, ballr, ballr);
  }
  
  void clicked(int mx, int my) {
    float d = dist(mx, my, position.x, position.y);
    if (d < ballr) {
      dragging = true;
    }
  }
  
  void stopDragging() {
    aVelocity = 0;
    dragging = false; 
  }
  
  void drag() {
    if (dragging) {
      PVector diff = PVector.sub(origin, new PVector(mouseX, mouseY));
      angle = atan2(-diff.y, diff.x) - radians(90);
    }
  }
}
