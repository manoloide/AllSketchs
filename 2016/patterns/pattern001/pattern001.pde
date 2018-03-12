void setup() {
  size(1920, 370);
  background(60);
  noStroke();

  fill(255, 30);
  for (int j = 0; j <= height+4; j+=10) {
    for (int i = 0; i <= width+4; i+=10) {
      ellipse(i, j, 2, 2);
    }
  }

  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(20, 100)*random(0.1, 1)*random(0.4, 1);
    colorMode(RGB);
    color col = lerpColor(color(#fa798e), color(255), random(0.5)*random(1));
    colorMode(HSB);
    col = color(hue(col), saturation(col)+random(60), brightness(col));

    if (random(1) < 0.6) {
      fill(0, 40);
      x += 4; 
      y += 4;
      ellipse(x, y, s, s);
      ellipse(x+width, y, s, s);
      ellipse(x-width, y, s, s);
      ellipse(x, y+height, s, s);
      ellipse(x, y-height, s, s);
      fill(col);
      x -= 4; 
      y -= 4;
      ellipse(x, y, s, s);
      ellipse(x+width, y, s, s);
      ellipse(x-width, y, s, s);
      ellipse(x, y+height, s, s);
      ellipse(x, y-height, s, s);
    } else {
      fill(0, 40);
      x += 4; 
      y += 4;
      piram(x, y, s);
      piram(x+width, y, s);
      piram(x-width, y, s);
      piram(x, y+height, s);
      piram(x, y-height, s);
      fill(col);
      x -= 4; 
      y -= 4;
      piram(x, y, s);
      piram(x+width, y, s);
      piram(x-width, y, s);
      piram(x, y+height, s);
      piram(x, y-height, s);
    }
  }

  saveFrame("back.png");
}

void piram(float x, float y, float s) {
  s *= 0.5;
  beginShape();
  vertex(x-s, y);
  vertex(x, y-s);
  vertex(x+s, y);
  vertex(x, y+s);
  endShape(CLOSE);
}