// Required methods to enable NFC and Bluetooth
import android.content.Intent;
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Bundle;

import ketai.net.*;
import oscP5.*;
import netP5.*;

import ketai.camera.*;
import ketai.net.bluetooth.*;
import ketai.net.nfc.*;

KetaiCamera cam;

int divisions = 1;                                        // 1
String tag = "";

void setup() 
{
  orientation(LANDSCAPE);
  noStroke();
  frameRate(10);
  background(127);
  rectMode(CENTER);                                       // 2
  textAlign(CENTER, CENTER);
  textSize(48);
  bt.start();
  cam = new KetaiCamera(this, 720, 480, 10);
  ketaiNFC.beam("bt:"+bt.getAddress());
  text("Beam and tap screen to start camera", width/2, height/2);
}

void draw() 
{
  if (cam.isStarted() && bt.isStarted()) 
  {
    interlace(cam.width/2, cam.height/2, cam.width/2, cam.height/2, divisions); // 3
  }
  else
    ketaiNFC.beam("bt:"+bt.getAddress());
}

void interlace(int x, int y, int w, int h, int level)     // 4
{
  if (level == 1)
  {
    color pixel = cam.get(x, y);                          // 5
    send((int)red(pixel), (int)green(pixel), (int)blue(pixel), x, y, w*2, h*2);  // 6
  }

  if (level > 1) {
    level--;                                              // 7
    interlace(x - w/2, y - h/2, w/2, h/2, level);         // 8
    interlace(x - w/2, y + h/2, w/2, h/2, level);
    interlace(x + w/2, y - h/2, w/2, h/2, level);
    interlace(x + w/2, y + h/2, w/2, h/2, level);
  }
}

void onCameraPreviewEvent()
{
  cam.read();
}

void mouseReleased() 
{
  if (!cam.isStarted()) 
    cam.start();

  divisions++;                                            // 9
}