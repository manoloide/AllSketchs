
void cargarImagen(PImage img) {
  loadPixels();
  int c=0;
  for (int y=0; y<img.height; y++) { 
    for (int x=0; x<img.width; x++) { 
      img.pixels[c]=color(255, 166, 0);
      c++;
    }
  } 
  updatePixels();
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

void punto(PImage img, int x, int y) {
  int i = x + y * img.width;
  img.loadPixels();
  img.pixels[i] = color(0, 0);
  img.updatePixels();
}

