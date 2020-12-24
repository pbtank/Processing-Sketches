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
Serial myPort;  // Create object from Serial class

String val;// Data received from the serial port
String valp;
String NULL = "TANK;";

//int maskFit = InputEvent.BUTTON;

float rotX = 0;
float rotY = 0;
float rotZ = 0;
float scale = 1;

float cubexx = displayWidth/2;
float cubeyy = displayHeight/2;
float lcubexx;
float lcubeyy;
float d = 0;
float dl;
float scalep = 1;

int mX;
int mY;
float e = 0;
//boolean moved = false;
int pressed = 0;

int mask = InputEvent.BUTTON2_DOWN_MASK;

void setup() {
  size(1280, 720, P3D);
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
}

void draw() {
  background(255);  // Set background to white
  if (val != valp) {
    if (myPort.available() > 0) {
      if (val != NULL) {
        if (val != null) {
          String[] data = split(val, ",");
          int index = int(trim(data[0]));
          mX = mouseX;
          mY = mouseY;
          valp = val;
          if (index == 0) {
            data[3] = data[3].replace(';', ' ');
            rotX = float(trim(data[1]));
            rotY = float(trim(data[2]));
            rotZ = float(trim(data[3]));
            //robby.mouseMove(int(cubexx), 1920/2);
            //cubexx = map(rotX, 0, 90, 1080/2, 1080);
            lcubeyy = lerp(lcubeyy, cubeyy, 0.1);
            lcubexx = lerp(lcubexx, cubexx, 0.1);
            robby.mouseMove(int(lcubexx+150), int(lcubeyy+150));
            //robby.mousePress(mask);
            pressed = 2;
            lcubeyy = map(rotX, 0, 90, displayHeight/2, displayHeight);
            lcubexx = map(rotY, 0, 90, displayWidth/2, displayWidth);
          } else if (index == 1) {
            data[3] = data[3].replace(';', ' ');
            rotX = float(trim(data[1]));
            lcubeyy = lerp(lcubeyy, cubeyy, 0.1);
            robby.mouseMove(displayWidth - 50, int(lcubeyy));
            robby.mousePress(mask);
            pressed = 2;
            lcubeyy = map(rotX, 0, 90, displayHeight/2, displayHeight);
          } else if (index == 2) {
            data[3] = data[3].replace(';', ' ');
            rotY = float(trim(data[2]));
            lcubexx = lerp(lcubexx, cubexx, 0.1);
            robby.mouseMove(int(lcubexx), displayHeight-100);
            robby.mousePress(mask);
            pressed = 2;
            lcubexx = map(rotY, 0, 90, displayWidth/2, displayWidth);
          } else if (index == 3) {
            data[3] = data[3].replace(';', ' ');
            rotZ = float(trim(data[3]));
            lcubexx = lerp(lcubexx, cubexx, 0.1);
            robby.mouseMove(int(lcubexx), 200);
            robby.mousePress(mask);
            pressed = 2;
            lcubexx = map(rotZ, 0, 90, displayWidth/2, displayWidth);
          } else if (index == 4) {
            data[3] = data[3].replace(';', ' ');
            scale = float(trim(data[1]));
            d = (scalep - scale)*2;
            dl = lerp(dl, d, 0.1);
            robby.mouseWheel(int(dl));
            println(int(dl));
          } else if (index == 5) {
            scale = 1;
            robby.keyPress(KeyEvent.VK_CONTROL);
            robby.keyPress(KeyEvent.VK_F);
            pressed = 5;
          } else if (index == 6) {
            robby.keyPress(KeyEvent.VK_F8);
            pressed = 6;
          } else if (index == 7) {
            rotX = 0;
            rotY = 0;
            rotZ = 0;
            scale = 1;
            robby.keyPress(KeyEvent.VK_HOME);
            pressed = 7;
          } else if (index == 8) {
            rotX = 30;
            rotY = 0;
            rotZ = 60;
            scale = 1;
            robby.keyPress(KeyEvent.VK_END);
            pressed = 8;
          }   
          //println("Recieved: " + val);
          //println(rotX, rotY, rotZ);
        }
      }
    }
  } else{
    scalep = scale;
    e += 1/60;
    //robby.mouseRelease(mask);
    
    if (keyPressed) {
      if (key == 'W') {
        robby.mousePress(mask);
      }
    } else {
      robby.mouseRelease(mask);
    }
    
    if (e > 1) {
      println("Released");
      lcubeyy = displayHeight/2;
      lcubexx = displayWidth/2;
    }
    //if (moved) {
    //  println("Released");
    //  robby.mouseMove(mX, mY);
    //  moved = false;
    //}
  }
    if (pressed == 2) {
      //robby.mouseRelease(mask);
      pressed = 0;
    } else if (pressed == 5) {
      robby.keyRelease(KeyEvent.VK_CONTROL);
      robby.keyRelease(KeyEvent.VK_F);
      pressed = 0;
    } else if (pressed == 6) {
      robby.keyRelease(KeyEvent.VK_F8);
      pressed = 0;
    } else if (pressed == 7) {
      robby.keyRelease(KeyEvent.VK_HOME);
      pressed = 0;
    } else if (pressed == 8) {
      robby.keyRelease(KeyEvent.VK_END);
      pressed = 0;
    }
  
  //println(displayWidth, displayHeight);
  println(frameRate);
 
  //////////////////////////3D////////////////////////

  translate(width/2, height/2, 250);
  rotateX(radians(-rotX));
  rotateZ(radians(rotY));
  rotateY(radians(rotZ));
  scale(scale);
  fill(0, 255, 0, 150);
  rectMode(CENTER);
  box(150);
  stroke(0, 0, 255);
  fill(0, 0, 255);
  text("TANK", 0, 0, 150/2+1);
  translate(0, -150/2, 0);
  fill(255, 0, 0, 150);
  sphere(150/2);
  
  /////////////////////////3D/////////////////
}

void keyPressed() {
    if (keyCode == 104) {
    println("f8");
  } 
  println(keyCode, key);
}

void serialEvent(Serial myPort) {
  char ch = ';';
  val = myPort.readStringUntil((byte)ch);
}
