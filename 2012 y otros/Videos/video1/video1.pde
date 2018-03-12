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
  background(0);
  for (int y=0;y<height;y++) {
    for (int x=0;x<width;x++) {

      color thisPixelColor = m.get(x, y);

      //set(x, y, thisPixelColor);
      float r = red(thisPixelColor);
      float g = green(thisPixelColor);
      float b = blue(thisPixelColor);

      int v = int(random(3));

      float averageValue = (r+g+b)/3; 
      if (averageValue < 127) {
        set(x, y, color(0));
      } 
      else { 
        set(x, y, color(255));
      }
    }
  }
}



