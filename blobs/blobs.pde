//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import processing.video.*;

import java.awt.AWTException;
import java.awt.Robot;
//int xx = 10, yy = 10;
Robot robby;

Capture video;

color trackColorR;
color trackColorB;

float thresholdR = 25;
float thresholdB = 25;
//int button = InputEvent.BUTTON1_MASK;

void setup() {
  size(640,360);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[4]);
  video.start();
  trackColorR = color(255, 0, 0);
  trackColorB = color(0, 0, 255);
  
  try
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Robot class not supported by your system!");
    exit();
  }
  
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  video.loadPixels();
  pushMatrix();
  scale(-1, 1);
  image(video, -width, 0);
  popMatrix();
  
  //threshold = map(mouseX, 0, width, 0, 200);
  thresholdR = 140;
  thresholdB = 20;
  
  int avgXR = 0;
  int avgYR = 0;
  int avgXB = 0;
  int avgYB = 0;
  
  int countR = 0;
  int countB = 0;
  
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int loc = x + y * video.width;
      
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColorR);
      float g2 = green(trackColorR);
      float b2 = blue(trackColorR);
      float r3 = red(trackColorB);
      float g3 = green(trackColorB);
      float b3 = blue(trackColorB);
      
      float dR = distsq(r1, g1, b1, r2, g2, b2);
      float dB = distsq(r1, g1, b1, r3, g3, b3);
      
      if (dR < thresholdR*thresholdR) {
        stroke(255);
        strokeWeight(1);
        point(width - x,y);
        avgXR += x;
        avgYR += y;
        countR++;
      }
      
      if (dB < thresholdB*thresholdB) {
        stroke(255);
        strokeWeight(1);
        point(width - x,y);
        avgXB += x;
        avgYB += y;
        countB++;
      }
    }
  }

  if (countR > 0 || countB > 1) {
    avgXR = avgXR / countR;
    avgYR = avgYR / countR;
    //avgXB = avgXB / countB;
    //avgYB = avgYB / countB;
    
    fill(trackColorR);
    strokeWeight(2);
    stroke(0);
    ellipse(width - avgXR, avgYR, 8, 8);
    fill(trackColorB);
    ellipse(width - avgXB, avgYB, 8, 8);
    
    rectMode(CENTER);
    noFill();
    stroke(trackColorR);
    rect(width - avgXR, avgYR, 36, 36);
    stroke(trackColorB);
    rect(width - avgXB, avgYB, 36, 36);
    
    float xx = map(avgXR, 0, width, -600, displayWidth+600);
    float yy = map(avgYR, 0, height, -600, displayHeight+600);
    int XX = int(xx);
    int YY = int(yy);
    robby.mouseMove(displayWidth - XX, YY);
    //if (keyPressed) {robby.mousePress(button);}
  }
}

float distsq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
  return d;
}

void mousePressed() {
  int loc = mouseX + mouseY*video.width;
  trackColorB = video.pixels[loc];
}

