class Dibujador {
  float x, y, vx, vy, r, g, b;

  Dibujador(float nx, float ny) {
    x = nx;
    y = ny;
    r = random(255);
    g = random(255);
    b = random(255);
  } 

  void act() {
    float c = s2.val;
    vx = x;
    vy = y;
    y += random(s3.val);
    x += random(-s6.val, s6.val);

    r += random(-random(c), random(c));
    g += random(-random(c), random(c));
    b += random(-random(c), random(c));
    strokeWeight(random(1, s1.val));
    stroke(r, g, b, random(s4.val, s5.val));
    line(vx, vy, x, y);
    if (y > height) {
      y = 0;
    }
    else if (y < 0) {
      y = height;
    }
    if (x > width-200) {
      x -= 1;
    }
    if (x < 0) {
      x += 1;
    }
  }
}

