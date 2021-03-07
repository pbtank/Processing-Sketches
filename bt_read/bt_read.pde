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

int pscale = 1;
float amt;

float pstate;

float rotX, rotY, rotZ = 0;
float scale = 1;

int x, y;
int h = displayHeight;
int w = displayWidth;

int maskRotate = InputEvent.BUTTON2_DOWN_MASK;
int maskCtrl = KeyEvent.VK_CONTROL;
int maskF = KeyEvent.VK_F;
int maskF8 = KeyEvent.VK_F8;
int maskEnd = KeyEvent.VK_END;
int maskHome = KeyEvent.VK_HOME;

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
  frameRate(60);
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
              println(frameRate);
              y = int(map(rotX, 0, 180, 0, 500))+displayHeight/2;
            }
            robby.mouseMove(x, y);
            pcase = 9;
            break;
            
          case 1:
            x = displayWidth-400;
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
            y = displayHeight-100;
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
            y = 240;
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
            amt = (pscale-scale);
            robby.mouseWheel(int(amt*5));
            try{Thread.sleep(500);}catch(InterruptedException e) {};
            println(amt);
            break;
          case 5:
            scale = 1;
            robby.keyPress(maskCtrl);
            robby.keyPress(maskF);
            robby.keyRelease(maskF);
            robby.keyRelease(maskCtrl);
            break;
          case 6:
            robby.keyPress(maskF8);
            robby.keyRelease(maskF8);
            break;
          case 7:
            robby.keyPress(maskHome);
            robby.keyRelease(maskHome);
            rotX = 0;
            rotY = 0;
            rotZ = 0;
            break;  
          case 8:
            robby.keyPress(maskEnd);
            robby.keyRelease(maskEnd);
            rotX = 30;
            rotY = 0;
            rotZ = 60;
        }
        if (pstate != 1) {
          robby.mousePress(maskRotate);
          pstate = 1;
        }
      } 
      if (state == 2) {
        if (pstate != 2) {
          robby.mouseRelease(maskRotate);
          pstate = 2;
        }
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
