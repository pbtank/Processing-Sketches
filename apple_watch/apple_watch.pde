//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

float s;
float m;
float h;

void setup () {
  size(600,600);
  background(0);
  frameRate(10000);
}

void draw () {
  float px=width/2+200*cos(s);
  float py=height/2+200*sin(s);
  float cx=width/2+150*cos(m);
  float cy=height/2+150*sin(m);
  float bx=width/2+100*cos(h);
  float by=height/2+100*sin(h);
  
  fill(#FF08AD);
  stroke(#FF08AD);
  ellipse(px,py,20,20);
  
  fill(#08F9FF);
  stroke(#08F9FF);
  ellipse(cx,cy,20,20);
  
  fill(#1300F0);
  stroke(#1300F0);
  ellipse(bx,by,20,20);
  
  s+=(2*PI)/(3600);
  m+=(2*PI)/(3600*2);
  h+=(2*PI)/(3600*4);
  
  if (s>2*PI) {
  s=0;
  background(0);
  
  }
  
 
}
