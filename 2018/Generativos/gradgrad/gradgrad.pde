int seed = int(random(999999));
void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(rcol());

  noStroke();
  float diag = width*1.42;
  for (int i = 0; i < 40; i++) {
    float x = random(width);
    float y = random(height);
    float a = random(TWO_PI);
    float hh = width*0.2*random(0.1, 1);
    int col = rcol();
    float alp = random(500*random(1));

    int cw = int(random(6, 130));
    int ch = int(random(6, 30));
    float sw = diag*2./cw;
    float sh = hh/ch;

    pushMatrix();
    translate(x, y);
    rotate(a);
    if (random(1) < 0.5) {
      beginShape();
      fill(col, 0);
      vertex(-diag, -hh);
      vertex(+diag, -hh);
      fill(col, alp);
      vertex(+diag, +hh);
      vertex(-diag, +hh);
      endShape(CLOSE);
    } else {
      for (int k = 0; k < ch; k++) {
        for (int j = 0; j < cw; j++) {
          if ((j+k)%2 == 0) continue;
          float a1 = map(k+0, 0, ch, 0, alp);
          float a2 = map(k+1, 0, ch, 0, alp);
          beginShape();
          fill(col, a1);
          vertex(-diag+(j+0)*sw, -hh+(k+0)*sh);
          vertex(-diag+(j+1)*sw, -hh+(k+0)*sh);
          fill(col, a2);
          vertex(-diag+(j+1)*sw, -hh+(k+1)*sh);
          vertex(-diag+(j+0)*sw, -hh+(k+1)*sh);
          endShape(CLOSE);
        }
      }
    }
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#EF0483, #009ADE, #F8E909, #FFFFFF, #000000};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}