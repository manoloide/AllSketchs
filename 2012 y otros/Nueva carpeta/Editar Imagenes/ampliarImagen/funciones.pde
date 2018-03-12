
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

void cargarImage(File sel) { 
  if (sel != null) {
    img = loadImage(sel.getAbsolutePath());
    println("Se cargo: "+sel.getAbsolutePath());
  }
  else {
    println("Error no se pudo cargar.");
  }
}

