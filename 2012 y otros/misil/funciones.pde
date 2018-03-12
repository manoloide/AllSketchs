void actMis() {
  Misil aux;
  for (int i = 0; i < misiles.size(); i++) {
    aux = (Misil) misiles.get(i);
    aux.act();
    if (colision(suelo, aux)) {
      circulo(suelo, aux.x, aux.y, random(10, 30));
      misiles.remove(i);
      i--;
    }
  }
}

boolean colision(PImage img, Misil aux) {
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

void rectImg(PImage img, int x1, int y1, int x2, int y2){
  img.loadPixels();
  for (int y=y1; y<y2; y++) { 
    for (int x=x1; x<x2; x++) { 
      img.pixels[y*(x2-x1)+x]=color(127);
    }
  } 
  img.updatePixels();
}

void circulo(PImage img, float cx, float cy, float dis) {
  for (int i = int(round(cy - dis)); i <= cy + dis; i++) {
    int lu = i * img.width;
    for (int j = int(round(cx - dis)); j <= cx+ dis; j++) {
      if ((i>=0)&&(i<img.height)&&(j<img.width)&&(j>=0)) {
        if (dist(j, i, cx, cy) <= dis) {
          img.loadPixels();
          img.pixels[lu+j] = color(0, 0);
          img.updatePixels();
        }
      }
    }
  }
}
