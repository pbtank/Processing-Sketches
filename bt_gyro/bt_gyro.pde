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

color cube;
color x, y, z;
color zo;
color fit, f8;
color home, end;

boolean isCube = false;
boolean isX, isY, isZ = false;
boolean isZo = false;
boolean isFit, isF8 = false;
boolean isHome, isEnd = false;

float rotX, rotY, rotZ;
float scale = 1;

String data = "";

void setup() {
  fullScreen(P3D);
  orientation(PORTRAIT);
  
  cube = color(#C0C0C0);
  x = color(#C0C0C0);
  y = color(#C0C0C0);
  z = color(#C0C0C0);
  zo = color(#C0C0C0);
  fit = color(#C0C0C0);
  f8 = color(#C0C0C0);
  home = color(#C0C0C0);
  end = color(#C0C0C0);
  
  sensor = new KetaiSensor(this);
  //rectMode(CENTER);
  
  bt.start();
  sensor.start();
  
}

void draw() {
  background(#C0C0C0);
  drawUI();
  fill(180);
  //ellipse(mouseX, mouseY, 50, 50);
  //strokeWeight(2);
  //line(mouseX, mouseY, mouseX, height/2);
  translate(width/2, height - width*0.6, 256);
  //pushMatrix();
  //scale(scale);
  rotateX(-rotX);
  rotateY(rotY);
  rotateZ(-rotZ);
  rectMode(CENTER);
  box(height*0.2);
  rectMode(CORNER);
  
  
  //String data = (nfp(degrees(rotX), 2, 4) + "," + nfp(degrees(rotY), 2, 4) + "," + nfp(degrees(rotZ), 2, 4) + ";");
    //String data;
    if (mousePressed) {
      if (isCube) {
        data = ("0" + "," + nfp(degrees(rotX), 3, 3) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
      } else if (isX) {
        data = ("1" + "," + nfp(degrees(rotX), 3, 3) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
      } else if (isY) {
        data = ("2" + "," + nfp(degrees(rotX), 3, 3) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
      } else if (isZ) {
        data = ("3" + "," + nfp(degrees(rotX), 3, 3) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
      } else if (isZo) {
        data = ("4" + "," + nfp(scale, 2, 4) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
      } else if (isFit) {
        data = ("5" + "," + nfp(scale, 2, 4) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
        scale = 1;
      } else if (isF8) {
        data = ("6" + "," + nfp(scale, 2, 4) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
      } else if (isHome) {
        data = ("7" + "," + nfp(scale, 2, 4) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
        rotX = 0;
        rotY = 0;
        rotZ = 0;
        scale = 1;
      } else if (isEnd) {
        data = ("8" + "," + nfp(scale, 2, 4) + "," + nfp(degrees(rotY), 3, 3) + "," + nfp(degrees(rotZ), 3, 3) + ";");
        rotX = radians(-60);
        rotZ = radians(60);
        scale = 1;
      }
      println(data);
      byte[] s = data.getBytes();
      bt.broadcast(s);
    }
    
    //textSize(40);
    //fill(0);
    //textAlign(RIGHT);
    //text(("Scale : " + scale), width*0.95, 20);
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


