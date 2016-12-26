void drawUI()
{
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
  text("snapshot", 2*(width/4)+20, 70);
}

void mousePressed()
{
  if (mouseY <= 100) {

    //start/stop the camera
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
        bg.resize(cam.width, cam.height);
      }
    }
    //switch cameras
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
    //take snapshot
    else if (mouseX > 2*(width/4) && mouseX < 3*(width/4))
    {
      cam.manualSettings();                                   // 1
      snapshot.copy(cam, 0, 0, cam.width, cam.height,
        0, 0, snapshot.width, snapshot.height);               // 2
      mux.resize(cam.width, cam.height);
    }
  }
}

void onCameraPreviewEvent()
{
  cam.read();
}

void exit()
{
  cam.stop();
}
