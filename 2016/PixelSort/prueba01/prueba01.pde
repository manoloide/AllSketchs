PImage ori, after;

void setup() {
  size(960, 960);

  ori = loadImage("dadasd.jpg");
  generate();
}


void draw() {
  image(ori, 0, 0);
  //image(after, ori.width, 0);
}

void generate() {
  after = createImage(ori.width, ori.height, RGB);
  after = ori.get();
  after.loadPixels();

  for (int j = 0; j < after.height; j++) {
    int des = j*after.width;
    for (int i = 0; i < after.width; i++) {
      int sel = des+i;
      float val = -1;
      for (int k = i; k < after.width; k++) {
        color aux = after.pixels[des+k];
        float b = brightness(aux);
        if (b > val) {
          sel = des+k;
          val = b;
        }
      }
      color aux = after.pixels[sel];
      after.pixels[sel] = after.pixels[des+i];
      after.pixels[des+i] = aux;
    }
  }

  after.updatePixels();
}