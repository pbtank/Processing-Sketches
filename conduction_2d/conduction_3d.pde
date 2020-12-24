//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

int n = 100;
float[][] t;
float tau, dx;
float alpha = 100;
float dt = 1;

float rotX, rotY, rotZ = 0;

void setup() {
  size(1200, 600, P3D);
  dx = width/n;
  tau = min(0.5, (alpha*dt)/(dx*dx));
  t = new float[n][2];
  in(t);
  setTemp(t, 20, 40, 200);
  setTemp(t, 60, 80, 500);
  pr(t);
  
}

void keyPressed() {
  if (key == CODED) {
    if (key == 'U') {
      rotX += 10;
    }
  }
}

void draw() {
  background(200);
  translate(0,0,-200);
  rotateX(radians(rotX));
  rotateY(radians(rotY));
  rotateZ(radians(rotZ));
  
  if(mousePressed) {
    solve(t);
  }  
  plot(t);
   
}
