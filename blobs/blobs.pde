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

float thresholdR = 140;
float thresholdB = 175;
float distThreshold = 25;

ArrayList<Blob> Rblobs = new ArrayList<Blob>();
ArrayList<Blob> Bblobs = new ArrayList<Blob>();

//int button = InputEvent.BUTTON1_MASK;

void setup() {
  size(1280,720);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[8]);
  video.start();
  trackColorR = color(255, 0, 0);
  trackColorB = color(0, 255, 0);
  
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
  
  Rblobs.clear();
  Bblobs.clear();
  
  //threshold = map(mouseX, 0, width, 0, 200);
  //threshold = 140;
    
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
      
      if (dR < thresholdR * thresholdR) {
        
        boolean rfound = false;
        for (Blob bR : Rblobs) {
          if (bR.isNear(x, y)) {
            bR.add(x, y);
            rfound = true;
            break;
          }
        }
        
        if (!rfound) {
          Blob bR = new Blob(x, y);
          Rblobs.add(bR);
        }
      }
      
      if (dB < thresholdB * thresholdB) {
        
        boolean bfound = false;
        for (Blob bB : Bblobs) {
          if (bB.isNear(x, y)) {
            bB.add(x, y);
            bfound = true;
            break;
          }
        }
        
        if (!bfound) {
          Blob bB = new Blob(x, y);
          Bblobs.add(bB);
        }
      } 
    }
  }
  
  for (Blob bR : Rblobs) {
    if (bR.size() > 500) {
      fill(trackColorR, 150);
      bR.show();
      ellipse (width - bR.rectx(), bR.recty(), 8, 8);
    }
  }
  //ellipse (width - bR.rectx(), bR.recty(), 8, 8);
  
  for (Blob bB : Bblobs) {
    if (bB.size() > 500) {
      fill(trackColorB, 150);
      bB.show();
      ellipse (width - bB.rectx(), bB.recty(), 8, 8);
    }
  }
  

  //if (count > 0) {
  //  avgX = avgX / count;
  //  avgY = avgY / count;
 
    
  //  fill(trackColor);
  //  strokeWeight(2);
  //  stroke(0);
  //  ellipse(width - avgX, avgY, 16, 16);
    
    //rectMode(CENTER);
    //noFill();
    //stroke(trackColor);
    //rect(width - avgX, avgY, 36, 36);
    
    //float xx = map(avgX, 0, width, -600, displayWidth+600);
    //float yy = map(avgY, 0, height, -600, displayHeight+600);
    //int XX = int(xx);
    //int YY = int(yy);
    //robby.mouseMove(displayWidth - XX, YY);
    //if (keyPressed) {robby.mousePress(button);}
  //}
  
  strokeWeight(1);
  fill(0);
  textAlign(RIGHT);
  textSize(18);
  text("distance threshold:" + distThreshold , width-20, 20);
  text("color r threshold:" + thresholdR , width-20, 40);
  text("color b threshold:" + thresholdB , width-20, 60);
}

float distsq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}

float distsq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
  return d;
}

//void mousePressed() {
//  int loc = mouseX + mouseY*video.width;
//  trackColor = video.pixels[loc];
//}

