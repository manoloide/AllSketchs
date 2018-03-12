import processing.video.*;
Movie m;

void setup() {
  size(640, 480);
  m = new Movie(this, "../v2.MOV"); 
  m.loop();
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
      
      switch(v){
         case 0:  set(x, y, color(255,0,0,r));break;
         case 1:  set(x, y, color(0,255,0,g));break;
         case 2:  set(x, y, color(0,0,255,b));break;
      }
    }
  }
}


void movieEvent(Movie m) {
  m.read();
}

