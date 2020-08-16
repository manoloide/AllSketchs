void montainsBack(float y, float h, float det) {
  float des = random(100);
  beginShape();
  vertex(0, y);
  for (int i = 0; i < width; i++) {
    float hh = -noise(des+i*det*200, 70+i)*h;
    vertex(width, y+hh);
  }
  vertex(width, y);
  endShape(CLOSE);
}

void montains(float y, float h, float det) {
  float des = random(100);
  beginShape();
  vertex(0, y);
  for (int i = 0; i < width; i++) {
    float hh = -noise(des+i*det)*h;
    vertex(width, y+hh);
  }
  vertex(width, y);
  endShape(CLOSE);
}
