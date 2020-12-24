float time=0;
float[] path;
float[] x;
float fourierx;
//float alpha=0;


void setup() {
frameRate(30);
//zoom=createSlider(1,25,1);
// translate(windowWidth/2,windowHeight/2);

    float centerx = max(drawing.x);
    println(centerx);

  for (int i = 0; i < drawing.length; i++) {
    float c=new Complex((drawing[i].x*zoom.value())-350,(drawing[i].y*zoom.value())-430);
    x[i]=(c);
    }

    fourierX=dft(x);

    println(fourierX);

    fourierX.sort((a,b)=>b.amp-a.amp); //<>//

}

void epicycles(float x, float y ,float rotation, float fourier) {

  for(int i=0;i<fourierX.length-500;i++) {
  float prevx=x;
  float prevy=y;

  float freq=fourier[i].freq;
  float radius=fourier[i].amp;
  float phase=fourier[i].phase;

  stroke(185,255,244,20);
  noFill();
  ellipse(prevx,prevy,radius*2);
  fill(255);

  x+=radius*cos(freq*time+phase+rotation);
  y+=radius*sin(freq*time+phase+rotation);
  
  stroke(185,255,244,100);
  fill(255);
  // ellipse(x,y,5);
  line(prevx,prevy,x,y);
  point(x,y);
  }

  return createVector(x,y);
}


void draw() {
  background(0); //<>//
  stroke(255);
  text(frameCount,25,25);
  // textSize(22);
  // stroke(255);
  // text(max(drawing.x),200,200);

  // translate(-drawing[frameCount].x*zoom.value(),-drawing[frameCount].y*zoom.value());

float v=epicycles(windowWidth/2,windowHeight/2,0,fourierX);

path.push(v);

beginShape();
noFill();
stroke(255,255,0);
  for (float i = 0; i < path.length; i++) {
    // stroke(0,255-alpha);
    vertex(path[i].x,path[i].y);
    // alpha+=0.007;
  }
endShape();

  float dt=2*PI/fourierX.length;
  time+=dt;
  
  if (time>2*PI) {
    time=0;
    frameCount=0;
    // alpha=0;
    path=[];
  }  
}
