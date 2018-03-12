class Dibujador {
  float x, y, vx, vy, r, g, b;

  Dibujador(float nx, float ny) {
    x = nx;
    y = ny;
    r = 53;
    g = random(255);
    b = random(255);
  } 

  void act() {
    int c = 2;
    vx = x;
    vy = y;
    y += random(10);
    x += random(-2, 2);

    r += random(-random(1), random(1));
    g += random(-random(c), random(c));
    b += random(-random(c), random(c));
    strokeWeight(random(1,6));
    stroke(r, g, b, random(100,200));
    line(vx, vy, x, y);
        if (y > height) {
      y = 0;
    }
    if (x > width) {
      x -= 1;
    }
    if (x < 0) {
      x += 1;
    }
  }
}

