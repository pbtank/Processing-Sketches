//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import ketai.sensors.*;
KetaiSensor sensor;
PVector accelerometer = new PVector();
PVector pAccelerometer = new PVector();

void setup()  {
  sensor = new KetaiSensor(this);
  sensor.start();
  //sensor.list();
  orientation(PORTRAIT);                       // 1
  textAlign(CENTER, CENTER);
  textSize(72);
}
void draw()
{
  background(78, 93, 75);
  float delta = PVector.angleBetween(accelerometer, pAccelerometer);
  
  if (degrees(delta) > 45) {
    text("IT'S" + "\n"
          + "VERY" + "\n"
          + "SHAKY !", width/2, height/2);
  }
  
  pAccelerometer.set(accelerometer);
}

void onAccelerometerEvent(float x, float y, float z)
{
  accelerometer.x = x;                                  // 7
  accelerometer.y = y;
  accelerometer.z = z;
}
