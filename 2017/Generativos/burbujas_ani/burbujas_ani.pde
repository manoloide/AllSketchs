int seed = int(random(999999));

void setup() {
  size(820, 820, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  int frames = 300; 
  time = (frameCount%frames)*1./frames;

  if (frameCount%(frames/2) == 0) generate();

  render();
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
  seed = int(random(999999));
}

float time = 0;

void render() {

  noiseSeed(seed);
  randomSeed(seed);

  background(getColor(random(colors.length)));
  translate(width*0.5, height*0.5);
  rotate(random(TWO_PI));


  stroke(0, 5);
  noStroke();
  for (int i = 0; i < 100; i++) {

    float tt = (time+random(1))%1;
    float dt = random(0.3, 0.7);
    if (tt > dt) tt = map(tt, dt, 1, dt, 0);
    tt *= random(1.2);

    float x = width*random(-0.7, 0.7);
    float y = height*random(-0.7, 0.7);
    float s = width*random(0.55)*random(1);
    float det = 0.4/s;//random(0.6)/s;
    float des = s*random(1.2);
    PVector pos = des(new PVector(x, y), det, des, tt);
    int res = max(32, int(s/PI));
    float r = s*0.5;
    float da = TWO_PI/res;
    float a = random(TWO_PI);
    fill(getColor(random(colors.length)));
    beginShape();
    for (int k = 0; k < res; k++) {
      PVector p = des(new PVector(x+cos(da*k+a)*r, y+sin(da*k+a)*r), det, des, tt);
      vertex(pos.x+p.x, pos.y+p.y);
    }
    endShape(CLOSE);

    if (i == 50) {
      rects(0, 0, width*1.4, height*1.4, int(random(5, random(5, 40))), random(0.02), random(40));
    }

    for (int j = 0; j < 2; j++) {
      if (random(1) < 0.5) continue;
      float xx = random(width)-width/2;
      float yy = random(height)-height/2;
      float ss = random(20)*random(1);
      float vv = int(random(8))-4;
      fill(getColor(random(colors.length)));
      pushMatrix();
      translate(xx, yy); 
      rotate(random(TWO_PI)+time*vv*HALF_PI);
      rectMode(CENTER);
      rect(0, 0, ss, ss);
      popMatrix();
    }


    for (int j = 0; j < 1; j++) {
      if (random(1) < 0.5) continue;
      float xx = random(width)-width/2;
      float yy = random(height)-height/2;
      float ss = random(10, 100);
      float t = (time+random(1))%1.;
      rectColor(xx, yy, ss, ss*random(0.01, 0.08), int(random(2, random(2, 10))), t);
    }
  }
} 

PVector des(PVector pos, float d, float s, float t) {
  pos.x += noise(pos.x*d, pos.y*d, t)*s-s*0.5; 
  pos.y += noise(pos.x*d+4535, pos.y*d, t+100)*s-s*0.5;
  return pos;
}

void rectColor(float x, float y, float w, float h, int cc, float tt) {
  pushStyle();
  rectMode(CORNER);
  FloatList range = new FloatList();
  range.append(0);
  range.append(1);
  for (int i = 0; i < cc; i++) {
    range.append(random(1));
  }
  range.sort();
  float dw = width*random(1, 1.2);
  for (int i = 0; i < cc; i++) {
    float dx = range.get(i)*w+dw*tt*2-dw;
    float ww = w*(range.get(i+1)-range.get(i));
    fill(getColor(random(colors.length)));
    rect(x+dx, y, ww, h);
  }
  popStyle();
}

void points(float x, float y, float w, float h, float c, float s) {
  float sx = w*1./c;
  float sy = h*1./c;
  pushStyle();
  pushMatrix();
  translate(-w*0.5+x, -h*0.5+y);
  for (int j = 0; j < c; j++) {
    for (int i = 0; i < c; i++) {
      float xx = i*sx;
      float yy = j*sy;
      float ss = s;//random(2);
      rectMode(CENTER);
      ellipse(xx, yy, ss, ss);
    }
  }
  popMatrix();
  popStyle();
}

void rects(float x, float y, float w, float h, float c, float det, float des) {
  float sx = w*1./c;
  float sy = h*1./c;
  float tt = (time+random(1))%1;
  if (tt > 0.6) tt = map(tt, 0.6, 1, 0.6, 0);
  tt *= random(0.2, 1.3);
  pushStyle();
  pushMatrix();
  translate(-w*0.5+x, -h*0.5+y);
  for (int j = 0; j < c; j++) {
    for (int i = 0; i < c; i++) {
      PVector p1 = des(new PVector(   i*sx, j*sy), det, des, tt);
      PVector p2 = des(new PVector(i*sx+sx, j*sy), det, des, tt);
      PVector p3 = des(new PVector(i*sx+sx, j*sy+sy), det, des, tt);
      PVector p4 = des(new PVector(   i*sx, j*sy+sy), det, des, tt);
      PVector ce = p1.copy();
      ce.add(p2);
      ce.add(p3); 
      ce.add(p4);
      ce.div(4);

      int col = getColor(random(colors.length));
      rectMode(CENTER);
      float ss = sx*map(noise(ce.x*det, ce.y*det), 0, 1, 0.08, 0.16);
      noStroke();
      fill(col, 30); 
      rect(ce.x, ce.y, ss*1.6, ss*1.6);
      fill(col);
      rect(ce.x, ce.y, ss, ss);
      stroke(col);
      line(p1.x, p1.y, ce.x, ce.y);
      line(p2.x, p2.y, ce.x, ce.y);
      line(p3.x, p3.y, ce.x, ce.y);
      line(p4.x, p4.y, ce.x, ce.y);
    }
  }
  popMatrix();
  popStyle();
}

//https://coolors.co/230d51-95e03a-f9cd04-f2eded-ff82d7
int colors[] = {#230D51, #95E03A, #F9CD04, #F2EDED, #FF82D7};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;//pow(v%1, 0.01);

  return lerpColor(c1, c2, m);
}