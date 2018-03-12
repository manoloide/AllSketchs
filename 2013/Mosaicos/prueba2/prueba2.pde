color col;
float px, py;
int tiempo = 0;
PImage fondo;

void setup() {
  size(800, 600);
  colorMode(HSB, 256);
  fondo = createImage(800, 600, ARGB);
  background(0);
}

void draw() {
  noStroke();
  fill(0);
  rect(0, 0, width, height);
  px -= (mouseX-width/2)/50;
  if (px >= width) {
    px -= width;
  }
  else if (px < 0) {
    px += width;
  }
  py -= (mouseY-height/2)/50;
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

  if (mousePressed) {
    tiempo++;
    col = color(map(mouseX, 0, width, 0, 256),map(dist(mouseX,mouseY,width/2,height/2),0,height/2,-40,260), map(mouseY, 0, height, 0, 256));
    noFill();
    stroke(col);
    strokeWeight(2);
    int tam = tiempo*2;
    rect(width/2-tam/2, height/2-tam/2, tam, tam);
    line(width/2-tam/3, height/2-tam/3, width/2+tam/3, height/2+tam/3);
    line(width/2+tam/3, height/2-tam/3, width/2-tam/3, height/2+tam/3);
  }
}

void mouseReleased() {
  int tam = tiempo*2;
  rectangulo(fondo, int(width/2-px)-tam/2, int(height/2-py)-tam/2, tam, tam);
  tiempo = 0;
}

void rectangulo(PImage ori, int x, int y, int w, int h) {
  int iw = ori.width;
  int ih = ori.height;
  ori.loadPixels();
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      int ix = (x+i+iw)%iw;
      int iy = (y+j+ih)%ih;
      //con ruido
      //ori.set(ix, iy, lerpColor(ori.get(ix, iy), (lerpColor(col, color(random(256), random(256), random(256)), 0.15)), 0.7));
      ori.set(ix, iy, lerpColor(ori.get(ix, iy), col, 1));
    }
  }
  ori.updatePixels();
}

