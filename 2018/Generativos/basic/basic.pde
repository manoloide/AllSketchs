int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
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
  background(rcol());

  int cc = int(random(5, random(5, 50)));
  float ss = width*1./cc;

  noFill();
  stroke(0, 12);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      rect(i*ss, j*ss, ss, ss);
    }
  }

  int ccc = int(random(2, pow(cc, 1.4)*random(1)));
  noStroke();
  for (int i = 0; i < ccc; i++) {
    int w = int(random(2, random(2, cc*0.5)));
    int h = int(random(2, random(2, cc*0.5)));
    int x = int(random(0, cc-w+1));
    int y = int(random(0, cc-h+1));
    int c1 = rcol();
    int c2 = rcol();

    int rnd = int(random(3)); 

    if (rnd == 0) {
      fill(0, random(30));
      rect(x*ss+ss, y*ss+ss, w*ss, h*ss);

      rectSha(x*ss, y*ss, w*ss, h*ss, ss*2, color(0), 15, 0);
      rectSha(x*ss, y*ss, w*ss, h*ss, ss*0.5, color(0), 20, 0);

      if (random(1) < 0.5) {
        beginShape();
        fill(c1);
        vertex(x*ss, y*ss);
        vertex(x*ss+w*ss, y*ss);
        fill(c2);
        vertex(x*ss+w*ss, y*ss+h*ss);
        vertex(x*ss, y*ss+h*ss);
        endShape(CLOSE);
      } else {
        beginShape();
        fill(c1);
        vertex(x*ss, y*ss);
        vertex(x*ss, y*ss+h*ss);
        fill(c2);
        vertex(x*ss+w*ss, y*ss+h*ss);
        vertex(x*ss+w*ss, y*ss);
        endShape(CLOSE);
      }
    }
    if (rnd == 1) {
      float d = int(w*0.5);
      if ((w)%2 == 1) d += 0.5;
      float a1 = int(random(4))*HALF_PI;
      float a2 = a1+int(random(4))*HALF_PI;
      arcc((x+d)*ss, (y+d)*ss, w*ss, ss, a1, a2, c1, c2);
    }
    if (rnd == 2) {
      fill(0, random(30));
      arc2((x+w*0.5)*ss, (y+w*0.5)*ss, w*ss, w*ss+ss+2, 0, TAU, color(0), random(20), 0);
      fill(rcol());
      ellipse((x+w*0.5)*ss, (y+w*0.5)*ss, w*ss, w*ss);
    }
  }
}

void arcc(float x, float y, float s, float b, float a1, float a2, int c1, int c2) {
  float r1 = s*0.5;
  float r2 = r1-b;
  int res = int(max(8, r1*PI));
  float da = abs(a1-a2)/res;
  for (int i = 0; i < res; i++) {
    float v1 = map(i, 0, res, 0, 1);
    float v2 = map(i+1, 0, res, 0, 1);
    float aa1 = lerp(a1, a2, v1);
    float aa2 = lerp(a1, a2, v2);
    beginShape();
    fill(lerpColor(c1, c2, v1));
    vertex(x+cos(aa1)*r1, y+sin(aa1)*r1);
    vertex(x+cos(aa1)*r2, y+sin(aa1)*r2);
    fill(lerpColor(c1, c2, v2));
    vertex(x+cos(aa2)*r2, y+sin(aa2)*r2);
    vertex(x+cos(aa2)*r1, y+sin(aa2)*r1);
    endShape(CLOSE);
  }
}

void rectSha(float x, float y, float w, float h, float s, int col, float a1, float a2) {

  beginShape();
  fill(col, a1);
  vertex(x, y);
  vertex(x+w, y);
  fill(col, a2);
  vertex(x+w+s, y-s);
  vertex(x-s, y-s);
  endShape(CLOSE);

  beginShape();
  fill(col, a1);
  vertex(x+w, y);
  vertex(x+w, y+h);
  fill(col, a2);
  vertex(x+w+s, y+h+s);
  vertex(x+w+s, y-s);
  endShape(CLOSE);

  beginShape();
  fill(col, a1);
  vertex(x+w, y+h);
  vertex(x, y+h);
  fill(col, a2);
  vertex(x-s, y+h+s);
  vertex(x+w+s, y+h+s);
  endShape(CLOSE);

  beginShape();
  fill(col, a1);
  vertex(x, y+h);
  vertex(x, y);
  fill(col, a2);
  vertex(x-s, y-s);
  vertex(x-s, y+h+s);
  endShape(CLOSE);
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#CD0181, #F56E99, #F4AFB2, #85D4D1, #0055BF};
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