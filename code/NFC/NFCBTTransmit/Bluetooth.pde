PendingIntent mPendingIntent; 
KetaiBluetooth bt;
OscP5 oscP5;

void send(int r, int g, int b, int x, int y, int w, int h)
{

  OscMessage m = new OscMessage("/remotePixel/");         // 1
  m.add(r);
  m.add(g);
  m.add(b);
  m.add(x);
  m.add(y);
  m.add(w);
  m.add(h);

  bt.broadcast(m.getBytes());                             // 2
}

void receive(int r, int g, int b, int x, int y, int w, int h)  // 3
{
  println("r:"+r+" | g:"+g+" | b:"+b+" | x:"+x+" | y:"+y+" | w:"+w+" | h:"+h);
  fill(r, g, b);
  float s = displayWidth/cam.width; // scale full display
  rect(x*s, y*s, w*s, h*s);
  // background(r, g, b); // try this if running slow
}

void onBluetoothDataEvent(String who, byte[] data)
{
  KetaiOSCMessage m = new KetaiOSCMessage(data);
  if (m.isValid())
  {
    if (m.checkAddrPattern("/remotePixel/"))
    {
      if (m.checkTypetag("iiiiiii"))                      // 4
      {
        receive(m.get(0).intValue(), m.get(1).intValue(), 
        m.get(2).intValue(), m.get(3).intValue(), 
        m.get(4).intValue(), m.get(5).intValue(), m.get(6).intValue());
      }
    }
  }
}