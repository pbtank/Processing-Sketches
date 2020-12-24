//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import processing.video.*;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.*;
//int xx = 10, yy = 10;
Robot robby;

Capture video;

color trackColorR;
color trackColorB;

float distThreshold = 30;
float thresholdR = 140;
float thresholdB = 180;
int mask = InputEvent.BUTTON1_DOWN_MASK;

float lxx = 0;
float lyy = 0;

int[] rrectx;
int[] rrecty;
int[] brectx;
int[] brecty;

void setup() {
  size(1280,720);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[8]);
  video.start();
  trackColorR = color(255, 0, 0);
  trackColorB = color(0, 255, 0);
  
  rrectx = new int[width];
  rrecty = new int[height];
  brectx = new int[width];
  brecty = new int[height];
  
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

void keyPressed() {
  if (key == 'a') {
    distThreshold+=5;
  } else if (key == 'z') {
    distThreshold-=5;
  }
   if (key == 's') {
    thresholdR+=5;
  } else if (key == 'x') {
    thresholdR-=5;
  }
    if (key == 'd') {
    thresholdB+=5;
  } else if (key == 'c') {
    thresholdB-=5;
  }
}

void draw() {
  video.loadPixels();
  pushMatrix();
  scale(-1, 1);
  image(video, -width, 0);
  popMatrix();
  
  //thresholdB = map(mouseX, 0, width, 0, 200);
  //thresholdR = 140;
  //thresholdB = 200;
  
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
        rrectx[x] = width - x;
        rrecty[y] = y;
        avgXR += x;
        avgYR += y;
        countR++;
      }
      
      if (dB < thresholdB*thresholdB) {
        stroke(255);
        strokeWeight(1);
        point(width - x,y);
        brectx[x] = width - x;
        brecty[y] = y;
        avgXB += x;
        avgYB += y;
        countB++;
      }
    }
  }

  if (countR > 1 && countB > 1) {
    avgXR = avgXR / countR;
    avgYR = avgYR / countR;
    avgXB = avgXB / countB;
    avgYB = avgYB / countB;

    float xx = map((avgXR + avgXB) / 2, 0, width, -600, displayWidth+600);
    float yy = map((avgYR + avgYB) / 2, 0, height, -600, displayHeight+600);
    lxx = lerp(lxx, xx, 0.1);
    lyy = lerp(lyy, yy, 0.1);
    int XX = int(lxx);
    int YY = int(lyy);
    
    
    if (dist(avgXR, avgYR, avgXB, avgYB) < distThreshold) {
      stroke(255, 255, 0);
      strokeWeight(2);
      noFill();
      rectMode(CENTER);
      rect(width - ((avgXR + avgXB) / 2), (avgYR + avgYB) / 2, 32, 64);
      stroke(0, 255, 255);
      ellipse(width - ((avgXR + avgXB) / 2), (avgYR + avgYB) / 2, 45, 45);
      
      robby.mouseMove(displayWidth - XX, YY);
      robby.mousePress(mask);
  } else {
    
    robby.mouseRelease(mask);
    
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
    
    stroke(0, 255, 255);
    line(width - avgXR, avgYR, width - avgXB, avgYB);
    ellipse(width - ((avgXR + avgXB) / 2), (avgYR + avgYB) / 2, 5, 5);
    
    robby.mouseMove(displayWidth - XX, YY);
    }
  }
  
  strokeWeight(1);
  fill(0);
  textAlign(RIGHT);
  textSize(18);
  text("distance threshold:" + distThreshold , width-20, 20);
  text("color r threshold:" + thresholdR , width-20, 40);
  text("color b threshold:" + thresholdB , width-20, 60);
}

float distsq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
  return d;
}

//void mousePressed() {
//  int loc = mouseX + mouseY*video.width;
//  trackColorB = video.pixels[loc];
//}
