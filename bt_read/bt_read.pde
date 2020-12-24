//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import processing.serial.*;

Serial myPort;
String val;

float rotX, rotY, rotZ = 0;
float scale = 1;

float lrotX, lrotY, lrotZ = 0;
float lscale = 1;

void setup() {
  size(1280, 720, P3D);
  printArray(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  myPort.buffer(35);
}

void draw() {
  background(255);
  if(myPort.available() > 0) {
    if (val != null) {
      String[] data = split(val, ",");
      int index = int(trim(data[0]));
      
      switch(index) {
        case '0': {
          data[3] = data[3].replace(';', ' ');
          lrotX = float(trim(data[1]));
          lrotY = float(trim(data[2]));
          lrotZ = float(trim(data[3])); }
          break;
        case '1':
          data[3] = data[3].replace(';', ' ');
          lrotX = float(trim(data[1]));
          break;
        case '2':
          data[3] = data[3].replace(';', ' ');
          lrotY = float(trim(data[2]));
          break;
        case '3':
          data[3] = data[3].replace(';', ' ');
          lrotZ = float(trim(data[3]));
          break;  
        case '4':
          data[3] = data[3].replace(';', ' ');
          lscale = float(trim(data[1]));
          break;
        case '5':
          scale = 1;
          lscale = lerp(lscale, scale, 0.1);
          break;
        case '6':
          break;
        case '7':
          rotX = 0;
          rotY = 0;
          rotZ = 0;
          lrotX = lerp(lrotX, rotX, 0.1);
          lrotY = lerp(lrotY, rotY, 0.1);
          lrotZ = lerp(lrotZ, rotZ, 0.1);
          break;  
        case '8':
          rotX = 30;
          rotY = 0;
          rotZ = 60;
          lrotX = lerp(lrotX, rotX, 0.1);
          lrotY = lerp(lrotY, rotY, 0.1);
          lrotZ = lerp(lrotZ, rotZ, 0.1);
          break;  
      }
      println(rotX, rotY, rotZ);
    }
  }
  
  //////////////////////////3D////////////////////////
  
  //pushMatrix();
  translate(width/2, height/2, 250);
  rotateX(radians(-lrotX));
  rotateZ(radians(lrotY));
  rotateY(radians(lrotZ));
  scale(lscale);
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
  //popMatrix();
  
  /////////////////////////3D/////////////////
}

void serialEvent(Serial myPort) {
  char ch = ';';
  val = myPort.readStringUntil((byte)ch);
}

