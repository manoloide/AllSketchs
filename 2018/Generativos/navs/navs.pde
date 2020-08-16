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
  noStroke();
  background(rcol());

  float h = floor(width*random(0.6, 0.7));


  fill(rcol());
  rect(0, 0, width, h);

  int cc = int(random(800*random(1)));
  if (random(1) < 0.5 && false) {
    float pwr = random(1, 2);
    fill(rcol());
    for (int i = 0; i < cc; i++) {
      float x = random(width);
      float y = pow(random(1), pwr)*h;
      float s = random(2);
      ellipse(x, y, s, s);
    }
  }

  cc = int(random(40)*random(1)*random(1));
  for (int i = 0; i < cc; i++) {
    fill(rcol());
    nube(random(width), random(h));
  }

  fill(rcol());
  float s = width*random(0.2, 0.8);
  arc(width/2, h, s, s, PI, TAU);

  cc = int(random(1, random(1, 4)));
  for (int i = 0; i < cc; i++) {
    montains(0, h);
  }

  fill(rcol());
  rect(0, h, width, height-h);

  cc = int(random(1000, 8000)*random(10));
  fill(rcol());
  float pwr = random(3, 4);
  float ss = random(1, 5);
  for (int i = 0; i < cc; i++) {
    float hh = random(1);
    float x = random(width);
    float y = h+(height-h)*pow(hh, pwr);
    fill(rcol());
    ellipse(x, y, hh*ss, hh*ss);
  }

  fill(rcol());
  beginShape();
  vertex(width/2, h);
  vertex(width*random(0.1, 0.5), height);
  vertex(width*random(0.5, 0.9), height);
  endShape(CLOSE);

  /*
  cc = int(random(1, random(2, 6)));
   for (int i = 0; i < cc; i++) {
   fill(rcol());
   edif(0, height*0.35+i*0.08);
   if (random(1) < 0.4) {
   fill(rcol());
   navs(0, height*random(random(0.4, 0.6), 1), width, height*random(0.02, 0.1));
   }
   }
   */
}

void nube(float x, float y) {
  FloatList p = new FloatList();
  p.clear();
  p.append(0);
  float max = random(width);
  p.append(max);
  for (int i = 0; i < 10; i++) {
    p.append(random(max));
  }
  p.sort();
  beginShape();
  for (int i = 0; i < p.size()-1; i++) {
    float v1 = p.get(i);
    float h = max*random(0.3)*random(1);
    vertex(x+v1-max*0.5, y+h);
  }
  endShape(CLOSE);
}

void montains(float x, float y) {
  FloatList p = new FloatList();
  p.append(0);
  p.append(width);
  for (int i = 0; i < 10; i++) {
    p.append(random(width));
  }
  p.sort();

  fill(rcol());
  beginShape();
  for (int i = 0; i < p.size()-1; i++) {
    float v1 = p.get(i);
    float v2 = p.get(i+1);
    float m = lerp(v1, v2, random(0.2, 0.8));
    float h = abs(v2-v1);//*random(5);
    if (i == 0) vertex(x+v1, y);
    vertex(x+m, y-h);
    vertex(x+v2, y);
  }
  endShape(CLOSE);
}

void edif(float x, float y) {
  FloatList p = new FloatList();
  p.clear();
  p.append(0);
  p.append(width);
  for (int i = 0; i < 10; i++) {
    p.append(random(width));
  }
  p.sort();

  beginShape();
  vertex(p.get(0), height);
  for (int i = 0; i < p.size()-1; i++) {
    float v1 = p.get(i);
    float v2 = p.get(i+1);
    float h = width*random(0.5);
    vertex(x+v1, y+h);
    vertex(x+v2, y+h);
  }
  vertex(width, height);
  endShape(CLOSE);
}

void navs(float x, float y, float w, float h) {
  FloatList p = new FloatList();
  p.clear();
  p.append(0);
  p.append(width);
  for (int i = 0; i < 10; i++) {
    p.append(random(width));
  }
  p.sort();

  for (int i = 0; i < p.size()-1; i++) {
    float v1 = p.get(i);
    float v2 = p.get(i+1);
    nav(x+v1, y, v2-v1, h);
  }
}

void nav(float x, float y, float w, float h) {
  float m = w*random(0.2, 0.8);
  float y1 = y;
  float y2 = y+h;
  float x1 = x;
  float x2 = x+w;
  if (random(1) < 0.5) {
    x2 = x;
    x1 = x+w;
  }

  if (random(1) < 0.5) {
    y2 = y;
    y1 = y+h;
  }
  beginShape();
  vertex(x+m, y1);
  vertex(x+m, y2);
  vertex(x1, y2);
  endShape(CLOSE);

  vertex(x+m, y1);
  vertex(x2, y1);
  vertex(x1, y2);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+".png");
}

//int colors[] = {#DF2601, #7A04C4, #1DCCBB, #F4F4F4, #FFD71D};
int colors[] = {#EA554F, #FAC745, #2760AB, #369952, #1E2326, #FFF7F3}; 
int rcol() {
  return getColor();//colors[int(random(colors.length))];
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