PImage img;

//para la camara
import processing.video.*;
Capture cam;
void setup() {
  size(640, 480);
  frameRate(20);
  background(0);
  noStroke();
  //arrancar camara
    String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  cam.start();
  img = null; 
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    //image(cam, 0, 0);
    img = cam;
  }
  float x, y;
  color col;
  
  for (int v = 0; v < cam.width* cam.height;v++) {
    x = int(random(width));
    y = int(random(height-1));
    col = calcular(x, y);
    set(int(x),int(y),col);
  }
}


color calcular(float cx, float cy) {
  if(img == null) return 0;
  color col;
  int lu = int(cy * img.width + cx);
  col = img.pixels[lu];
  col = color(red(col),green(col),blue(col));
  return col;
}
