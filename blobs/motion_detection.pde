//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import processing.video.*;

Capture video;
PImage prev; 

float threshold = 25;

  float motionX = 0;
  float motionY = 0;
  
  float lerpX = 0;
  float lerpY = 0;

void setup() {
  size(640,360);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[3]);
  video.start();
  prev = createImage(640, 360, RGB);
}

void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void draw() {
  video.loadPixels();
  prev.loadPixels();
  image(video, 0, 0);
  
  //threshold = map(mouseX, 0, width, 0, 200);
  threshold = 50;
  
  int count = 0;
  
  float avgX = 0;
  float avgY = 0;
  
  loadPixels();
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int loc = x + y * video.width;
      
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      color prevColor = prev.pixels[loc];
      float r2 = red(prevColor);
      float g2 = green(prevColor);
      float b2 = blue(prevColor);
      
      float d = distsq(r1, g1, b1, r2, g2, b2);
      
      if (d > threshold*threshold) {
        //stroke(255);
        //strokeWeight(1);
        //point(x,y);
        avgX += x;
        avgY += y;
        count++;
        pixels[loc] = color(255);
      } else {
        pixels[loc] = color(0);
      }
    }
  }
  updatePixels();
  
  if (count > 100) {
    motionX = avgX / count;
    motionY = avgY / count;
    
  }
  
    lerpX = lerp(lerpX, motionX, 0.1);
    lerpY = lerp(lerpY, motionY, 0.1);
    
    fill(255, 0, 255);
    strokeWeight(2);
    stroke(0);
    ellipse(lerpX, lerpY, 36, 36);
}

float distsq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
  return d;
}

