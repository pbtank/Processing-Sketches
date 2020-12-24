//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import ketai.camera.*;

KetaiCamera cam;

color trackColorR;

float thresholdR;

//int[] rrectx;
//int[] rrecty;
//int[] brectx;
//int[] brecty;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 640, 360, 30);
  println(cam.list());
  // 0: back camera; 1: front camera
  cam.setCameraID(1);
  imageMode(CENTER);
  stroke(255);
  textSize(48);
  
  trackColorR = color(255, 0, 0);
  //trackColorB = color(0, 255, 0);
  
  //rrectx = new int[width];
  //rrecty = new int[height];
  //brectx = new int[width];
  //brecty = new int[height];
}

void draw() {
  background(128);
  
  if (!cam.isStarted())                                         // 1
  {
    pushStyle();                                                // 2
    textAlign(CENTER, CENTER);
    String info = "CameraInfo:\n";
    info += "current camera: "+ cam.getCameraID()+"\n";         // 3
    info += "image dimensions: "+ cam.width +                   // 4
      "x"+cam.height+"\n";                                      // 5
    info += "photo dimensions: "+ cam.getPhotoWidth() +         // 6
      "x"+cam.getPhotoHeight()+"\n";                            // 7
    //info += "flash state: "+ cam.isFlashEnabled()+"\n";         // 8
    text(info, width/2, height/2);
    popStyle();                                                 // 9
  }
  else
  {
    pushMatrix();
    scale(-1, 1);
    image(cam, -width/2, height/2, width, height);
    popMatrix();
  }
  drawUI();
  
  cam.loadPixels();
  
  thresholdR = map(mouseX, 0, width, 0, 200);
  
  int avgXR = 0;
  int avgYR = 0;
  //int avgXB = 0;
  //int avgYB = 0;
  
  int countR = 0;
  //int countB = 0;
  
  for (int x = 0; x < cam.width; x += 5) {
    for (int y = 0; y < cam.height; y += 5) {
      int loc = x + y * cam.width;
      
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColorR);
      float g2 = green(trackColorR);
      float b2 = blue(trackColorR);
      //float r3 = red(trackColorB);
      //float g3 = green(trackColorB);
      //float b3 = blue(trackColorB);
      
      float dR = distsq(r1, g1, b1, r2, g2, b2);
      //float dB = distsq(r1, g1, b1, r3, g3, b3);
      
      if (dR < thresholdR*thresholdR) {
        stroke(255);
        strokeWeight(1);
        point(width - (2*x),2*y);
        //rrectx[x] = width - x;
        //rrecty[y] = y;
        avgXR += x;
        avgYR += y;
        countR++;
      }
      
      //if (dB < thresholdB*thresholdB) {
      //  stroke(255);
      //  strokeWeight(1);
      //  point(width - x,y);
      //  brectx[x] = width - x;
      //  brecty[y] = y;
      //  avgXB += x;
      //  avgYB += y;
      //  countB++;
      //}
    }
  }
  
  if (countR > 0) {
    avgXR = avgXR / countR;
    avgYR = avgYR / countR;
    //avgXB = avgXB / countB;
    //avgYB = avgYB / countB;
    
    fill(trackColorR);
    strokeWeight(2);
    stroke(0);
    ellipse(width-(2*avgXR), 2*avgYR, 8, 8);
    //println(-avgXR, avgYR);
    println(thresholdR);
  }
}

float distsq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
  return d;
}
