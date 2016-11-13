import ketai.sensors.*;

KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ;

void setup()
{
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);                            // 1
  textSize(72);                                         // 2
}

void draw()
{
  background(78, 93, 75);
  text("Accelerometer: \n" +                            // 3
    "x: " + nfp(accelerometerX, 2, 3) + "\n" +
    "y: " + nfp(accelerometerY, 2, 3) + "\n" +
    "z: " + nfp(accelerometerZ, 2, 3), width/2, height/2);
}

void onAccelerometerEvent(float x, float y, float z)
{
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}
