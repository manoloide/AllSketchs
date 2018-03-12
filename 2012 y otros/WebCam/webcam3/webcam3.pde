PImage img;

//para la camara
import codeanticode.gsvideo.*;
GSCapture cam;

void setup() {
  size(640, 480);
  frameRate(20);
  background(0);
  noStroke();
  //arrancar camara
  cam = new GSCapture(this, 640, 480);
  cam.start(); 
  

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
  color col;
  int lu = int(cy * img.width + cx);
  col = img.pixels[lu];
  col = color(red(col),green(col),blue(col));
  return col;
}

