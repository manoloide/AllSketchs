int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();

  //saveImage();
  //exit();
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
  int c1 = rcol();
  int c2 = rcol();
  while (c1 == c2) c2 = rcol();
  int c3 = rcol();
  while (c3 == c1 || c3 == c2) c3 = rcol();
  background(c1);

  int cc = int(random(5, 20));
  float des = width*1./cc;
  float ia = random(10000);
  float da = random(0.001)*random(0.2, 1);
  float is = random(10000);
  float ds = random(0.01)*random(0.2, 1);
  float id = random(des);
  float md = random(0.3);

  randomSeed(seed);
  noStroke();
  fill(0, 20);
  pushMatrix();
  translate(-5, -5);
  rectMode(CENTER);
  for (int j = -1; j <= cc+1; j++) {
    for (int i = -1; i <= cc+1; i++) {
      float xx = id+(i+random(-md, md))*des;
      float yy = id+(j+random(-md, md))*des;
      float dis =  noise(is+xx*ds, is+yy*ds)*des;
      float ang = noise(ia+xx*da, ia+yy*da)*TWO_PI*2;
      pushMatrix();
      translate(xx, yy);
      rotate(ang);
      rect(0, 0, dis, dis*0.14);
      popMatrix();
    }
  }
  popMatrix();

  stroke(c2);
  fill(c3);
  randomSeed(seed);
  for (int j = -1; j <= cc+1; j++) {
    for (int i = -1; i <= cc+1; i++) {
      float xx = id+(i+random(-md, md))*des;
      float yy = id+(j+random(-md, md))*des;
      float dis =  noise(is+xx*ds, is+yy*ds)*des;
      float ang = noise(ia+xx*da, ia+yy*da)*TWO_PI*2;
      pushMatrix();
      translate(xx, yy);
      rotate(ang);
      strokeWeight(dis*0.03);
      rect(0, 0, dis, dis*0.14);
      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#ffffff, #000000, #C8FA4C};
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