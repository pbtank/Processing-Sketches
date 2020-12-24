//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import android.os.Bundle;
import android.content.Intent;

import ketai.net.bluetooth.*;
import ketai.sensors.*;

import java.util.Arrays;

KetaiBluetooth bt;
KetaiSensor sensor;

color cube, x, y, z, zo, fit, f8, home, end;

boolean isCube, isX, isY, isZ, isZo, isFit, isF8, isHome, isEnd = false;
boolean released = true;

float rotX, rotY, rotZ;
float scale = 1;

String data = "";

void setup() {
  fullScreen(P3D);
  orientation(PORTRAIT);
  
  cube = x = y = z = zo = fit = f8 = home = end = color(#C0C0C0);
  isCube = isX = isY = isZ = isZo = isFit = isF8 = isHome = isEnd = false;
  released = true;
  
  sensor = new KetaiSensor(this);
  
  bt.start();
  sensor.start();
  
}

void draw() {
  background(#C0C0C0);
  drawUI();
  fill(180);
  translate(width/2, height-width*0.6, 256);
  rotateX(-rotX);
  rotateY(rotY);
  rotateZ(-rotZ);
  rectMode(CENTER);
  box(height*0.2);
  rectMode(CORNER);
    
    if (isCube) {
      data = ("1" + "," + "0" + "," + nfp(degrees(rotX), 3, 3) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
    } else if (isX) {
      data = ("1" + "," + "1" + "," + nfp(degrees(rotX), 3, 3) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
    } else if (isY) {
      data = ("1" + "," + "2" + "," + nfp(degrees(rotX), 3, 3) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
    } else if (isZ) {
      data = ("1" + "," + "3" + "," + nfp(degrees(rotX), 3, 3) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
    } else if (isZo) {
      data = ("1" + "," + "4" + "," + nfp(scale, 2, 4) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
    } else if (isFit) {
      data = ("1" + "," + "5" + "," + nfp(scale, 2, 4) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
      scale = 1;
    } else if (isF8) {
      data = ("1" + "," + "6" + "," + nfp(scale, 2, 4) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
    } else if (isHome) {
      data = ("1" + "," + "7" + "," + nfp(scale, 2, 4) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
      rotX = 0;
      rotY = 0;
      rotZ = 0;
      scale = 1;
    } else if (isEnd) {
      data = ("1" + "," + "8" + "," + nfp(scale, 2, 4) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
      rotX = radians(-60);
      rotZ = radians(60);
      scale = 1;
    } else if (released) {
    data = ("2" + "," + "0" + "," + nfp(scale, 2, 4) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
    }
  
  println(data);
  byte[] s = data.getBytes();
  bt.broadcast(s);

}

void onGyroscopeEvent(float x, float y, float z) {
  if (mousePressed) {
    if (isCube) {
      rotX += 0.1*x;
      rotY += 0.1*y;
      rotZ += 0.1*z;
    }
    
    if (isX) {
      rotX += 0.1*x;
    }
    
    if (isY) {
      rotY += 0.1*x;
    }
    
    if (isZ) {
      rotZ += 0.1*x;
    }
    
    if (isZo) {
      scale += 0.1*x;
    }
  }
}

void stop() {
  sensor.stop();
}


