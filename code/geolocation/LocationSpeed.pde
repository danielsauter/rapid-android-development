import ketai.sensors.*;
KetaiLocation location;
float speed, bearing;

void setup() {
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(72);
  location = new KetaiLocation(this);
}

void draw() {
  background(78, 93, 75);
  text("Travel speed: "+ speed + "\n"
    + "Bearing: "+ bearing, 0, 0, width, height);
}

void onLocationEvent(Location _location) {
  println("onLocation event: " + _location.toString());
  speed = _location.getSpeed();                                 // 1
  bearing = _location.getBearing();                             // 2
}
