import ketai.camera.*;
import ketai.cv.facedetector.*;

KetaiCamera cam;
KetaiSimpleFace[] faces;                                    // 1
boolean findFaces = false;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 1280, 768, 30);
  rectMode(CENTER);                                         // 2
  stroke(0, 255, 0);
  noFill();                                                 // 3
  textSize(48);
}

void draw() {
  background(0);
  if (cam != null) {
    image(cam, 0, 0);
    if (findFaces)                                          // 4
    {
      faces = KetaiFaceDetector.findFaces(cam, 20);         // 5
      for (int i=0; i < faces.length; i++)                  // 6
      {
        rect(faces[i].location.x, faces[i].location.y,      // 7
        faces[i].distance*2, faces[i].distance*2);          // 8
      }
      text("Faces found: " + faces.length, width*.8, height/2);  // 9
    }
  }
}

void mousePressed () {
  if(!cam.isStarted())
    cam.start();
  if (findFaces)
    findFaces = false;
  else
    findFaces = true;
}
void onCameraPreviewEvent() {
  cam.read();
}
