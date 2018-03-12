PImage img, aimg;

void setup() {
  size(400, 400);
  img = createImage(width, height, RGB);
  aimg = createImage(width, height, RGB);
  for (int i = 0; i < img.width*img.height; i++) {
    img.pixels[i] = (random(2) < 1)?color(0):color(255);
  }
}

void draw() {
  aimg.copy(img, 0, 0, width, height, 0, 0, width, height);
  img.loadPixels();
  for (int i = 0; i < 1000; i++) {
    color col = (random(2) < 1)? color(0): color(256); 
    int x = int(random(width));
    int y = int(random(height));
    aimg.set(x,y,col);
  }
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int n = 0;
      for (int dy = -1; dy <= 1; dy++) {
        for (int dx = -1; dx <= 1; dx++) {
          if (x+dx < 0 || x+dy >= width) continue;
          if (y+dy < 0 || y+dy >= height) continue;
          if (red(aimg.get(x+dx, y+dy)) < 1) {
            n++;
          }
        }
      }
      if (n > 4) {
        img.set(x, y, color(0));
      }
      else {
        img.set(x, y, color(255));
      }
    }
  }
  img.updatePixels();
  image(img, 0, 0);
}

