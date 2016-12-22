import ketai.sensors.*;
KetaiLocation location;                                           // 1
double longitude, latitude, altitude;
float accuracy;

void setup() {
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(72);
  location = new KetaiLocation(this);                             // 2
}

void draw() {
  background(78, 93, 75);
  if (location.getProvider() == "none")                           // 3
    text("Location data is unavailable. \n" +
      "Please check your location settings.", width/2, height/2);
  else
    text("Latitude: " + latitude + "\n" +                         // 4
      "Longitude: " + longitude + "\n" +
      "Altitude: " + altitude + "\n" +
      "Accuracy: " + accuracy + "\n" +
      "Provider: " + location.getProvider(), width/2, height/2);
}

void onLocationEvent(double _latitude, double _longitude,
  double _altitude, float _accuracy) {                            // 5
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
  accuracy = _accuracy;
  println("lat/lon/alt/acc: " + latitude + "/" + longitude + "/"
    + altitude + "/" + accuracy);
}
