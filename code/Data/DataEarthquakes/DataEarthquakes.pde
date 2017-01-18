
import ketai.sensors.*;

Table earthquakes, delta;

int count;
PImage world;
String src = 
  "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.csv";  // 1

void setup()
{
  location = new KetaiLocation(this);
  try {

    earthquakes = loadTable(src, "header, csv");          // 2
  }
  catch
    (Exception x) {
    println("Failed to open online stream reverting to local data");
    earthquakes = loadTable("all_hour_2015-02-24.txt", "header, csv");      // 3
  }
  count = earthquakes.getRowCount();
  println(count+" earthquakes found"); 

  orientation(LANDSCAPE);
  world = loadImage("worldMap.png");
}

void draw ()
{
  background(127);
  image(world, 0, 0, width, height);                      // 4

  for (int row = 0; row < count; row++)
  {
    float lon = earthquakes.getFloat(row, 2);             // 5
    float lat = earthquakes.getFloat(row, 1);             // 6
    float magnitude = earthquakes.getFloat(row, 4);       // 7
    float x = map(lon, -180, 180, 0, width);              // 8
    float y = map(lat, 85, -60, 0, height);               // 9
    noStroke();
    fill(255, 127, 127);
    ellipse(x, y, 10, 10);
    float dimension = map(magnitude, 0, 10, 0, 500);      // 10
    float freq = map(millis()%(1000/magnitude), 
      0, 1000/magnitude, 0, magnitude*50);                // 11
    fill(255, 127, 127, freq);                            // 12
    ellipse(x, y, dimension, dimension);

    Location quake;
    quake = new Location("quake");                        // 13
    quake.setLongitude(lon); 
    quake.setLatitude(lat);
    int distance = int(location.getLocation().distanceTo(quake)/1609.34);     // 14
    noFill();
    stroke(150);
    ellipse(myX, myY, dist(x, y, myX, myY)*2, dist(x, y, myX, myY)*2);        // 15
    fill(0);
    text(distance, x, y);                                 // 16
  }

  // Current Device location
  noStroke();
  float s = map(millis() % (100*accuracy*3.28), 0, 100*accuracy*3.28, 0, 127); // 16
  fill(127, 255, 127);
  ellipse(myX, myY, 10, 10);
  fill(127, 255, 127, 127-s);
  ellipse(myX, myY, s, s);
}