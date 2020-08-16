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
  background(30);

  noStroke();
  rectMode(CENTER);
  int sub = int(random(3, random(5, 40)));
  float ss = width*1./sub;

  float ver = random(0.8, 0.9);
  float man = ver-random(0.05, 0.1);

  {
    int rnd = int(random(5));
    for (int j = 0; j < sub; j++) {
      for (int i = 0; i < sub; i++) {
        float xx = i*ss;
        float yy = j*ss;
        if (rnd == 0) {
          fill(rcol());
          beginShape();
          vertex(xx, yy-ss*0.5);
          vertex(xx-ss*0.5, yy);
          vertex(xx, yy+ss*0.5);
          vertex(xx+ss*0.5, yy);
          endShape();
        }
        if (rnd == 1) {
          fill(rcol());
          ellipse(xx, yy, ss, ss);
        }
        if (rnd == 2) {
          fill(rcol());
          beginShape();
          vertex(xx, yy-ss*0.5);
          vertex(xx-ss*0.5, yy);
          vertex(xx, yy+ss*0.5);
          vertex(xx+ss*0.5, yy);
          endShape();

          fill(rcol());
          beginShape();
          vertex(xx-ss*0.25, yy-ss*0.25);
          vertex(xx-ss*0.25, yy+ss*0.25);
          vertex(xx+ss*0.25, yy+ss*0.25);
          vertex(xx+ss*0.25, yy-ss*0.25);
          endShape();
        }

        if (rnd == 3) {
          fill(rcol());
          ellipse(xx, yy, ss, ss);
          fill(rcol());
          ellipse(xx, yy, ss*0.5, ss*0.5);
        }
      }
    }
  }

  stroke(160); 
  for (int i = 0; i <= sub; i++) {
    float xx = map(i, 0, sub, 0, width);
    float yy = map(i, 0, sub, 0, height); 
    //line(0, yy, width, yy);
    //line(xx, 0, xx, height);
    linee(0, yy, width, yy, sub*10, 0.4);
    linee(xx, 0, xx, height, sub*10, 0.4);
  }

  noStroke();
  for (int j = 0; j < sub; j++) {
    for (int i = 0; i < sub; i++) {
      float xx = (i+0.5)*ss;
      float yy = (j+0.5)*ss;

      fill(rcol());
      ellipse(xx-ss*0.5, yy-ss*0.5, ss*0.07, ss*0.07);
      fill(60);
      ellipse(xx-ss*0.5, yy-ss*0.5, ss*0.06, ss*0.06);

      fill(240);
      rect(xx, yy, ss*ver, ss*ver, 2);
      fill(250);
      beginShape();
      vertex(xx-ss*ver*0.5, yy-ss*ver*0.5);
      vertex(xx+ss*ver*0.5, yy-ss*ver*0.5);
      vertex(xx+ss*ver*0.5, yy+ss*ver*0.5);
      vertex(xx+ss*ver*0.49, yy-ss*ver*0.49);
      endShape(CLOSE);
      fill(rcol());
      rect(xx, yy, ss*man, ss*man, 2);


      fill(rcol(), random(10));
      ellipse(xx, yy, ss*2, ss*2);

      for (int k = 0; k < 6; k++) {
        int rnd = int(random(5));
        if (rnd == 0) {
          fill(rcol());
          ellipse(xx, yy, ss*0.5, ss*0.5);
        }
        if (rnd == 1) {
          fill(rcol());
          beginShape();
          vertex(xx, yy-ss*0.5);
          vertex(xx-ss*0.5, yy);
          vertex(xx, yy+ss*0.5);
          vertex(xx+ss*0.5, yy);
          endShape();
        }
        if (rnd == 2) {
          fill(rcol());
          beginShape();
          vertex(xx, yy-ss*0.5*man);
          vertex(xx-ss*0.5*man, yy);
          vertex(xx, yy+ss*0.5*man);
          vertex(xx+ss*0.5*man, yy);
          endShape();
        }

        if (rnd == 3) {
          float ia = int(random(4))+0.5;
          float sca = random(2, int(random(8)));
          float r = sqrt(2)*ss*0.5*sca;
          beginShape();
          for (int l = 0; l < 3; l++) {
            fill(rcol());
            vertex(xx+cos(HALF_PI*(l+ia))*r, yy+sin(HALF_PI*(l+ia))*r);
          }
          endShape(CLOSE);
        }
      }
    }
  }

  fill(255, 16);
  for (int j = 0; j < sub*2; j++) {
    for (int i = 0; i < sub*2; i++) {
      ellipse(i*ss*0.5, j*ss*0.5, 2, 2);
    }
  }
}

void linee(float x1, float y1, float x2, float y2, int div, float amp) {
  for (int i = 0; i < div; i++) {
    float v1 = map(i+amp, 0, div, 0, 1);
    float v2 = map(i+1-amp, 0, div, 0, 1);
    float xx1 = lerp(x1, x2, v1);
    float yy1 = lerp(y1, y2, v1);
    float xx2 = lerp(x1, x2, v2);
    float yy2 = lerp(y1, y2, v2);

    line(xx1, yy1, xx2, yy2);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#a82a17, #EDBA2F, #0e9165, #00244f, #222126, #E5E5E5};
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