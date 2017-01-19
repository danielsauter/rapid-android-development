PFont font;                                               // 1

void setup() 
{
  size(displayWidth, displayHeight, P3D);
  orientation(LANDSCAPE);
  noStroke();
  
  font = createFont("SansSerif", 48);                      // 2
  textFont(font);                                          // 3
  textAlign(CENTER, CENTER);
}

void draw() 
{
  background(0); 

  pointLight(0, 150, 250, 0, height/2, 500);               // 4
  pointLight(250, 50, 0, width, height/2, 500);            // 5

  for (int y = 0; y < height; y+=100) {                    // 6
    for (int x = 0; x < width; x+=250) {                   // 7
      float distance = dist(x, y, mouseX, mouseY);         // 8
      float z = map(distance, 0, width, 0, -1000);         // 9
      text(x +","+ y, x, y, z);                            // 10
    }

  }

  if (frameCount%10 == 0) 
    println(frameRate);
}