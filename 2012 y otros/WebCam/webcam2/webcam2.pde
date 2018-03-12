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
  color col;
  int lu = int(cy * img.width + cx);
  col = img.pixels[lu];
  col = color(red(col),green(col),blue(col),random(155,256));
  return col;
}

