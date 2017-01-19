
import ketai.sensors.*;

KetaiSensor sensor;
float rotationX, rotationY, rotationZ;
float roll, pitch, yaw;

ArrayList<PVector> points = new ArrayList<PVector>();     // 1

void setup()
{
  size(displayWidth, displayHeight, P3D);
  orientation(PORTRAIT);

  sensor = new KetaiSensor(this);
  sensor.start();

  noStroke();
  int sections = 3600;                                     // 2

  for (int i=0; i<=sections; i++)                          // 3
  {
    pushMatrix();                                          // 4
    rotateZ(radians(map(i, 0, sections, 0, 360)));         // 5
    pushMatrix();                                          // 6
    translate(width/2, 0, 0);                              // 7
    pushMatrix();                                          // 8
    rotateY(radians(map(i, 0, sections, 0, 180)));         // 9
    points.add(
      new PVector(modelX(0, 0, 100), modelY(0, 0, 100), modelZ(0, 0, 100))     // 10
    );
    points.add(
      new PVector(modelX(0, 0, -100), modelY(0, 0, -100), modelZ(0, 0, -100))  // 11
    );
    popMatrix();
    popMatrix();
    popMatrix();
  }
}

void draw()
{
  background(0);
  ambientLight(0, 0, 128);                                // 12
  pointLight(255, 255, 255, 0, 0, 0);                     // 13

  pitch += rotationX;                                     // 14
  roll += rotationY;                                      // 15
  yaw += rotationZ;                                       // 16

  translate(width/2, height/2, 0);
  rotateX(pitch);
  rotateY(-roll);
  rotateZ(yaw);

  beginShape(QUAD_STRIP);                                 // 17
  for (int i=0; i<points.size(); i++)
  {
    vertex(points.get(i).x, points.get(i).y, points.get(i).z);  // 18
  }
  endShape(CLOSE);

  if (frameCount % 100 == 0)
    println(frameRate);
}

void onGyroscopeEvent(float x, float y, float z)          // 19
{
  rotationX = radians(x);  
  rotationY = radians(y);
  rotationZ = radians(z); 
}

void mousePressed()
{
  pitch = roll = yaw = 0;                                  // 20
}