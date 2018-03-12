float px, py;
PImage fondo, img2;
void setup() {
  size(800, 600);
  fondo = createImage(800, 600, ARGB);
  img2 = createImage(800, 600, ARGB);
  background(0);
}

void draw() {
  px += (mouseX-width/2)/50;
  if (px >= width) {
    px -= width;
  }
  else if (px < 0) {
    px += width;
  }
  py += (mouseY-height/2)/50;
  if (py >= height) {
    py -= height;
  }
  else if (py < 0) {
    py += height;
  }
  image(fondo, px-width, py-height);
  image(fondo, px, py-height);
  image(fondo, px+width, py-height);
  image(fondo, px-width, py);
  image(fondo, px, py);
  image(fondo, px+width, py);
  image(fondo, px-width, py+height);
  image(fondo, px, py+height);
  image(fondo, px+width, py+height);
}

void mousePressed() {
  int tam = int(random(10, 60))*2;
  rectangulo(fondo, int(width/2-px)-tam/2, int(height/2-py)-tam/2, tam, tam);
}

void rectangulo(PImage ori, int x, int y, int w, int h) {
  int iw = ori.width;
  int ih = ori.height;
  ori.loadPixels();
  colorMode(HSB, 256);
  color col = color(random(256), map(mouseX,0,width,0,256), map(mouseY,0,height,0,256));
  colorMode(RGB);
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      ori.set((x+i+iw)%iw, (y+j+ih)%ih, lerpColor(col,color(random(256), random(256), random(256)),0.2));
    }
  }
  ori.updatePixels();
}

