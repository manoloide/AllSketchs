

void IPdisplace(float dr, float dg, float db) {
  image(IPdisplace(g.get(), dr, dg, db), 0, 0);
}

PImage IPdisplace(PImage ori, float dr, float dg, float db) {
  pushStyle();
  colorMode(RGB);
  PImage aux = createImage(ori.width, ori.height, RGB);
  aux.loadPixels();
  for (int j = 0; j < ori.height; j++) {
    for (int i = 0; i < ori.width; i++) {
      float r = red(ori.get((int)(i+dr), j));//int(i-dr), j);
      float g = green(ori.get((int)(i+dg), j));//int(i-dg), j);
      float b = blue(ori.get((int)(i+db), j));//int(i-db), j);
      color col = color(r, g, b); 
      aux.set(i, j, col);
    }
  }
  aux.updatePixels();
  popStyle();
  return aux;
}



PImage IPnoise(float amount) {
  return IPnoise(g, amount, false);
}

PImage IPnoise(PImage ori, float amount) {
  return IPnoise(ori, amount, false);
}

PImage IPnoise(float amount, boolean col) {
  return IPnoise(g, amount, col);
}

PImage IPnoise(PImage ori, float amount, boolean col) {
  pushStyle();
  colorMode(RGB);
  int w = ori.width;
  int h = ori.height;
  loadPixels();
  for (int i = 0; i < ori.pixels.length; i++) {
    int cc;
    if (col) {
      cc = color(random(255), random(255), random(255));
    } else {
      cc = color(random(255));
    }
    ori.pixels[i] = lerpColor(ori.pixels[i], cc, amount);
  }
  ori.updatePixels();
  popStyle();
  return ori;
}

void IPvignette(float inte) {
  image(IPvignette(g.get(), inte), 0, 0);
}

void IPvignette(float inte, int nc) {
  image(IPvignette(g.get(), inte, nc), 0, 0);
}

PImage IPvignette(PImage ori, float inte) {
  return IPvignette(ori, inte, color(0));
}

PImage IPvignette(PImage ori, float inte, int nc) {
  pushStyle();
  colorMode(RGB);
  ori.loadPixels();
  float cx = ori.width/2;
  float cy = ori.height/2;
  color cc = color(red(nc), green(nc), blue(nc));
  float diag = dist(0, 0, cx, cy);
  diag *= diag;
  for (int j = 0; j < ori.height; j++) {
    for (int i = 0; i < ori.width; i++) {
      float v = pow(cx-i, 2)+pow(cy-j, 2);
      int col = lerpColor(ori.get(i, j), color(cc), map(v, 0, diag, 0, inte)); 
      ori.set(i, j, col);
    }
  }
  ori.updatePixels();
  popStyle();

  return ori;
}
