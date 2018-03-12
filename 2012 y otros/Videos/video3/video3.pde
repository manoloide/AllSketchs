import processing.video.*;
Movie m;

void setup() {
  size(640, 480);
  m = new Movie(this, "../v1.MOV"); 
  m.loop();
}

void movieEvent(Movie m) {
  m.read();
}


void draw() {
  delay(10);
  background(0);
  for (int y=0;y<m.height;y++) {
    for (int x=0;x<m.width;x++) {

      color thisPixelColor = m.get(x, y);

      //set(x, y, thisPixelColor);
      float r = red(thisPixelColor);
      float g = green(thisPixelColor);
      float b = blue(thisPixelColor);

      int v = int(random(3));

      float averageValue = (r+g+b)/3; 
      if (r >= g && r >= b) {
        set(x, y, color(255, 255-r, 255-r));
      } 
      else if (g >= b) { 
        set(x, y, color(255-g, 255, 255-g));
      }
      else {
        set(x, y, color(255-b, 255-b, 255));
      }
    }
  }
}


