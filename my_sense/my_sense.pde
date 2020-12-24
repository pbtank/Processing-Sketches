//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import ketai.sensors.*;
KetaiSensor sensor;
PVector magneticField, accelerometer, rotation;
float light, proximity;

void setup()  {
  sensor = new KetaiSensor(this);
  sensor.start();
  sensor.list();
  accelerometer = new PVector();
  magneticField = new PVector();
  rotation = new PVector();
  orientation(PORTRAIT);                       // 1
  textAlign(CENTER, CENTER);
  textSize(72);
}
void draw()
{
  background(78, 93, 75);
  text("Accelerometer :" + "\n"
    + "x: " + nfp(accelerometer.x, 1, 2) + "\n"
    + "y: " + nfp(accelerometer.y, 1, 2) + "\n"
    + "z: " + nfp(accelerometer.z, 1, 2) + "\n"
    + "MagneticField :" + "\n"
    + "x: " + nfp(magneticField.x, 1, 2) + "\n"
    + "y: " + nfp(magneticField.y, 1, 2) + "\n"
    + "z: " + nfp(magneticField.z, 1, 2) + "\n"
    + "Gyroscope :" + "\n"
    + "x: " + nfp(rotation.x, 1, 2) + "\n"
    + "y: " + nfp(rotation.y, 1, 2) + "\n"
    + "z: " + nfp(rotation.z, 1, 2) + "\n"
    + "Light Sensor : " + light + "\n"
    + "Proximity Sensor : " + proximity + "\n"
    , 20, 0, width, height);
}

void onAccelerometerEvent(float x, float y, float z, long time, int accuracy)
{
  accelerometer.set(x, y, z);
}
void onMagneticFieldEvent(float x, float y, float z, long time, int accuracy)  // 2
{
  magneticField.set(x, y, z);
}

void onGyroscopeEvent(float x, float y, float z) {
  rotation.x = x;
  rotation.y = y;
  rotation.z = z;
}

void onLightEvent(float v)                      // 3
{
  light = v;
}

void onProximityEvent(float v)                  // 4
{
  proximity = v;
}
public void mousePressed() {                    // 5
  if (sensor.isStarted())
    sensor.stop();
  else
    sensor.start();
  println("KetaiSensor isStarted: " + sensor.isStarted());
}
