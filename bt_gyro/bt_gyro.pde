//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

// Required Bluetooth methods on startup
import android.os.Bundle;                                 // 1
import android.content.Intent;                            // 2

import ketai.net.bluetooth.*;  
import ketai.ui.*; 
import ketai.net.*;
import oscP5.*;

KetaiBluetooth bt;                                        // 3

KetaiList connectionList;                                 // 4
String info = "";                                         // 5
PVector remoteCursor = new PVector();
boolean isConfiguring = true;
String UIText;

void setup()
{   
  orientation(PORTRAIT);
  background(78, 93, 75);
  stroke(255);
  textSize(48);

  bt.start();                                             // 6

  UIText =  "[b] - make this device discoverable\n" +     // 7
    "[d] - discover devices\n" +
    "[c] - pick device to connect to\n" +
    "[p] - list paired devices\n" +
    "[i] - show Bluetooth info";
}

void draw()
{
  if (isConfiguring)
  {

    ArrayList<String> devices;                            // 8
    background(78, 93, 75);

    if (key == 'i')
      info = getBluetoothInformation();                   // 9
    else
    {
      if (key == 'p')
      {
        info = "Paired Devices:\n";
        devices = bt.getPairedDeviceNames();              // 10
      }
      else
      {
        info = "Discovered Devices:\n";
        devices = bt.getDiscoveredDeviceNames();          // 11
      }

      for (int i=0; i < devices.size(); i++)
      {
        info += "["+i+"] "+devices.get(i).toString() + "\n";  // 12
      }
    }
    text(UIText + "\n\n" + info, 5, 200);
  }
  else
  {
    background(78, 93, 75);
    pushStyle();
    fill(255);
    ellipse(mouseX, mouseY, 50, 50);
    fill(0, 255, 0);
    stroke(0, 255, 0);
    ellipse(remoteCursor.x, remoteCursor.y, 50, 50);      // 13
    popStyle();
  }

  drawUI();
}

void mouseDragged()
{
  if (isConfiguring)
    return;

  OscMessage m = new OscMessage("/remoteMouse/");          // 14
  m.add(mouseX);
  m.add(mouseY);

  //bt.broadcast(m.getBytes());  // 15
  byte[] data = {'T','A','N','K','\r'};
  bt.broadcast(data);
  // use writeToDevice(String _devName, byte[] data) to target a specific device
  ellipse(mouseX, mouseY, 20, 20);
}

void onBluetoothDataEvent(String who, byte[] data)         // 16
{
  if (isConfiguring)
    return;

  KetaiOSCMessage m = new KetaiOSCMessage(data);            // 17
  if (m.isValid())
  {
    if (m.checkAddrPattern("/remoteMouse/"))
    {
      if (m.checkTypetag("ii"))                             // 18
      {
        remoteCursor.x = m.get(0).intValue();
        remoteCursor.y = m.get(1).intValue();
      }
    }
  }
}

String getBluetoothInformation()                             // 19
{
  String btInfo = "Server Running: ";
  btInfo += bt.isStarted() + "\n";
  btInfo += "Discovering: " + bt.isDiscovering() + "\n";
  btInfo += "Device Discoverable: "+bt.isDiscoverable() + "\n";
  btInfo += "\nConnected Devices: \n";

  ArrayList<String> devices = bt.getConnectedDeviceNames();  // 20
  for (String device: devices)
  {
    btInfo+= device+"\n";
  }

  return btInfo;
}

