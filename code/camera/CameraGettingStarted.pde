import ketai.camera.*;
KetaiCamera cam;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 1280, 768, 30);                 // 1
  imageMode(CENTER);                                          // 2
}

void draw() {
  if (cam.isStarted())
    image(cam, width/2, height/2);                            // 3
}

void onCameraPreviewEvent() {                                 // 4
  cam.read();                                                 // 5
}

void mousePressed() {
  if (cam.isStarted())
  {
    cam.stop();                                               // 6
  }
  else
    cam.start();
}
