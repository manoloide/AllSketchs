class Meta {
  float x, y, tam; 

  Meta(float nx, float ny) {
    x = nx;
    y = ny;
    tam = 20;
  }

  void draw() {
    noStroke();
    fill(random(255), random(255), 255);
    rect(x, y, 10, 10);
    fill(random(255), random(255), 255);
    rect(x-10, y, 10, 10);
    fill(random(255), random(255), 255);
    rect(x, y-10, 10, 10);
    fill(random(255), random(255), 255);
    rect(x-10, y-10, 10, 10);
  }
}

