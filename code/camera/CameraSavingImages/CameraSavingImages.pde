import ketai.camera.*;

KetaiCamera cam;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 1280, 768, 30);
  println(cam.list());
  // 0: back camera; 1: front camera
  cam.setCameraID(0);
  imageMode(CENTER);
  stroke(255);
  textSize(48);
}

void draw() {
  background(128);
  if (!cam.isStarted())                                         // 1
  {
    pushStyle();                                                // 2
    textAlign(CENTER, CENTER);
    String info = "CameraInfo:\n";
    info += "current camera: "+ cam.getCameraID()+"\n";         // 3
    info += "image dimensions: "+ cam.width +                   // 4
      "x"+cam.height+"\n";                                      // 5
    info += "photo dimensions: "+ cam.getPhotoWidth() +         // 6
      "x"+cam.getPhotoHeight()+"\n";                            // 7
    info += "flash state: "+ cam.isFlashEnabled()+"\n";         // 8
    text(info, width/2, height/2);
    popStyle();                                                 // 9
  }
  else
  {
    image(cam, width/2, height/2, width, height);
  }
  drawUI();
}
