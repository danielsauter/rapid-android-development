import netP5.*;                                           // 1
import oscP5.*;
import ketai.net.*;
import ketai.sensors.*;

OscP5 oscP5;
KetaiSensor sensor;

NetAddress remoteLocation;
float myAccelerometerX, myAccelerometerY, myAccelerometerZ;
int x, y, p; 
String myIPAddress; 
String remoteAddress = "192.168.1.2";                     // 2 Customize!  

void setup() {
  sensor = new KetaiSensor(this);
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  textSize(72);
  initNetworkConnection();
  sensor.start();
}

void draw() {
  background(78, 93, 75);

  text("Remote Mouse Info: \n" +                          // 3
  "mouseX: " + x + "\n" +
    "mouseY: " + y + "\n" +
    "mousePressed: " + p + "\n\n" +
    "Local Accelerometer Data: \n" + 
    "x: " + nfp(myAccelerometerX, 1, 3) + "\n" +
    "y: " + nfp(myAccelerometerY, 1, 3) + "\n" +
    "z: " + nfp(myAccelerometerZ, 1, 3) + "\n\n" +
    "Local IP Address: \n" + myIPAddress + "\n\n" +
    "Remote IP Address: \n" + remoteAddress, width/2, height/2);

  OscMessage myMessage = new OscMessage("accelerometerData"); // 4
  myMessage.add(myAccelerometerX);                        // 5
  myMessage.add(myAccelerometerY);
  myMessage.add(myAccelerometerZ);
  oscP5.send(myMessage, remoteLocation);                  // 6
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("iii"))                  // 7
  {
    x =  theOscMessage.get(0).intValue();                 // 8
    y =  theOscMessage.get(1).intValue();
    p =  theOscMessage.get(2).intValue();
  }
}

void onAccelerometerEvent(float x, float y, float z)
{
  myAccelerometerX = x;
  myAccelerometerY = y;
  myAccelerometerZ = z;
}

void initNetworkConnection()
{
  oscP5 = new OscP5(this, 12000);                         // 9
  remoteLocation = new NetAddress(remoteAddress, 12000);  // 10
  myIPAddress = KetaiNet.getIP();                         // 11
}