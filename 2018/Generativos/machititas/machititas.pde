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
  background(0);
  randomSeed(seed);

  background(rcol());

  defx = random(0.08, 0.12)*random(2);
  defy = random(0.08, 0.12);

  int cc = int(random(60, 80)*1.4);
  float ss = width*1./cc;
  stroke(255, 50);
  for (int i = 0; i <= cc; i++) {
    l(ss*i, 0, ss*i, height);
    l(0, ss*i, width, ss*i);
  }

  stroke(255);
  noStroke();
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      if (random(1) < 0.1) continue;
      fill(rcol());
      c((i+0.5)*ss, (j+0.5)*ss, ss*0.38);
    }
  }

  noStroke();
  beginShape();
  fill(rcol(), random(40, 60)*0.4);
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol(), random(40, 60)*0.4);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  beginShape();
  fill(rcol(), random(40, 60)*0.4);
  vertex(0, height);
  vertex(0, 0);
  fill(rcol(), random(40, 60)*0.4);
  vertex(width, 0);
  vertex(width, height);
  endShape(CLOSE);

  float desc = random(1000);
  float detc = random(0.01);
  noStroke();
  for (int i = 0; i < 100000; i++) {
    float x = random(width);
    float y = random(height);
    float s = noise(desc+x*detc, desc+x*detc)*2;
    fill(getColor(noise(desc+x*detc, desc+y*detc)));
    ellipse(x, y, s, s);
  }

  noStroke();
  stroke(255, 10);
  float des = random(1000);
  float det = random(0.01);

  for (int i = 0; i < 100; i++) {
    float x = int(random(cc+1))*ss;
    float y = int(random(cc+1))*ss;
    float s = ss*random(0.6, 0.6)*2*int(1+pow(noise(des+x*det, des+y*det), 1.2)*6);
    for (float j = 1; j > 0; j-=0.03) {
      fill(getColor(noise(desc+x*detc, desc+y*detc)+j*0.2));
      c(x, y, s*j);
    }
  }
}

void c(float x, float y, float s) {
  float r = s;
  int seg = int(max(8, s*PI));
  float da = TAU/seg;
  beginShape();
  for (int j = 0; j < seg; j++) {
    PVector p = desform(x+cos(da*j)*r, y+sin(da*j)*r);
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
}

void l(float x1, float y1, float x2, float y2) {
  int cc = int(dist(x1, y1, x2, y2));
  beginShape();
  for (int i = 0; i <= cc; i++) {
    float v = i*1./cc;
    float x = lerp(x1, x2, v);
    float y = lerp(y1, y2, v);
    PVector p = desform(x, y);
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
}

float defx = random(0.08, 0.12);
float defy = random(0.08, 0.12);

PVector desform(float x, float y) {
  float dx = x+cos(x*defx)*4;
  float dy = y+sin(y*defy)*4;
  return new PVector(dx, dy);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#92C8FA, #0321A1, #EFFF43, #F94D21};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
