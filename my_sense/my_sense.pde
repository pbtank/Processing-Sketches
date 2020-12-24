//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import ketai.sensors.*;
KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ;
float velx = 0;
float vely = 0;
float px = displayWidth/2;
float py = displayHeight/2;

void setup()  {
  sensor = new KetaiSensor(this);
  sensor.start();
  //sensor.list();
  orientation(PORTRAIT);                       // 1
  //textAlign(CENTER, CENTER);
  //textSize(72);
}
void draw()
{
  background(200);
  stroke(0);
  fill(0);
  ellipse(px,py,50,50);
  
  //px += int(accelerometerX)*-1; 
  //py += int(accelerometerY); 
  
  if (px > displayWidth) {
    px = displayWidth;
  } else if (px < 0) {
    px = 0;
  } else {
    velx += (int(accelerometerX)*100)*-1;
    px += velx;
  }
  
  if (py > displayHeight) {
    py = displayHeight;
  } else if (py < 0) {
    py = 0;
  } else {
    vely += (int(accelerometerY)*100);
    py += vely;
  }
  
  println(px);
  println(py);
  println(accelerometerX*100);
  println(accelerometerY*100);
  
  //pAccelerometer.set(accelerometer);
}

void onLinearAccelerationEvent(float x, float y, float z)
{
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}
