void actLuz() {
  int osc = 0;
  switch(nivel.clima.hora) {
    case(0):
    osc = 45;
    break;
    case(1):
    osc = 45;
    break;
    case(2):
    osc = 45;
    break;
    case(3):
    osc = 45;
    break;
    case(4):
    osc = 40;
    break;
    case(5):
    osc = 35;
    break;
    case(6):
    osc = 20;
    break;
    case(7):
    osc = 5;
    break;
    case(8):
    osc = 4;
    break;
    case(9):
    osc = 3;
    break;
    case(10):
    osc = 2;
    break;
    case(11):
    osc = 1;
    break;
    case(12):
    osc = 0;
    break;
    case(13):
    osc = -2;
    break;
    case(14):
    osc = -4;
    break;
    case(15):
    osc = -6;
    break;
    case(16):
    osc = -6;
    break;
    case(17):
    osc = -4;
    break;
    case(18):
    osc = 0;
    break;
    case(19):
    osc = 5;
    break;
    case(20):
    osc = 15;
    break;
    case(21):
    osc = 30;
    break;
    case(22):
    osc = 40;
    break;
    case(23):
    osc = 40;
    break;
  }
  PImage aux = oscurecer(recortar(sprite, 0, 0, 80, 180), osc);
  sprites = recortarImagen(aux, 20, 20, 2);
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

PImage colorImagen(PImage img, color col) {
  int ancho =  img.width; 
  int alto = img.height;
  PImage res = createImage(ancho, alto, ARGB);
  for (int j = 0; j < alto; j++) {
    for (int i = 0; i < ancho; i++) {
      color ac = img.get(i, j);
      if (alpha(ac) > 128) {
        res.set(i, j, col);
      }
      else {
        res.set(i, j, color(0, 0));
      }
    }
  }
  return res;
}

PImage recortar(PImage ori, int x, int y, int w, int h) {
  PImage aux = createImage(w, h, ARGB);
  aux.copy(ori, x, y, w, h, 0, 0, w, h);
  return aux;
}

PImage[][] recortarImagen(PImage ori, int ancho, int alto, int es) {
  int cw = ori.width/ancho;
  int ch = ori.height/alto;
  PImage res[][] = new PImage[cw][ch];
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      PImage aux = recortar(ori, i*ancho, j*alto, ancho, alto);
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

/*
PImage[][] recortarImagen(String name, int ancho, int alto, int es) {
 PImage ori = loadImage(name);
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
 */
