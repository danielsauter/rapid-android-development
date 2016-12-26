void drawUI() {
  fill(0, 128);
  rect(0, 0, width/4, 100);
  rect(width/4, 0, width/4, 100);
  rect(2*(width/4), 0, width/4, 100);
  rect(3*(width/4), 0, width/4-1, 100);

  fill(255);
  if (cam.isStarted())
    text("stop", 20, 70);
  else
    text("start", 20, 70);

  text("camera", (width/4)+20, 70);
  text("flash", 2*(width/4)+20, 70);
  text("save", 3*(width/4)+20, 70);                           // 1
}

void mousePressed() {
  if (mouseY <= 40) {
    if (mouseX > 0 && mouseX < width/4)
    {
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
    else if (mouseX > width/4 && mouseX < 2*(width/4))
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
    else if (mouseX >2*(width/4) && mouseX < 3*(width/4))
    {
      if (cam.isFlashEnabled())
        cam.disableFlash();
      else
        cam.enableFlash();
    }
    else if (mouseX > 3*(width/4) && mouseX < width)              // 2
    {
      if (cam.isStarted()) cam.savePhoto();                       // 3
    }
  }
}

void onSavePhotoEvent(String filename)                            // 4
{
  cam.addToMediaLibrary(filename);                                // 5
}

void onCameraPreviewEvent()
{
  cam.read();
}
