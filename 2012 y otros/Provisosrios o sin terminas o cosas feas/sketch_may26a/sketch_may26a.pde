color img[][];

void setup() {
  size(600, 600);
  img = new color[width][height];
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      img[i][j] = color(200, 40, 30);
    }
  }
}

void draw() {
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      //color efecto
      img[i][j] = color(red(img[i][j])+random(-2,3),green(img[i][j])+random(-2,3),blue(img[i][j])+random(-2,3));
      set(i,j,img[i][j]);
    }
  }
}

