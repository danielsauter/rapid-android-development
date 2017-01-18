// Required NFC methods on startup
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Bundle;

import ketai.net.nfc.*;

String tagText = "";
KetaiNFC ketaiNFC;

void setup() {   
  ketaiNFC = new KetaiNFC(this);
  orientation(LANDSCAPE);
  textSize(144);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(78, 93, 75);
  text("Tag:\n"+ tagText, width/2, height/2);             // 1
}

void onNFCEvent(String txt) {                             // 2
  tagText = trim(txt);                                    // 3
}

void mousePressed() {
  if (tagText.indexOf("http://") == 0)                    // 4
    link(tagText);                                        // 5
}