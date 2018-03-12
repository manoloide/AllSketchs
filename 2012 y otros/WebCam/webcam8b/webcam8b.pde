import codeanticode.gsvideo.*;

GSCapture video;
PImage img;

int tam = 9;
int alfa = 9;

void setup() { 
  size(640, 480);
  frameRate(15);
  //video
  video = new GSCapture(this, width, height);
  video.start();
  noStroke();
}

void draw() {
  if (video.available()) {
    //lee la camara
    video.read();
    img = invertirImagen(video);
  }
  for (int y = 0; y < height; y+=tam) {
    for (int x = 0; x < width; x+=tam) {
      int r = 0;
      int g = 0;
      int b = 0;
      for (int j = y; j < y+tam; j++) {
        int alto = y * img.width;
        for (int i = x; i < x+tam; i++) {
          color col;
          col = img.pixels[alto+x];
          r += red(col);
          g += green(col);
          b += blue(col);
        }
      }
      r /= tam*tam;
      g /= tam*tam;
      b /= tam*tam;
      fill(r, g, b, alfa);
      rect(x, y, tam, tam);
    }
  }
  //background(img);
}

void stop() {
  video.stop();
  super.stop();
}

color calcular(float cx, float cy) {
  color col;
  int lu = int(cy * img.width + cx);
  col = img.pixels[lu];
  col = color(red(col), green(col), blue(col), 10);
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

