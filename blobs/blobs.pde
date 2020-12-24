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

color trackColor;

float threshold = 25;
float distThreshold = 25;

ArrayList<Blob> blobs = new ArrayList<Blob>();

//int button = InputEvent.BUTTON1_MASK;

void setup() {
  size(640,360);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[3]);
  video.start();
  trackColor = color(255, 0, 0);
  
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
    distThreshold++;
  } else if (key == 'z') {
    distThreshold--;
  }
  println(distThreshold);
}

void draw() {
  video.loadPixels();
  pushMatrix();
  scale(-1, 1);
  image(video, -width, 0);
  popMatrix();
  
  blobs.clear();
  
  //threshold = map(mouseX, 0, width, 0, 200);
  threshold = 140;
    
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int loc = x + y * video.width;
      
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);
      
      float d = distsq(r1, g1, b1, r2, g2, b2);
      
      if (d < threshold*threshold) {
        
        boolean found = false;
        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }
        
        if (!found) {
          Blob b = new Blob(x, y);
          blobs.add(b);
        }
      } 
    }
  }
  
  for (Blob b : blobs) {
    if (b.size() > 500) {
      b.show();
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
}

float distsq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}

float distsq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
  return d;
}

void mousePressed() {
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}
