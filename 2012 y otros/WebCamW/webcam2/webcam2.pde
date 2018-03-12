PImage img;

//para la camara
import processing.video.*;
Capture cam;

void setup() {
  size(640, 480);
  frameRate(60);
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
  
  for (int v = 0; v < 1000;v++) {
    x = int(random(width));
    y = int(random(height-1));
    col = calcular(x, y);
    float ancho = random(1,3);
       
    fill(col);
    ellipse(x,y, ancho,ancho);
  }
}


color calcular(float cx, float cy) {
  if (img == null) return 0;
  color col;
  int lu = int(cy * img.width + cx);
  col = img.pixels[lu];
  col = color(red(col),green(col),blue(col),random(155,256));
  return col;
}
