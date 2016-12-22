/**
 * <p>Ketai Sensor Library for Android: http://ketai.org</p>
 *
 * <p>KetaiLocation Features:
 * <ul>
 * <li>Uses location class to determine travel speed</li>
 * </ul>
 * More information:
 * http://developer.android.com/reference/android/location/Location.html</p>
 * <p>Updated: 2011-06-09 Daniel Sauter/Jesus Duran</p>
 */

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
  speed = _location.getSpeed();  //<callout id="co.travel.speed"/>
  bearing = _location.getBearing();  //<callout id="co.travel.bearing"/>
}
