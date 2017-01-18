// Required NFC methods on startup

import android.app.PendingIntent;
import android.content.Intent;
import android.os.Bundle;
import ketai.net.nfc.*;
import ketai.ui.*;                                        // 1

KetaiNFC ketaiNFC;

String tagText = "";
String tagStatus = "Tap screen to start";                 // 2

void setup() {   
  if (ketaiNFC == null)
    ketaiNFC = new KetaiNFC(this);
  // orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(144);
}

void draw() {
  background(78, 93, 75);
  text(tagStatus + " \n" + tagText, 0, 50, width, height-100);  // 3
}

void onNFCEvent(String txt) {
  tagText = trim(txt);
  tagStatus = "Tag:";
}

void onNFCWrite(boolean result, String message) {
  if (result)
    tagStatus = "Writing Complete.";
}

void mousePressed() {
  KetaiKeyboard.toggle(this);                             // 4
  tagText = "";
  tagStatus = "Type tag text:";
  textAlign(CENTER, TOP);                                 // 5
}

void keyPressed() {
  if (key != CODED)                                       // 6
  {
    tagStatus = "Write URL, then press ENTER to transmit";
    tagText += key;                                       // 7
  }
  if (key == ENTER)                                       // 8
  {
    ketaiNFC.write(tagText);                              // 9
    tagStatus = "Touch tag to transmit:";
    KetaiKeyboard.toggle(this);
    textAlign(CENTER, CENTER);
  } else if (keyCode == 67)                               // 10
  {
    tagText = tagText.substring(0, tagText.length()-1);   // 11
  }
}