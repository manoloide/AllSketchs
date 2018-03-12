float x, dirx, y, diry, vel, dim, rad;

void setup() {
  size(600, 600);
  smooth();
  dirx = 1;
  diry = 1;
  vel = 1;

  dim = 100;
  rad = dim/2;

  x = random(rad, width-rad);
  y = random(rad, height-rad);
}

void draw() {
  background(0);
  x += vel * dirx;
  y += vel * diry;
  if (x < rad || x > width-rad) {
    dirx *= -1;
  }
  if (y < rad || y > height-rad) {
    diry *= -1;
  } 
  ellipse(x, y, dim, dim);
}

void mousePressed() {
  x = random(rad, width-rad);
  y = random(rad, height-rad);
}

