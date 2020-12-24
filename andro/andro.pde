//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

float x = 0;

void setup() {
  fullScreen();
}

void draw() {
  background(200);
  stroke(0);
  line(x,0,x,height);
  if (x > width) {
    x = 0;
  }
  x++;
}
