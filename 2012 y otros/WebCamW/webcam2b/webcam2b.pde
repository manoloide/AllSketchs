PImage img;
scrollH s1,s2,s3,s4,s5;

float cantidad = 1000; 
float alphaMin = 10;
float alphaMax = 200;
float anchoMin = 1;
float anchoMax = 10;

//para la camara
import processing.video.*;
Capture cam;

void setup() {
  size(840, 480);
  frameRate(60);
  background(0);
  noStroke();
  smooth();
  //arrancar camara
    String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  cam.start();
  img = null; 
  //gui
  s1 = new scrollH(650, 10, 180, 10, 100, 3000, 1000, "cant");
  s2 = new scrollH(650, 30, 180, 10, 0, 255, 10, "alphaMin");
  s3 = new scrollH(650, 50, 180, 10, 0, 255, 10, "alphaMax");
  s4 = new scrollH(650, 70, 180, 10, 0, 100, 1, "anchoMin");
  s5 = new scrollH(650, 90, 180, 10, 0, 100, 10, "anchoMax");
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    //image(cam, 0, 0);
    img = invertirImagen(cam);
  }
  float x, y;
  color col;
  
  for (int v = 0; v < cantidad;v++) {
    x = int(random(width-200));
    y = int(random(height-1));
    col = calcular(x, y);
    float ancho = random(anchoMin,anchoMax);
       
    fill(col);
    ellipse(x,y, ancho,ancho);
  }
  //act
  fill(80);
  rect(640,0,200,height);
  s1.act();
  cantidad = s1.val;
  s2.act();
  alphaMin = s2.val;
  s3.act();
  alphaMax = s3.val;
  s4.act();
  anchoMin = s4.val;
  s5.act();
  anchoMax = s5.val;
}


color calcular(float cx, float cy) {
  if(img == null) return 0;
  color col;
  int lu = int(cy * img.width + cx);
  col = img.pixels[lu];
  col = color(red(col),green(col),blue(col),random(alphaMin,alphaMax));
  return col;
}

PImage invertirImagen (PImage original) {
  PImage invertida = createImage(original.width, original.height, RGB);
  original.loadPixels();
  invertida.loadPixels();
  for (int x=0; x<original.width; x++) {
    for (int y=0; y<original.height; y++) {
      int loc = (original.width - x - 1) + y * original.width;
      color c = original.pixels[loc];
      invertida.pixels[x + y * original.width] = c;
    }
  }
  return invertida;
}
