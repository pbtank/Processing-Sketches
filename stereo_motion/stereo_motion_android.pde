//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import ketai.camera.*;

KetaiCamera cam;

int[] pointx, pointy;

float bright;
float maxb;

int th = 254;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 320, 240, 30);
  println(cam.list());
  cam.setCameraID(1);
  imageMode(CENTER);
  
  pointx = new int[width];
  pointy = new int[height];

}

void mousePressed() {
  if (cam.isStarted) {
    cam.stop();
  } else {
    cam.start();
  }
}

void draw() {
  background(200);
  
  cam.loadPixels();
  pushMatrix();
  scale(-1, 1);
  //image(cam, -width/2, height/2, width, height);
  popMatrix();
  
  int avgX = 0;
  int avgY = 0;
  float lavgX = 0;
  float lavgY = 0;
  
  int count = 0;
  
  for (int x = 0; x < cam.width; x++) {
    for (int y = 0; y < cam.height; y++) {
      int loc = x + y * cam.width;
      
      color currentColor = cam.pixels[loc];
      bright = brightness(currentColor);
      
      if (bright > th) {
        stroke(255);
        strokeWeight(1);
        point((width - x) * 4, y * 3);
        pointx[x] = (width - x) * 4;
        pointy[y] = y * 3;
        avgX += x * 4;
        avgY += y * 3;
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
    lavgX = lerp(lavgX, avgX, 0.1);
    lavgY = lerp(lavgY, avgY, 0.1);
    
    fill(0, 255, 255);
    strokeWeight(2);
    stroke(0);
    ellipse(width - lavgX, lavgY, 8, 8);
  }
  
  strokeWeight(1);
  fill(0);
  textAlign(RIGHT);
  textSize(18);
  text("brightness: " + maxb, width-20, 20);
  text("threshold: " + th, width-20, 40);
  
}

void onCameraPreviewEvent() {
  cam.read();
}
