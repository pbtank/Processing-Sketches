//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import processing.video.*;

Capture video;

int[] pointx, pointy;

float bright;
float maxb;

int th = 200;

void setup() {
  size(1280, 720);
  String[] cameras= Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[8]);
  video.start();
  
  pointx = new int[width];
  pointy = new int[height];

}

void captureEvent(Capture video) {
  video.read();
}

void keyPressed() {
  if (key == 'q') {
    if (th < 255) {
      th += 1;
    }
  } else if (key == 'a') {
    if (th > 200) {
      th -= 1;
    }
  }
}

void draw() {
  background(200);
  video.loadPixels();
  pushMatrix();
  scale(-1,1);
  //image(video, -width, 0);
  popMatrix();
  
  int avgX = 0;
  int avgY = 0;
  
  int count = 0;
  
  for (int x = 0; x < video.width; x += 2) {
    for (int y = 0; y < video.height; y += 2) {
      int loc = x + y * video.width;
      
      color currentColor = video.pixels[loc];
      bright = brightness(currentColor);
      
      if (bright > th) {
        stroke(255);
        strokeWeight(1);
        point(width - x, y);
        pointx[x] = width - x;
        pointy[y] = y;
        avgX += x;
        avgY += y;
        count++;
        
        if (bright > maxb) {
          maxb = bright;
        }
      }
    }
  }
  
  if (count > 1) {
    avgX = avgX / count;
    avgY = avgY / count;
    
    fill(0, 255, 255);
    strokeWeight(2);
    stroke(0);
    ellipse(width - avgX, avgY, 8, 8);
  }
  
  strokeWeight(1);
  fill(0);
  textAlign(RIGHT);
  textSize(18);
  text("brightness: " + maxb, width-20, 20);
  text("threshold: " + th, width-20, 40);
  
}
