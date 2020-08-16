int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(0);

  ortho();

  translate(width/2, height/2, -1000);

  for (int k = 0; k < 1; k++) {
    pushMatrix();
    rotateY(HALF_PI);
    rotateX(HALF_PI);
    rotateZ(PI*0.25);
    rotateX(random(-2, 2));

    int cc = int(random(5, 100));
    float ss = width*3/cc;
    float dd = ss*cc*0.5;

    float amp = random(0.38, 0.44);

    for (int j = 0; j < cc*2; j++) {
      for (int i = 0; i < cc*2; i++) {
        pushMatrix();
        translate(ss*i-dd, ss*i-dd, j*ss*0.5-dd);
        box(ss, ss, ss*amp);
        popMatrix();
      }
    }
    popMatrix();
  }
}

void box(float w, float h, float d) {
  float mw = w*0.5;
  float mh = h*0.5;
  float md = d*0.5;

  fill(rcol());
  beginShape();
  vertex(-mw, -mh, -md);
  vertex(+mw, -mh, -md);
  vertex(+mw, +mh, -md);
  vertex(-mw, +mh, -md);
  endShape(CLOSE);

  fill(rcol());
  beginShape();
  vertex(-mw, -mh, +md);
  vertex(+mw, -mh, +md);
  vertex(+mw, +mh, +md);
  vertex(-mw, +mh, +md);
  endShape(CLOSE);

  fill(rcol());
  beginShape();
  vertex(-mw, -mh, -md);
  vertex(+mw, -mh, -md);
  vertex(+mw, -mh, +md);
  vertex(-mw, -mh, +md);
  endShape(CLOSE);

  fill(rcol());
  beginShape();
  vertex(-mw, +mh, -md);
  vertex(+mw, +mh, -md);
  vertex(+mw, +mh, +md);
  vertex(-mw, +mh, +md);
  endShape(CLOSE);

  fill(rcol());
  beginShape();
  vertex(-mw, -mh, -md);
  vertex(-mw, +mh, -md);
  vertex(-mw, +mh, +md);
  vertex(-mw, -mh, +md);
  endShape(CLOSE);

  fill(rcol());
  beginShape();
  vertex(+mw, -mh, -md);
  vertex(+mw, +mh, -md);
  vertex(+mw, +mh, +md);
  vertex(+mw, -mh, +md);
  endShape(CLOSE);
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void box(float x, float y, float z, float w, float h, float d) {
  pushMatrix();
  translate(x, y, z);
  box(w, h, d);
  popMatrix();
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FE4D9F, #EE1C25, #2F3293, #3CB74C, #0272BE, #BDCBD5, #FEFEFE};
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