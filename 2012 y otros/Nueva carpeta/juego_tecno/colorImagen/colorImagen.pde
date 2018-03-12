PImage graficos, luz; 
PImage[][] sprites; 
void setup() {
  size(600, 600);
  graficos = loadImage("../graficos.png");
  sprites = recortarImagen(graficos, 20, 20, 2);
}

void draw() {
  if (frameCount%10 == 0) {
    int time = int(map(mouseY, 0, height, 0, 100));
    luz = oscurecer(graficos, time);
    sprites = recortarImagen(luz, 20, 20, 2);
  }
  for (int j = 0; j < height/40; j++) {
    for (int i = 0; i < width/40; i++) {
      image(sprites[0][0], i*40, j*40);
    }
  }
  image(sprites[0][1], 4*40, 6*40);
  image(sprites[0][1], 5*40, 7*40);
  image(sprites[0][1], 9*40, 6*40);
  image(sprites[0][1], 10*40, 6*40);
  image(sprites[1][1], 1*40, 6*40);
  image(sprites[1][1], 1*40, 6*40);
  image(sprites[1][1], 14*40, 1*40);
  image(sprites[1][1], 2*40, 9*40);
  image(sprites[0][2], 6*40, 7*40);
  image(sprites[0][7], 5*40, 5*40);
  image(sprites[1][7], 6*40, 5*40);
  image(sprites[1][8], 6*40, 6*40);
  image(sprites[0][8], 5*40, 6*40);
  image(sprites[0][6], 7*40, 9*40);
}

PImage oscurecer(PImage img, int osc) {
  int w = img.width;
  int h = img.height;
  PImage aux = createImage(w, h, ARGB);
  aux.loadPixels();
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      float r, g, b, p, o;
      color c = img.get(i, j);
      r = red(c);
      g = green(c);
      b = blue(c);
      p = (r+g+b)/3;
      o = osc;
      r = r-o;
      g = g-o;
      b = b-o;
      c = color(r, g, b, alpha(c));
      aux.set(i, j, c);
    }
  }
  aux.updatePixels();
  return aux;
}



PImage[][] recortarImagen(PImage ori, int ancho, int alto, int es) {
  int cw = ori.width/ancho;
  int ch = ori.height/alto;
  PImage res[][] = new PImage[cw][ch];
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      PImage aux = createImage(ancho, alto, ARGB);
      aux.copy(ori, i*ancho, j*alto, ancho, alto, 0, 0, ancho, alto);
      res[i][j] = ampliar(aux, es);
    }
  }
  return res;
}

PImage ampliar(PImage ori, int es) {
  int ancho =  ori.width; 
  int alto = ori.height;
  PImage res = createImage(ancho*es, alto*es, ARGB);
  for (int j = 0; j < alto; j++) {
    for (int i = 0; i < ancho; i++) {
      color col = ori.get(i, j);
      for (int k = 0; k < es; k++) {
        for (int l = 0; l < es; l++) {
          res.set(i*es+l, j*es+k, col);
        }
      }
    }
  }
  return res;
}

