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
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(#1C1C21);
  translate(width/2, height/2);

  stroke(255, 4);
  strokeWeight(1);
  for (int i = -width/2; i < width/2; i+= 16) {
    line(i, -height/2, i, height/2);
    line(-width/2, i, width/2, i);
  }

  blendMode(LIGHTEST);

  int cc = int(random(20, 120));
  int sub = int(random(32, 180)); //64;
  int div = int(sub/random(2, 5)); // 16;
  float mr = width*random(0.38, 0.45);
  for (int i = 0; i < cc; i++) {
    int col = rcol();

    int rnd = int(random(5));

    if (rnd == 0) {
      float r = (mr/div)*(int(random(div/3, div))+1);
      float da = TWO_PI/sub;
      stroke(col, 40);
      noFill();
      ellipse(0, 0, r*2, r*2);
      fill(col);
      float s = random(1, 4);
      for (int j = 0; j < sub; j++) {
        float x = cos(da*j)*r;
        float y = sin(da*j)*r;
        noStroke();
        ellipse(x, y, s, s);
      }
    }

    if (rnd == 1) {
      float da = TWO_PI/sub;
      int ar = int(random(div))+1;
      float dr = mr/div;
      noFill();
      stroke(rcol(), random(140, 256));
      strokeWeight(random(1, 2));
      beginShape();
      float x = cos(0)*ar*dr;
      float y = sin(0)*ar*dr;
      int c = 1;
      for (int j = 0; j <= sub; j++) {
        x = cos(da*j)*ar*dr;
        y = sin(da*j)*ar*dr;
        vertex(x, y);
        if (random(1) < 0.2 && c > 1) {
          c = 0;
          ar = int(random(div))+1;
          x = cos(da*j)*ar*dr;
          y = sin(da*j)*ar*dr;
          vertex(x, y);
        }
        c++;
      }
      endShape(CLOSE);
      strokeWeight(1);
    }
    if (rnd == 2) {
      noStroke();
      fill(rcol());
      float a1 = (TWO_PI/sub)*int(random(sub));
      float a2 = a1+(TWO_PI/sub)*random(0.1);
      float r1 = (mr/div)*(int(random(div/5, div))+1);
      float r2 = r1-random(mr/div)*random(1);
      boolean dra = random(1) < 0.5;
      int c = int(random(8, 400*random(1)));
      float dv = random(0.1, 0.25);
      for (int j = 0; j < c; j++) {
        if (dra) {
          beginShape();
          vertex(cos(a1)*r1, sin(a1)*r1);
          vertex(cos(a1)*r2, sin(a1)*r2);
          vertex(cos(a2)*r2, sin(a2)*r2);
          vertex(cos(a2)*r1, sin(a2)*r1);
          endShape(CLOSE);
        }

        a1 = a2;
        a2 = a1+(TWO_PI/sub)*random(dv);

        dra = !dra;
      }
    }
    if (rnd == 2) {
      int ss = int(random(1, 5));
      float da = (TWO_PI/sub)/ss;
      float ia = (TWO_PI/sub)*int(random(sub));

      float r1 = (mr/div)*(int(random(3, div))+1);
      float r2 = r1-(mr/div)*int(random(1, 4));

      stroke(rcol(), random(100, 200));
      int c = int(random(10, 100*random(1)));
      for (int j = 0; j < c; j++) {
        float ang = ia+da*j;
        line(cos(ang)*r1, sin(ang)*r1, cos(ang)*r2, sin(ang)*r2);
      }
    }
    if (rnd == 3) { 
      float a1 = (TWO_PI/sub)*int(random(sub));
      float a2 = a1+(TWO_PI/sub);
      float r1 = (mr/div)*(int(random(1, div))+1);
      int c = int(random(4, 20));
      for (int j = 0; j <= c; j++) {
        float r = map(j, 0, c, r1, r1-(mr/div));
        line(cos(a1)*r, sin(a1)*r, cos(a2)*r, sin(a2)*r);
      }
    }
    if (rnd == 4) {
      int c = int(random(sub/3));
      int ss = int(pow(2, int(random(0, 4))));
      float r = (mr/div)*(int(random(div/3, div))+1);
      float da = (TWO_PI/sub)/ss;
      float ia = (TWO_PI/sub)*int(random(sub));
      stroke(col, 40);
      noFill();
      ellipse(0, 0, r*2, r*2);
      fill(col);
      float rng = random(1);
      float det = random(1);
      float s = random(1, 4)*map(r, 0, width*0.5, 0.5, 1);
      println(ss);
      for (int k = 0; k <= ss; k++) {
        for (int j = 0; j <= c*ss; j++) {
          if (noise(j*det, k*det) > rng) continue;
          float ang = ia+(da*j);
          float rr = map(k, 0, ss, r, r- (mr/div));
          float x = cos(ang)*rr;
          float y = sin(ang)*rr;
          noStroke();
          ellipse(x, y, s, s);
        }
      }
    }
  }
}

int colors[] = {#f6dbc1, #009aaf, #ff799f, #ff1d39, #f6c350, #8f498d};

int rcol() {
  return colors[int(random(colors.length))];
}