//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

Pendulum p1;
Pendulum p2;

void setup () {
  size(640,360);
  
  p1 = new Pendulum (new PVector(width/2,0),175, PI/4);
  p2 = new Pendulum (new PVector(width/2,0),175, -PI/4);
  
}

void draw () {
  background(200);
  p1.go();
  p2.go();
}

void mousePressed() {
  p1.clicked(mouseX,mouseY);
  p2.clicked(mouseX,mouseY);
}

void mouseReleased() {
  p1.stopDragging();
  p2.stopDragging();
}
