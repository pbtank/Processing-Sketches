//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import ketai.camera.*;

//import java.awt.AWTException;
//import java.awt.Robot;
//int xx = 10, yy = 10;
//Robot robby;

KetaiCamera video;

color trackColorR;
color trackColorB;

float thresholdR = 140;
float thresholdB = 175;
float distThreshold = 25;

float Rsize;
float Bsize;

float Rrotx;
float Brotx;
float Rroty;
float Broty;

float Ztheta;
float ltheta = 0;
float dscale;
float Ytheta;

ArrayList<Blob> Rblobs = new ArrayList<Blob>();
ArrayList<Blob> Bblobs = new ArrayList<Blob>();

//int button = InputEvent.BUTTON1_MASK;

void setup() {
  orientation(LANDSCAPE);
  size(1280,720, P3D);
  //String[] cameras = Capture.list();
  //printArray(cameras);
  video = new KetaiCamera(this, 1280, 720, 30);
  println(video.list());
  video.setCameraID(0);                                         // 2
  imageMode(CENTER);
  video.start();
  trackColorR = color(255, 0, 0);
  trackColorB = color(0, 255, 0);
  
  //try
  //{
  //  robby = new Robot();
  //}
  //catch (AWTException e)
  //{
  //  println("Robot class not supported by your system!");
  //  exit();
  //}
  
}

void captureEvent(KetaiCamera video) {
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
  //background(200);
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
    if (bR.size() > 5000) {
      Rsize = map(bR.size(), bR.size() - 5000, width*10, 0, height*0.5);
      fill(trackColorR, 150);
      bR.show();
      Rroty = bR.recty();
      Rrotx = width - bR.rectx(); 
      ellipse (width - bR.rectx(), bR.recty(), 8, 8);
    }
  }
  //ellipse (width - bR.rectx(), bR.recty(), 8, 8);
  
  for (Blob bB : Bblobs) {
    if (bB.size() > 5000) {
      Bsize = map(bB.size(), bB.size() - 5000, width*10, 0, height*0.5);
      fill(trackColorB, 150);
      bB.show();
      Broty = bB.recty();
      Brotx = width - bB.rectx();
      ellipse (width - bB.rectx(), bB.recty(), 8, 8);
    }
  }
  
////////////////////rotation/////////////////////////
  
  line(Rrotx, Rroty, Brotx, Broty);
  pushMatrix();
  translate((Rrotx + Brotx)/2, (Rroty + Broty)/2);
  Ztheta = atan2(Broty - (Rroty + Broty)/2, Brotx - (Rrotx + Brotx)/2);
  ltheta = lerp(ltheta, map(Ztheta, 0, PI, 0, 2*PI), 1);
  popMatrix();
  
////////////////////rotation////////////////////////////////
  

////////////////////scale////////////////////////////////

  dscale = map(dist(Brotx, Broty, Rrotx, Rroty), 0, width*0.6, 0, 2);

////////////////////scale////////////////////////////////

////////////////////Yrotation////////////////////////////////

  Ytheta = atan2(Bsize - Rsize, width*0.5);

////////////////////Yrotation////////////////////////////////


///////////////////////////3D/////////////////////////////////

  pushMatrix();
  translate(width/2, height/2, 250);
  rotateX(-PI/6);
  rotateZ(Ztheta);
  rotateY(Ytheta);
  scale(dscale);
  fill(0, 255, 0, 150);
  rectMode(CENTER);
  box(150);
  stroke(0, 0, 255);
  fill(0, 0, 255);
  text("TANK", 0, 0, 150/2+1);
  translate(0, -150/2, 0);
  fill(255, 0, 0, 150);
  sphere(150/2);
  //line(0, 0, 0, 150);
  popMatrix();
  
///////////////////////////3D/////////////////////////////////
  
  strokeWeight(1);
  fill(0);
  textAlign(RIGHT);
  textSize(18);
  text("distance threshold:" + distThreshold , width-20, 20);
  text("color r threshold:" + thresholdR , width-20, 40);
  text("color b threshold:" + thresholdB , width-20, 60);
  text("Rsize:" + Rsize , width-20, 80);
  text("Bsize:" + Bsize , width-20, 100);
  //text("theta:" + theta , width-20, 120);
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
