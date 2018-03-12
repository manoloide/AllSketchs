int cant = 2;
float th, tv;

void setup() {
  size(400, 400);
  th = width/cant;
  tv = height/cant;
  for (int j = 0; j < cant; j++) {
    for (int i = 0; i < cant; i++) {
      rect(i*th, j*tv, th, tv);
    }
  }
}

void draw() {
  fill(0);
  int x = int(mouseX/th);
  int y = int(mouseY/tv);
  rect(x*th, y*tv, th, tv);
}

