int escala;
PImage sprites;
PImage fondo[];

void setup() {
  size(640, 480);
  escala = 2;
  sprites = loadImage("../sprites.png");
  fondo = recortarImagenes(recortarImagen(sprites, 0, 0, 32, 16), 16, 16, escala);
}

void draw() {
  for (int j = 0; j < height/ (16 * escala);j++) { 
    for (int i = 0; i < width/ (16 * escala);i++) {
      if(j >  width/ (16 * escala)/3){
      image(fondo[1], i * escala * 16, j *  escala * 16);
      }else{
        image(fondo[0], i * escala * 16, j *  escala * 16);
      }
    }
  }
}

PImage expandirImage(PImage ori, int es) {
  int wo = ori.width;
  int ho = ori.height;
  PImage nue = createImage(wo*es, ho*es, ARGB);
  nue.loadPixels();
  for (int j = 0; j < ho; j++) {
    for (int i = 0; i < wo; i++) {
      color col = ori.get(i, j);
      for (int dj = 0; dj < es; dj++) {
        for (int di = 0; di < es; di++) {
          nue.set(i*es+di, j*es+dj, col);
        }
      }
    }
  }  
  nue.updatePixels();
  return nue;
}

PImage recortarImagen(PImage ori, int x, int y, int w, int h) {
  PImage aux = createImage(w, h, ARGB);
  aux.copy(ori, x, y, w, h, 0, 0, w, h);
  return aux;
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

PImage[] recortarImagenes(PImage ori, int ancho, int alto, int es) {
  int cant = ori.width/ancho;
  PImage res[] = new PImage[cant];
  for (int i = 0; i < cant; i++) {
    PImage aux = createImage(ancho, alto, ARGB);
    aux.copy(ori, i*ancho, 0, ancho, ori.height, 0, 0, ancho, alto);
    res[i] = ampliar(aux, es);
  }
  return res;
}

