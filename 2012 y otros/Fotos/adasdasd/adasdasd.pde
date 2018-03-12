void setup() {
  size(600, 400);
  image(loadImage(), 0, 0);
}

void draw() {
  for (int i = 0; i < 1000; i++) {
    color col = get(int(random(width)), int(random(height)));
    set(int(random(width)), int(random(height)), col);
  }
}

