PImage img, ret;

void setup() {
  size(1280, 716);
  img = loadImage("vilma.jpg");
  ret = retocar(img);
}

void draw() {
  image(ret, 0, 0);
}

PImage retocar(PImage img) {
  PImage aux = createImage(width, height, ARGB);
  aux.loadPixels();
  for (int j = 0; j < height; j++) {
    int r = 0;
    int g = 0;
    int b = 0;
    for (int i = 0; i < width; i++) {
      color col = img.get(i, j);
      r += red(col);
      g += green(col);
      b += blue(col);
    }
    for (int i = 0; i < width; i++) {
      aux.set(i, j, color(r/width, g/width, b/width));
    }
  }
  for (int j = 0; j < width; j++) {
    int r = 0;
    int g = 0;
    int b = 0;
    for (int i = 0; i < height; i++) {
      color col = img.get(j, i);
      r += red(col);
      g += green(col);
      b += blue(col);
    }
    for (int i = 0; i < height; i++) {
      color act = color(r/height, g/height, b/height);
      aux.set(j, i, lerpColor(aux.get(j, i),act,0.5));
    }
  }
  aux.updatePixels();
  return aux;
}

