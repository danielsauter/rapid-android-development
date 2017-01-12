void drawUI() {                                             // 1
  fill(0, 128);
  rect(0, 0, width/4, 100);
  rect(width/4, 0, width/4, 100);
  rect(2*(width/4), 0, width/4, 100);
  rect(3*(width/4), 0, width/4, 100);
  fill(255);
  if (cam.isStarted())                                      // 2
    text("stop", 20, 70);
  else
    text("start", 20, 70);
  text("camera", (width/4)+20, 70);
  text("flash", 2*(width/4)+20, 70);
}
void mousePressed() {                                       // 3
  if (mouseY <= 100) {                                      // 4
    if (mouseX > 0 && mouseX < width/4) {                   // 5
      if (cam.isStarted())
      {
        cam.stop();
      }
      else
      {
        if (!cam.start())
          println("Failed to start camera.");
      }
    }
    else if (mouseX > width/4 && mouseX < 2*(width/4))      // 6
    {
      int cameraID = 0;
      if (cam.getCameraID() == 0)
        cameraID = 1;
      else
        cameraID = 0;
      cam.stop();
      cam.setCameraID(cameraID);
      cam.start();
    }
    else if (mouseX >2*(width/4) && mouseX < 3*(width/4))   // 7
    {
      if (cam.isFlashEnabled())                             // 8
        cam.disableFlash();
      else
        cam.enableFlash();
    }
  }
}
void onCameraPreviewEvent() {
  cam.read();
}
void exit() {
  cam.stop();
}
