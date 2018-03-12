void actDis() {
  Disparo aux;

  noStroke();
  fill(255);
  for (int c = 0; c < disparos.size(); c++) {
    fill(255);
    aux = (Disparo) disparos.get(c);
    int rad = 5;

    float dim = aux.dim/2;
    for (int i = int(aux.y - dim); i < aux.y + dim; i++) {
      int lu = i * pared.width;
      for (int j = int(aux.x - dim); j < aux.x+ dim; j++) {
        if ((i>=0)&&(i<pared.height)&&(j<pared.width)&&(j>=0)) {
          if (pared.pixels[lu+j] != color(0, 0)) {
            circulo(pared, round(aux.x), round(aux.y),1);
            disparos.remove(c);
            c--;
          }
        }
      }
    }
    aux.mover();
    aux.draw();
  }
}

void actBom() {
  Bomba aux;
  for (int i = 0; i < bombas.size(); i++) {
    aux = (Bomba) bombas.get(i);
    aux.mover();
    if (colision(pared, aux)) {
      circulo(pared, aux.x, aux.y, random(10, 30));
      bombas.remove(i);
      i--;
    }
    fill(255, 20, 23);
    aux.draw();
  }
}

boolean colision(PImage img, Bomba aux) {
  float dim = aux.dim/2;
  for (int i = int(aux.y - dim); i < aux.y + dim; i++) {
    int lu = i * img.width;
    for (int j = int(aux.x - dim); j < aux.x+ dim; j++) {
      if ((i>=0)&&(i<img.height)&&(j<img.width)&&(j>=0)) {
        if (img.pixels[lu+j] != color(0, 0)) {
          return true;
        }
      }
    }
  }
  return false;
}

