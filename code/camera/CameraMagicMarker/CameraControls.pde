void onCameraPreviewEvent()
{
  cam.read();
}

void exit()
{
  cam.stop();
}
