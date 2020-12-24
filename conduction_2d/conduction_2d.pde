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

void setup() {
  size(1200, 600);
  dx = width/n;
  tau = min(0.5, (alpha*dt)/(dx*dx));
  t = new float[n][2];
  in(t);
  setTemp(t, 20, 40, 200);
  setTemp(t, 60, 80, 500);
  pr(t);
  
}

void draw() {
  background(200);
  
  if(mousePressed) {
    solve(t);
  }  
  plot(t);
   
}


//int n = 100;
//float[] T, x, t;
//float tau, dx;
//float alpha = 100;
//float dt = 30;

//void setup() {
//  size(1200, 600);
//  dx = width/n;
//  tau = min(0.5, (alpha*dt)/(dx*dx));
//  T = new float[n];
//  x = new float[2];
//  t = new float[2];
//  x[0] = 60;
//  t[0] = 600;
//  x[1] = 25;
//  t[1] = 200;
//  in(T);
//  setTemp(T, 500);
//  insBoundary(T);
//  ctBoundary(T, 100, 200);
//  //frameRate(2);
//  //for (int i=1; i<T.length; i++) {
//  //  T[i] = 500;
//  //}
//}

//void draw() {
//  background(200);
//  //frameRate(int(map(mouseX, 0, width, 1, 240)));
//  solve(T, x, t);
//  //update(T);
//}
