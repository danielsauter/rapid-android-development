
import ketai.data.*;
import ketai.sensors.*;

KetaiSensor sensor;
KetaiSQLite db;
boolean isCapturing = false;
float G = 9.80665;

String CREATE_DB_SQL = 
  "CREATE TABLE data ( time INTEGER PRIMARY KEY, x FLOAT, y FLOAT, z FLOAT);";  

void setup()
{
  db = new KetaiSQLite(this);
  sensor = new KetaiSensor(this);

  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(72);
  rectMode(CENTER);
  frameRate(15);
  if ( db.connect() ) 
  {
    if (!db.tableExists("data"))  
      db.execute(CREATE_DB_SQL);
  }
  sensor.start();
}

void draw() {
  background(78, 93, 75);
  if (isCapturing)
    text("Recording data...\n(press MENU button to stop)" +"\n\n" +
      "Current Data count: " + db.getDataCount(), width/2, height/2); 
  else
    plotData();
}

void keyPressed() {
  if (keyCode == BACK) {  
    db.execute( "DELETE FROM data" );
    key = 0; 
  } 
  else if (keyCode == MENU) { 
    if (isCapturing)
      isCapturing = false;
    else
      isCapturing = true;
  }
}

void onAccelerometerEvent(float x, float y, float z, long time, int accuracy)
{
  if (db.connect() && isCapturing)
  {
    if (!db.execute(
      "INSERT into data (`time`,`x`,`y`,`z`) VALUES ('" +
      System.currentTimeMillis() + "', '" + x + "', '" + y + "', '" + z + "')"
      )
    )  
      println("Failed to record data!" );
  }
}

void plotData()
{
  if (db.connect())
  {
    pushStyle();
    textAlign(LEFT);
    line(0, height/2, width, height/2);
    line(mouseX, 0, mouseX, height);
    noStroke();
    db.query("SELECT * FROM data");
    long myMin = Long.parseLong(db.getFieldMin("data", "time")); // 1
    long myMax = Long.parseLong(db.getFieldMax("data", "time")); // 2
    while (db.next ())  
    {

      long t = db.getLong("time");                        // 3
      float x = db.getFloat("x");  
      float y = db.getFloat("y");
      float z = db.getFloat("z");
      float plotX = 0;
      float plotY = 0;

      fill(255, 0, 0);
      plotX = mapLong(t, myMin, myMax, 0, width);         // 4
      plotY = map(x, -2*G, 2*G, 0, height);
      ellipse(plotX, plotY, 3, 3);  
      if (abs(mouseX-plotX) < 1)
        text(nfp(x, 2, 2), plotX, plotY); 

      fill(0, 255, 0);
      plotY = map(y, -2*G, 2*G, 0, height);
      ellipse(plotX, plotY, 3, 3);
      if (abs(mouseX-plotX) < 1)
        text(nfp(y, 2, 2), plotX, plotY);

      fill(0, 0, 255);
      plotY = map(z, -2*G, 2*G, 0, height);
      ellipse(plotX, plotY, 3, 3);
      if (abs(mouseX-plotX) < 1)
      {
        text(nfp(z, 2, 2), plotX, plotY);
        fill(0);
        text("#" + t, mouseX, height);                    // 4
      }
    }
    noFill();
    stroke(255);
    db.query("SELECT * FROM data WHERE z > 9.5 AND abs(x) < 0.3 AND abs(y) < 0.3"); // 5
    while (db.next ())  
    {
      long t = db.getLong("time");
      float x = db.getFloat("x");  
      float y = db.getFloat("y");
      float z = db.getFloat("z");
      float plotX, plotY = 0;

      plotX = mapLong(t, myMin, myMax, 0, width);
      plotY = map(x, -2*G, 2*G, 0, height);
      ellipse(plotX, plotY, 10, 10);                      // 5

      plotY = map(y, -2*G, 2*G, 0, height);
      ellipse(plotX, plotY, 10, 10);

      plotY = map(z, -2*G, 2*G, 0, height);
      ellipse(plotX, plotY, 10, 10);
    }
    popStyle();
  }
}

// map() helper method for values of type long
float mapLong(long value, long istart, long istop, float ostart, float ostop) { // 6
 return (float)(ostart + (ostop - ostart) * (value - istart) / (istop - istart));
}