//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

int n = 100;
int[] h;
float d = 10;

void setup() {
  size(1200,600);
  h = new int[n];
  for (int i=0; i<h.length; i++) {
    h[i] = 0;
  }
  
  //println(h);
}

void draw() {
  background(200);
  //frameRate(1);
  frameRate(int(map(mouseX, 0, width, 1, 240)));
  
  stroke(0);
  strokeWeight(2);
  rectMode(CORNERS);
  textSize(25);
  
  text(frameRate,200,50);
  
  int b = 50;
  for (int i = 0; i<h.length; i++) {
    text(h[i],100,b);
    text(h.length,150,b);
    b+=25;
  }

  int r = int(random(1, n+1));
  text(r,50,50);
  
  float dx = width/n;
  
  for (int i=0; i<h.length; i++) {
  
  if (i == r-1) {
    fill(41, 144, 193);
    h[i] += int(d);
    rect(i*dx, height, (i+1)*dx, height - h[i], 5, 5, 0, 0);
  } else {
    fill(340, 94, 96);
    rect(i*dx, height, (i+1)*dx, height - h[i], 5, 5, 0, 0);
    }
  }
  
  for (int i=0; i<h.length; i++) {
    if (h[i] >= height) {
      for (int n=0; n<h.length; n++) {
        h[n] = h[n]/2;
      }
      d = d/2;
    }
  }
  
  text(d,300,50);
}

void mousePressed() {
  noLoop();
}

void mouseReleased() {
  loop();
}
