
import ketai.sensors.*;

KetaiSensor sensor;
float rotationX, rotationY, rotationZ;
float roll, pitch, yaw;

PShape moebius;                                           // 1

void setup()
{
  size(displayWidth, displayHeight, P3D);
  orientation(PORTRAIT);

  sensor = new KetaiSensor(this);
  sensor.start();

  noStroke();
  int sections = 36000;
  
  moebius = createShape();                                // 2
  moebius.beginShape(QUAD_STRIP);
  for (int i=0; i<=sections; i++)
  {
    pushMatrix();
    rotateZ(radians(map(i, 0, sections, 0, 360)));
    pushMatrix();
    translate(width/2, 0, 0);
    pushMatrix();
    rotateY(radians(map(i, 0, sections, 0, 180)));
    moebius.vertex(modelX(0, 0, 100), modelY(0, 0, 100), modelZ(0, 0, 100));     // 3
    moebius.vertex(modelX(0, 0, -100), modelY(0, 0, -100), modelZ(0, 0, -100));  // 4
    popMatrix();
    popMatrix();
    popMatrix();
  }
  moebius.endShape(CLOSE);                                // 5
}

void draw()
{
  background(0);

  ambientLight(0, 0, 128);
  pointLight(255, 255, 255, 0, 0, 0);

  pitch += rotationX;
  roll += rotationY;
  yaw += rotationZ;

  translate(width/2, height/2, 0);
  rotateX(pitch);
  rotateY(-roll);
  rotateZ(yaw);

  shape(moebius);                                         // 6

  if (frameCount % 100 == 0)
    println(frameRate);
}

void onGyroscopeEvent(float x, float y, float z)
{
  rotationX = radians(x);
  rotationY = radians(y);
  rotationZ = radians(z);
}

void mousePressed()
{
  pitch = roll = yaw = 0;
}