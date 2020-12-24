//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import android.os.Bundle;                                 // 1
import android.content.Intent;

import ketai.net.bluetooth.*;
import ketai.sensors.*;

import java.util.Arrays;

KetaiBluetooth bt;
KetaiSensor sensor;

float rotX, rotY, rotZ;
float scale = 1;

void setup() {
  fullScreen(P3D);
  orientation(PORTRAIT);
  
  sensor = new KetaiSensor(this);
  rectMode(CENTER);
  
  bt.start();
  sensor.start();
  
}

void draw() {
  background(255);
  fill(180);
  ellipse(mouseX, mouseY, 50, 50);
  strokeWeight(2);
  line(mouseX, mouseY, mouseX, height/2);
  translate(width/2, height/2);
  rotateX(rotX);
  rotateY(rotY);
  rotateZ(rotZ);
  box(height*0.3);
  
  String data = (nfp(degrees(rotX), 2, 4) + "," + nfp(degrees(rotY), 2, 4) + "," + nfp(degrees(rotZ), 2, 4) + ";");
  println(data);
  byte[] s = data.getBytes();
  bt.broadcast(s);
  
}

void onGyroscopeEvent(float x, float y, float z) {
  if (mousePressed) {
    rotX += 0.1*x;
    rotY += 0.1*y;
    rotZ += 0.1*z;
    //if (mouseY >= 0) {
    //  scale = map((mouseY - height/2), 0, height/2, 1, 4);
    //} else {
    //  scale = map((mouseY - height/2), 0, height/2, 1, 1/4);
    //}
    scale = map((height*(2/3)-mouseY), 0, height*(2/3), 1, 4);

  }
}

void stop() {
  sensor.stop();
}
