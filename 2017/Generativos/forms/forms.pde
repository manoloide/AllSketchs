
void setup() {
  size(960, 960);
  smooth(8);
  generate();
}

void draw() {
  if (frameCount%30 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String name = nf(day(), 2)+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2);
  saveFrame(name+".png");
}

void generate() {
  background(rcol());

  float diag = dist(0, 0, width, height);
  int cc = int(random(8, random(8, 30)));
  for (int c = 0; c < cc; c++) {
    float x = random(width);
    float y = random(height);
    float s = random(60, 260);
    float a = random(TWO_PI);
    int rnd = int(random(3));
    if (rnd == 0) {
      stroke(rcol());
      strokeWeight(s);
      strokeCap(SQUARE);
      line(x, y, x+cos(a)*diag, y+sin(a)*diag);
      noStroke();
      fill(rcol());
      ellipse(x, y, s, s);
    } else if (rnd == 1) {
      int c1 = rcol();
      int c2 = rcol();
      while (c1 == c2) c2 = rcol();
      noStroke();
      fill(c1);
      arc(x, y, s, s, a-0.01, a+PI+0.01, 1); 
      fill(c2);
      arc(x, y, s, s, a+PI, a+PI*2);
    } else if (rnd == 2) {
      int ccc = int(random(2, 16));
      float ss = random(80, random(200, 500));
      float d = ss/ccc*random(0.1, 0.4);
      float des = ss/ccc;
      float dx = -ss*0.5;
      float dy = -ss*0.5;

      boolean rec = (random(1) < 0.5);
      noStroke();
      pushMatrix();
      translate(x, y);
      rotate(HALF_PI*0.5*int(random(4)));
      for (int j = 0; j < cc; j++) {
        for (int i = 0; i < cc; i++) {
          if (rec) {
            pushMatrix();
            translate(dx+i*des, dy+j*des);
            rotate(PI*0.25);
            rect(0, 0, d, d);
            popMatrix();
          } else ellipse(dx+i*des, dy+j*des, d, d);
        }
      }
      popMatrix();
    }
  }
}

//int colors[] = {#E84820, #538BFC, #FCFF6D, #00B285, #8BD7D2, #022ACE};
int colors[] = {#F46324, #0111A3, #FFD65E, #00C191, #8BD7D2, #538BFC, #F2E1E1, #C96FDB, #964CAA, #EDAC34, #FF66A5};
int rcol() {
  int col = colors[int(random(colors.length))];
  //int col2 = colors[int(random(colors.length))];
  //col = lerpColor(col, col2, random(0.04));
  return col;
}