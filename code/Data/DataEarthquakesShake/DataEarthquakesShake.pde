
import ketai.sensors.*; 
import ketai.ui.*;

Table history;
PImage world;
String src = 
  "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.csv";
KetaiVibrate motor;                                       // 1
int lastCheck;

void setup()
{
  location = new KetaiLocation(this);
  try {
    history = loadTable(src, "header, csv");
  }
  catch
    (Exception x) {
    println("Failed to open online stream reverting to local data");
    history = loadTable("all_week_2015-02-24.txt", "header, csv");
  }
  orientation(LANDSCAPE);
  world = loadImage("worldMap.png");
  lastCheck = millis();

  motor = new KetaiVibrate(this);                         // 2
}

void draw () {
  background(127);
  image(world, 0, 0, width, height);

  if (history.getRowCount() > 0) {
    for (int row = 0; row < history.getRowCount(); row++) {
      float lon = history.getFloat(row, 2);
      float lat = history.getFloat(row, 1);
      float magnitude = history.getFloat(row, 4);
      float x = map(lon, -180, 180, 0, width);
      float y = map(lat, 85, -60, 0, height);

      noStroke();
      fill(0);
      ellipse(x, y, 10, 10);
      float dimension = map(magnitude, 0, 10, 0, 500);
      float freq = map(millis()%(1000/magnitude), 
      0, 1000/magnitude, 0, magnitude*50);
      fill(255, 127, 127, freq);
      ellipse(x, y, dimension, dimension);

      Location quake;
      quake = new Location("quake");
      quake.setLongitude(lon);
      quake.setLatitude(lat);
      int distance = int(location.getLocation().distanceTo(quake)/1609.34);

      noFill();
      stroke(150);
      ellipse(myX, myY, dist(x, y, myX, myY)*2, dist(x, y, myX, myY)*2);
      fill(0);
      text(distance, x, y);
    }
  }
  // Current Device location
  noStroke();
  float s = map(millis() % (100*accuracy*3.28), 0, 100*accuracy*3.28, 0, 127);
  fill(127, 255, 127);
  ellipse(myX, myY, 10, 10);
  fill(127, 255, 127, 127-s);
  ellipse(myX, myY, s, s);

  if (millis() > lastCheck + 10000) {                     // 3
    lastCheck = millis();
    update();
  }
}

void vibrate(long[] pattern)
{
  if (motor.hasVibrator())                                // 4
    motor.vibrate(pattern, -1);                           // 5
  else
    println("No vibration service available on this device");
}

void update()
{
  println(history.getRowCount() + " rows in table before update" );

  ArrayList<Float> magnitudes = new ArrayList<Float>();
  Table earthquakes;

  try {
    earthquakes = loadTable(src);
  }
  catch
    (Exception x) {
    println("Failed to open online stream, reverting to local data");
    earthquakes = loadTable("all_week_2015-02-24.txt", "header, csv");
  }

  if (earthquakes.getRowCount() > 1)

    for (int i = 1; i < earthquakes.getRowCount(); i++)   // 6
    {
      if (findInTable(history, 1, earthquakes.getString(i, 1)))
      {
        continue;
      }
      String[] rowString = earthquakes.getStringRow(i);
      history.addRow();                                   // 7
      history.setRow(history.getRowCount()-1, rowString); // 8
      //Magnitude field is number 6
      Float magnitude = new Float(earthquakes.getFloat(i, 6));  // 9
      magnitudes.add(magnitude);
      println("adding earthquake: " + earthquakes.getString(i, 1));
    }

  long[] pattern = new long[2*magnitudes.size()];         // 10

  int j = 0;
  for (int k=0; k < pattern.length;)
  {
    pattern[k++] = 500;
    pattern[k++] = (long)(magnitudes.get(j) * 100);
    j++;
  }

  motor.vibrate(pattern, -1);                             // 11
  println(history.getRowCount() + " rows in table after update" );
}

boolean findInTable(Table t, int col, String needle) {    // 12
  for (int k=0; k < t.getRowCount(); k++) {
    if (needle.compareTo(t.getString(k, col)) == 0)       // 13
      return true;
  }
  return false;
}