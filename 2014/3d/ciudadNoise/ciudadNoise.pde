import peasy.*;

PeasyCam cam;
PGraphics gra;
PVector position;

void setup() {
  size(720, 480, P3D);
  smooth(16);
  cam = new PeasyCam(this, 100);
  position = new PVector();
  //gra = generarCiudad(2048, 2048, position);
}

void draw() {
  background(230);
  translate(width/2, height/2, -300);
  rectCity();
}


void keyPressed() {
  //gra = generarCiudad(2048, 2048, position);
}

void rectCity() {
  int w = width*3;
  int h = height*3;
  float esc = 0.08;
  float grid = 32;
  int sep = 7;
  for (int j = 0; j < h; j+=grid) {
    for (int i = 0; i < w; i+=grid) {
      pushMatrix();
      float alt = 0;
      fill(0);
      if (!(i%(grid*sep) == 0) && !(j%(grid*sep) == 0)) {
        alt = noise(i*esc, j*esc)*noise(i*esc, j*esc)*100;
        colorMode(HSB, 256, 256, 256);
        fill(64+alt*0.5, 200, 200);
      }
      translate(i, -alt/2, j);
      box(grid, alt, grid);
      popMatrix();
    }
  }
}

PGraphics generarCiudad(int w, int h, PVector pos) {
  PGraphics aux = createGraphics(w, h);
  aux.beginDraw();
  float esc = 0.008;
  float grid = 32;
  int sep = 7;
  aux.noStroke();
  for (int j = 0; j < h; j+=grid) {
    for (int i = 0; i < w; i+=grid) {
      color col = color(0);
      if (!(i%(grid*sep) == 0) && !(j%(grid*sep) == 0)) {
        col = color(noise(i*esc, j*esc)*256);
      }
      aux.fill(col);
      aux.rect(i, j, grid, grid);
    }
  }
  //aux.background(10);
  aux.endDraw();
  return aux;
}
