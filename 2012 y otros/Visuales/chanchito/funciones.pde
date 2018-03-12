void lineas() {
  for (int i = 0; i < 30; i++) {
    float p1x, p1y, p2x, p2y;
    p1x = random(width+300)-150;
    p1y = random(width+300)-150;
    p2x = random(width+300)-150;
    p2y = random(width+300)-150;

    stroke(random(255), random(255), random(255));
    line(p1x, p1y, p2x, p2y);
  }
}
void circulos() {
  for (int i = 0; i < 30; i++) {
    float p1x, p1y, anc;
    p1x = random(width+300)-150;
    p1y = random(width+300)-150;
    anc = random(400)+100;

    noStroke();
    fill(random(255), random(255), random(255), random(255));
    ellipse(p1x, p1y, anc, anc);
  }
}

void imagen() {
  image(img1, random(width-img1.width), random(height-img1.height));
}
void imagen2() {
  image(img2, random(width-img1.width), random(height-img1.height));
}


void ratonsuelo() {
  float p1x, p1y, p2x, p2y, p3x, p3y, ang, anc;
  anc = 30 + random(200);
  ang = random(2*PI);

  p1x = cos(ang) * anc + mouseX;
  p1y = sin(ang) * anc + mouseY;
  p2x = cos(ang+2*PI/3) * anc + mouseX;
  p2y = sin(ang+2*PI/3) * anc + mouseY;
  p3x = cos(ang+2*PI/3*2) * anc + mouseX;
  p3y = sin(ang+2*PI/3*2) * anc + mouseY;
  colorMode(HSB);
  noStroke();
  fill(random(255), 100, 100, random(255));
  triangle(p1x, p1y, p2x, p2y, p3x, p3y);
  colorMode(RGB);
}

void superpelotitas() {
  colorMode(HSB,255);
  noStroke();
  for (int i = 0; i < 50; i++) {
    fill(random(255),255,127,80);
    ellipse(random(width),random(height),20,20);
  }
  colorMode(RGB);
}
void superpelotitas2() {
  colorMode(HSB,255);
  noStroke();
  for (int i = 0; i < 50; i++) {
    fill(random(255),255,127);
    ellipse(random(width),random(height),30,30);
  }
  colorMode(RGB);
}

