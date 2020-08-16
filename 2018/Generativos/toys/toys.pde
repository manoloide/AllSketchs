int seed = int(random(999999));
float time;

void setup() {
  size(6500, 6500, P2D);
  //smooth(8);
  //pixelDensity(2);

  generate();
  saveImage();
  exit();
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
  beginShape();
  fill(rcol());
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol());
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  int cc = int(random(10, random(20, 1200)));
  for (int i = 0; i < 50; i++) {
    float x = random(width);
    float y = random(height);
    float w = random(width*2)*random(1);
    float h = w*random(0.015, 0.1);

    pushMatrix();
    translate(x, y);
    rotate(HALF_PI*0.5*int(random(8)));

    noStroke();
    beginShape();
    fill(rcol());
    vertex(-w*0.5, -h*0.5);
    vertex(-w*0.5, +h*0.5);
    fill(rcol());
    vertex(+w*0.5, +h*0.5);
    vertex(+w*0.5, -h*0.5);
    endShape(CLOSE);

    srect(0, 0, w, h, min(w, h)*1.8, rcol(), 20, 0);
    popMatrix();

    x = random(width);
    y = random(height);
    float s = random(width/2)*random(1)*random(1);
    fill(rcol());
    ellipse(x, y, s, s);
    arc2(x, y, s, s*1.8, 0, TAU, rcol(), 30, 0);
  }
}

void srect(float x, float y, float w, float h, float s, int col, float alp1, float alp2) {

  beginShape();
  fill(col, alp1);
  vertex(-w*0.5, -h*0.5);
  vertex(-w*0.5, +h*0.5);
  fill(col, alp2);
  vertex(-w*0.5-s, +h*0.5+s);
  vertex(-w*0.5-s, -h*0.5-s);
  endShape(CLOSE);

  beginShape();
  fill(col, alp1);
  vertex(-w*0.5, +h*0.5);
  vertex(+w*0.5, +h*0.5);
  fill(col, alp2);
  vertex(+w*0.5+s, +h*0.5+s);
  vertex(-w*0.5-s, +h*0.5+s);
  endShape(CLOSE);

  beginShape();
  fill(col, alp1);
  vertex(+w*0.5, +h*0.5);
  vertex(+w*0.5, -h*0.5);
  fill(col, alp2);
  vertex(+w*0.5+s, -h*0.5-s);
  vertex(+w*0.5+s, +h*0.5+s);
  endShape(CLOSE);

  beginShape();
  fill(col, alp1);
  vertex(+w*0.5, -h*0.5);
  vertex(-w*0.5, -h*0.5);
  fill(col, alp2);
  vertex(-w*0.5-s, -h*0.5-s);
  vertex(+w*0.5+s, -h*0.5-s);
  endShape(CLOSE);
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#F8C43D, #023390, #6AA6E2, #F35076, #F6F6F6};
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