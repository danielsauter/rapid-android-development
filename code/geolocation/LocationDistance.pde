/**
 * <p>Ketai Sensor Library for Android: http://ketai.org</p>
 *
 * <p>Ketai Location Features:
 * <ul>
 * <li>Uses GPS location data (latitude, longitude, altitude (if available)</li>
 * <li>Updates if location changes by 1 meter, or every 10 seconds</li>
 * <li>If unavailable, defaults to system provider (cell tower or WiFi network location)</li>
 * </ul>
 * <p>Syntax:
 * <ul>
 * <li>onLocationEvent(double latitude, double longitude, double altitude, float accuracy)</li>
 * <li>onLocationEvent(double latitude, double longitude, double altitude)</li>
 * <li>onLocationEvent(double latitude, double longitude)</li>
 * <li>onLocationEvent(Location location)</li>
 * </p>
 * <p>More info on the Android Location class: http://developer.android.com/reference/android/location/Location.html
 * </p>
 * <p>Updated: 2012-01-19 Daniel Sauter/j.duran</p>
 */

import ketai.sensors.*; 
double longitude, latitude, altitude, accuracy;
KetaiLocation location;
Location bam;

void setup() {
  location = new KetaiLocation(this);
  // Example location: the Brooklyn Academy of Music
  bam = new Location("bam");  //<callout id="co.location.set"/>
  bam.setLatitude(40.686818);
  bam.setLongitude(-73.977779);
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(72);
}

void draw() {
  background(78, 93, 75);
  if (location.getProvider() == "none") {
    text("Location data is unavailable. \n" +
      "Please check your location settings.", 0, 0, width, height);
  } else {
    float distance = round(location.getLocation().distanceTo(bam));  //<callout id="co.calculate.distance"/>
    text("Location data:\n" + 
      "Latitude: " + latitude + "\n" + 
      "Longitude: " + longitude + "\n" + 
      "Altitude: " + altitude + "\n" +
      "Accuracy: " + accuracy + "\n" +
      "Distance to Destination: "+ distance + "m\n" + 
      "Provider: " + location.getProvider(), 20, 0, width, height);
  }
}

void onLocationEvent(Location _location)  //<callout id="co.location.event.object"/>
{
  //print out the location object
  println("onLocation event: " + _location.toString());  //<callout id="co.location.object"/>
  longitude = _location.getLongitude();
  latitude = _location.getLatitude();
  altitude = _location.getAltitude();
  accuracy = _location.getAccuracy();
}
