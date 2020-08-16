int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
  //generate();
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

  rectMode(CENTER);
  int cc = int(random(600)*random(0.2, 1));
  for (int i = 0; i < cc; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.1, 0.2);

    int col1 = rcol();
    int col2 = rcol();

    pushMatrix();
    translate(x, y);
    rotate(random(TWO_PI));

    if (random(1) < 0.5) {
      noStroke();
      srect(0, 0, s, s, s*0.1, color(0), 20, 0);
      srect(0, 0, s, s, s*0.3, color(0), 8, 0);
      fill(rcol());
      rect(0, 0, s*0.1, s*0.1);
      fill(rcol());
      ellipse(0, 0, s*0.04, s*0.04);
    }

    if (random(1) < 0.3) {
      noFill();
      stroke(col1);
      strokeWeight(random(0.8, 3.4));
    } else {
      noStroke();
      fill(col1);
    }

    if (random(1) < 0.5) {
      noFill();
      stroke(rcol());
      strokeWeight(2);
      ellipse(x, y, s*0.4, s*0.4);
    } else {
      fill(col1);
      rect(0, 0, s, s);

      if (random(1) < 0.2) {
        fill(rcol());
        ellipse(0, 0, s*0.5, s*0.5);


        if (random(1) < 0.5) arc(s*0.5, 0, s*0.5, s*0.5, PI*2.5, PI*3.5);
        if (random(1) < 0.5)  arc(-s*0.5, 0, s*0.5, s*0.5, PI*1.5, PI*2.5);

        if (random(1) < 0.5) arc(0, s*0.5, s*0.5, s*0.5, PI, TAU);
        if (random(1) < 0.5) arc(0, -s*0.5, s*0.5, s*0.5, 0, PI);
      }

      if (random(1) < 0.3) {
        stroke(col2);
        noFill();
        int ccc = int(s*s)/100;
        for (int j = 0; j < ccc; j++) {
          float ss = s*random(0.1);
          strokeWeight(1);
          float xx = random((-s+ss)*0.5, (s-ss)*0.5);
          float yy = random((-s+ss)*0.5, (s-ss)*0.5);
          float a1 = random(TWO_PI);
          float a2 = a1+random(HALF_PI);
          arc(xx, yy, ss, ss, a1, a2);
        }
      }
      if (random(1) < 0.4) {
        int div = int(random(2, 12));
        stroke(col2);
        for (int j = 0; j <= div; j++) {
          float xx = map(j, 0, div, -s*0.5, s*0.5);
          float yy = map(j, 0, div, -s*0.5, s*0.5);
          line(xx, -s*0.5, xx, +s*0.5);
          line(-s*0.5, yy, +s*0.5, yy);
        }
      }

      if (random(1) < 0.2) {
        fill(rcol());
        ellipse(0, 0, s*0.5, s*0.5);
      }
    }
    popMatrix();

    noFill();
    int col = rcol();
    for (int j = 0; j < 40; j++) {
      float xx = random(width);
      float yy = random(height); 
      float ss = width*random(0.02);
      float a1 = random(TAU);
      float a2 = a1+random(HALF_PI);
      stroke(col, random(200)*random(1));
      strokeWeight(1);
      arc(xx, yy, ss, ss, a1, a2);
    }
  }
}

void srect(float x, float y, float w, float h, float s, int col, float alp1, float alp2) {
  float mw = w*0.5;
  float mh = h*0.5;
  float sw = mw+s;
  float sh = mh+s;
  beginShape();
  fill(col, alp2);
  vertex(x-sw, y-sh);
  vertex(x+sw, y-sh);
  fill(col, alp1);
  vertex(x+mw, y-mh);
  vertex(x-mw, y-mh);
  endShape();


  beginShape();
  fill(col, alp2);
  vertex(x+sw, y-sh);
  vertex(x+sw, y+sh);
  fill(col, alp1);
  vertex(x+mw, y+mh);
  vertex(x+mw, y-mh);
  endShape();


  beginShape();
  fill(col, alp2);
  vertex(x+sw, y+sh);
  vertex(x-sw, y+sh);
  fill(col, alp1);
  vertex(x-mw, y+mh);
  vertex(x+mw, y+mh);
  endShape();

  beginShape();
  fill(col, alp2);
  vertex(x-sw, y+sh);
  vertex(x-sw, y-sh);
  fill(col, alp1);
  vertex(x-mw, y-mh);
  vertex(x-mw, y+mh);
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FFFCF7, #FDDA02, #EE78AC, #3155A3, #028B88};
//int colors[] = {#01AFD8, #009A91, #E46952, #784391, #1B2D53};
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