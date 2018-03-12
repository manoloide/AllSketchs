void setup() {
  size(600, 600);
}

void draw() {
}

void mousePressed() {
  background(255);
  noStroke();
  fill(0);
  for(int j = 0; j < 4; j++){
    for(int i = 0; i < 4; i++){
      logo(50+125*i,50+125*j,100,4,0.5);
    }
  }
}

void logo(float x, float y, float tam, int cant, float por) {
  float t = tam/cant;
  for (int j = 0; j < cant; j++) {
    for (int i = 0; i < cant; i++) {
      if (random(1) < por) {
        rect(x+i*t, y+j*t, t, t);
      }
    }
  }
}

