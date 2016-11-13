import ketai.sensors.*;
KetaiSensor sensor;
PVector accelerometer = new PVector();                  // 1
PVector pAccelerometer = new PVector();                 // 2
float r, g, b;
int num = 8;
color[] palette = new color[num];
int paletteIndex = 0;

void setup()
{
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  textSize(72);
}

void draw()
{
  // remap sensor values to color range
  r = map(accelerometer.x, -10, 10, 0, 255);            // 3
  g = map(accelerometer.y, -10, 10, 0, 255);
  b = map(accelerometer.z, -10, 10, 0, 255);
  // calculating angle between current and previous accelerometer vector in radians
  float delta = PVector.angleBetween(accelerometer, pAccelerometer);  // 4
  if (degrees(delta) > 45) {                            // 5
    shake();
  }
  // assign color to background
  background(r, g, b);
  fill(0);
  text("Current Color: \n" +
    "(" + round(r) + ", " + round(g) + ", " + round(b) + ")",
  width*0.5, height*0.25);
  // color picker
  for (int i=0; i<num; i++) {
    fill(palette[i]);
    rect(i*width/num, height/2, width/num, height/2);
  }
  // storing a reference vector
  pAccelerometer.set(accelerometer);                    // 6
}

void onAccelerometerEvent(float x, float y, float z)
{
  accelerometer.x = x;                                  // 7
  accelerometer.y = y;
  accelerometer.z = z;
}

void mousePressed()
{
  // updating color value, tapping top half of the screen
  if (mouseY < height/2) {
    palette[paletteIndex] = color(r, g, b);
    if (paletteIndex < num-1) {
      paletteIndex++;
    }
    else {
      paletteIndex = 0;
    }
  }
}

void shake()
{
  // resetting all swatches to black
  for (int i=0; i<num; i++) {
    palette[i] = color(0);                              // 8
  }
  paletteIndex = 0;
}
