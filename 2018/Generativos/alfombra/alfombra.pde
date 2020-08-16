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
  background(0);
  randomSeed(seed);

  float dc1 = random(1);
  float di1 = random(100000);
  float dc2 = random(1);
  float di2 = random(100000);

  float dc3 = random(1);
  float di3 = random(100000);


  noStroke();
  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.1, 0.3);
    float s2 = s*random(0.2, 0.6);

    noStroke();

    fill(getColor(noise(di1+x*dc1, di1+y*dc1)*colors.length*4));
    ellipse(x, y, s, s);


    fill(getColor(noise(di2+x*dc2, di2+y*dc2)*colors.length*4));
    ellipse(x, y, s2, s2);

    for (int j = 0; j < 100; j++) {
      float xx = random(width);
      float yy = random(height);
      float ss = width*random(0.003);
      fill(getColor(noise(di3+x*dc3, di3+y*dc3)*colors.length*4));
      ellipse(xx, yy, ss, ss);
    }
  }

  for (int i = 0; i < 16; i++) {
    pelos();
  }
}

void pelos() {

  int cc = int(random(160, 220));
  float des = width*1./cc;
  float ia = random(10000);
  float da = random(0.01);
  float is = random(10000);
  float ds = random(0.01);
  float ic = random(10000);
  float dc = random(0.001);
  float init = random(colors.length);
  float vel = random(colors.length);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = (i+random(-0.5, 0.5))*des;
      float yy = (j+random(-0.5, 0.5))*des;
      float dis =  noise(is+xx*ds, is+yy*ds)*des*1.4;
      float ang = noise(ia+xx*da, ia+yy*da)*TWO_PI;
      stroke(getColor(init+noise(ic+dc*xx, ic+dc*yy)*vel), 80);
      line(xx, yy, xx+cos(ang)*dis, yy+sin(ang)*dis);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#D81D03, #101A9D, #1C7E4E, #F6A402, #EFD4BF, #E2E0EF, #050400};
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