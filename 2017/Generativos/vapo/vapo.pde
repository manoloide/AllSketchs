void setup() {
  size(960, 960);
  smooth(8);
  rectMode(CENTER);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else thread("generate");
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  color back = rcol();
  color back2 = -1;
  background(back);
  strokeCap(SQUARE);

  if (random(1) < 0.5) {
    float sep = random(4, 60);
    int col = rcol();
    while (col == back) col = rcol();
    stroke(col, (random(1) < 0.5)? 120 : random(120));
    strokeWeight(sep*random(0.5)*random(1));
    for (float i = -random(sep); i < width+height; i+=sep) {
      line(-2, i, i, -2);
    }
  }

  if (random(1) < 0.8) {
    float diag = dist(0, 0, width, height);
    color col = rcol();
    while (col == back) col = rcol();
    int col2 = rcol();
    while (col2 == back || col2 == col) col2 = rcol();
    back2 = col;

    float amp = random(180);
    int cc = int(random(2, 20))*2+1;
    float ang = PI/2;
    float xx = -diag;
    float yy = 0;
    float des = (diag/cc)*2;
    float dx = des;
    float dy = 0;

    float sx = 0;
    float sy = amp;
    boolean smo = random(1) < 0.6;
    noStroke();
    if (random(1) < 0.4) stroke(col2);
    fill(col);
    pushMatrix();
    translate(width*random(0.16, 0.5), height*random(0.16, 0.5));
    rotate(random(TWO_PI));
    beginShape();
    vertex(-diag, 0);
    beginShape();
    for (int j = 0; j < cc; j++) {
      if (!smo) {
        if (j%2 == 0) vertex(xx-sx, yy-sy);
        else vertex(xx+sx, yy+sy);
      } else {
        if (j%2 == 0) curveVertex(xx-sx, yy-sy);
        else curveVertex(xx+sx, yy+sy);
      }
      xx += dx;
      yy += dy;
    }
    vertex(diag, 0);
    vertex(diag, diag);
    vertex(-diag, diag);
    endShape();
    popMatrix();
  }


  int c = int(random(8, 32));
  float ms = map(c, 8, 32, 0.3, 0.18);
  for (int i = 0; i < c; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(ms*0.25, ms*1.4)*random(0.6, 1);
    if (random(1) < 0.5) s *= random(0.2, 1);
    int col = rcol();
    while (col == back || col == back2) col = rcol();
    int col2 = rcol();
    while (col2 == back || col2 == back2 || col2 == col) col2 = rcol();

    int rnd = int(random(4));

    if (rnd == 0) {
      noStroke();
      if (random(1) < 0.0) {
        stroke(col2);
        strokeWeight(s*random(0.01, 0.3));
      }
      fill(col);
      ellipse(x, y, s, s);
    }
    if (rnd == 1) {
      noStroke();
      if (random(1) < 0.5) {
        stroke(col2);
        strokeWeight(s*random(0.01, 0.3));
      }
      fill(col);
      pushMatrix();
      translate(x, y);
      rotate(random(TWO_PI));
      rect(0, 0, s, s);
      popMatrix();
    }
    if (rnd == 2) {
      noStroke();
      if (random(1) < 0.0) {
        stroke(col2);
        strokeWeight(s*random(0.01, 0.3));
      }
      fill(col);
      beginShape();
      float da = TWO_PI/3;
      float aa = random(TWO_PI);
      for (int j = 0; j < 3; j++) {
        float amp = random(random(0.5), 1)*s;
        vertex(x+cos(aa+da*j)*amp, y+sin(aa+da*j)*amp);
      }
      endShape(CLOSE);
    }
    if (rnd == 3) {
      float r = s*2;
      float ang = random(TWO_PI);
      stroke(col);
      strokeWeight(s*random(0.095, 0.12));

      float amp = random(0.2)*random(1);
      if (amp < 0.04)
        line(x-cos(ang)*r, y-sin(ang)*r, x+cos(ang)*r, y+sin(ang)*r);
      else {
        noFill();
        int cc = int(random(2, 8))*2+1;

        boolean smo = random(1) < 0.6;
        if (smo) amp *= 1.5;
        float xx = x-cos(ang)*r;
        float yy = y-sin(ang)*r;
        float des = r/cc;
        float dx = cos(ang)*des;
        float dy = sin(ang)*des;

        float sx = cos(ang+PI/2)*r*amp;
        float sy = sin(ang+PI/2)*r*amp;
        beginShape();
        for (int j = 0; j < cc; j++) {
          if (!smo) {
            if (j%2 == 0) vertex(xx-sx, yy-sy);
            else vertex(xx+sx, yy+sy);
          } else {
            if (j%2 == 0) curveVertex(xx-sx, yy-sy);
            else curveVertex(xx+sx, yy+sy);
          }
          xx += dx;
          yy += dy;
        }
        endShape();
      }
    }
  }
}

int colors[] = {#f6dbc1, #040401, #009aaf, #ff799f, #ff1d39, #f6c350, #8f498d};

int rcol() {
  return colors[int(random(colors.length))];
}