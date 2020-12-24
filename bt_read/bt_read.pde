//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import processing.serial.*;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.*;
import java.awt.event.KeyEvent;

Robot robby;
Serial myPort;

String val;
int state = 2;
int index = 9;
int pcase = 0;

float rotX, rotY, rotZ = 0;
float scale = 1;

int x, y;
int h = displayHeight;
int w = displayWidth;

int mask = InputEvent.BUTTON1_DOWN_MASK;

void setup() {
  //size(1280, 720, P3D);
  printArray(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  myPort.buffer(35);
  
  try {
    robby = new Robot();
  } catch (AWTException e) {
    println("Robot class not supported by your system!");
    exit();
  }
  frameRate(3);
}

void draw() {
  //background(255);  
  if (myPort.available() > 0) {
    if (val != null) {
      String[] data = split(val, ",");
      state = int(trim(data[0]));
      index = int(trim(data[1]));

      if (state == 1) {
        switch(index) {
          
          case 0:
            if ((pcase-9) != 0) {
              x = displayWidth/2;
              y = displayHeight/2;
            } else {
              data[4] = data[4].replace(';', ' ');
              rotX = float(trim(data[2]));
              rotY = float(trim(data[3]));
              rotZ = float(trim(data[4]));
              x = int(map(rotY, 0, 180, 0, 500))+displayWidth/2;
              y = int(map(rotX, 0, 180, 0, 500))+displayHeight/2;
            }
            robby.mouseMove(x, y);
            pcase = 9;
            break;
            
          case 1:
            x = displayWidth-20;
            if (int((pcase-index)) != 0) {
              y = displayHeight/2;
            } else {
              data[4] = data[4].replace(';', ' ');
              rotX = float(trim(data[2]));
              y = int(map(rotX, 0, 180, 0, 500))+displayHeight/2;
            }
            robby.mouseMove(x, y);
            pcase = 1;
            break;
            
          case 2:
            y = displayHeight-160;
            if ((pcase-index) != 0) {
              x = displayWidth/2;
            } else {
              data[4] = data[4].replace(';', ' ');
              rotY = float(trim(data[3]));
              x = int(map(rotY, 0, 180, 0, 500))+displayWidth/2;
            }
            robby.mouseMove(x, y);
            pcase = 2;
            break;
            
          case 3:
            y = 160;
            if ((pcase-index) != 0) {
              x = displayWidth/2;
            } else {
              data[4] = data[4].replace(';', ' ');
              rotY = float(trim(data[4]));
              x = int(map(rotY, 0, 180, 0, 500))+displayWidth/2;
            }
            robby.mouseMove(x, y);
            pcase = 3;
            break;
            
          case 4:
            data[4] = data[4].replace(';', ' ');
            scale = float(trim(data[2]));
            break;
          case 5:
            scale = 1;
            break;
          case 6:
            break;
          case 7:
            rotX = 0;
            rotY = 0;
            rotZ = 0;
            break;  
          case 8:
            rotX = 30;
            rotY = 0;
            rotZ = 60;
        }
        robby.mousePress(mask);
      } 
      if (state == 2) {
        robby.mouseRelease(mask);
        //println("released");
      }
      //println(rotX, rotY, rotZ);
      //println(val);
    }
  }
  
  //////////////////////////3D////////////////////////
  
  //pushMatrix();
  //translate(width/2, height/2, 250);
  //pushMatrix();
  //rotateX(radians(-rotX));
  //rotateZ(radians(rotY));
  //rotateY(radians(rotZ));
  //scale(scale);
  //fill(0, 255, 0, 150);
  //rectMode(CENTER);
  //box(150);
  //stroke(0, 0, 255);
  //fill(0, 0, 255);
  //text("TANK", 0, 0, 150/2+1);
  //translate(0, -150/2, 0);
  //fill(255, 0, 0, 150);
  //sphere(150/2);
  //popMatrix();

  //line(0, 0, 0, 150);
  //popMatrix();
  
  /////////////////////////3D/////////////////
}

void serialEvent(Serial myPort) {
  char ch = ';';
  val = myPort.readStringUntil((byte)ch);
}
