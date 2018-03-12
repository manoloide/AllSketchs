int seed = int(random(999999));

void setup() {
  size(720, 720, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
  }
}

ArrayList<PGraphics> renders;
ArrayList<Rect> rects;

void generate() {
  seed = int(random(999999));
  subdivision();
}

void subdivision() {
  rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = int(random(30));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    boolean hor = r.w > r.h;
    if (hor) {
      float ww = r.w/3.0;
      rects.add(new Rect(r.x+ww*0, r.y, ww, r.h)); 
      rects.add(new Rect(r.x+ww*1, r.y, ww, r.h)); 
      rects.add(new Rect(r.x+ww*2, r.y, ww, r.h));
    } else {
      float hh = r.h/3.0;
      rects.add(new Rect(r.x, r.y+hh*0, r.w, hh)); 
      rects.add(new Rect(r.x, r.y+hh*1, r.w, hh)); 
      rects.add(new Rect(r.x, r.y+hh*2, r.w, hh));
    }
    rects.remove(ind);
  }

  renders = new ArrayList<PGraphics>();
  for (int i = 0; i < rects.size(); i++) {
    renders.add(createGraphics(int(rects.get(i).w), int(rects.get(i).h), P3D));
  }
}

void render() {
  background(10);

  randomSeed(seed);
  noiseSeed(seed);

  float time = millis()/1000.;

  boolean change = (random(1) < 0.5);
  int rnd = int(random(1, 5));
  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);

    if (change) rnd = int(random(1, 5));
    //rnd = 4;
    stroke(200);
    if (rnd == 1) {
      noiseWave(r.x, r.y, r.w, r.h, time*random(-10, 10));
    } else if (rnd == 0) {
      hexaTerrain(r.x, r.y, r.w, r.h, renders.get(i), time*random(-10, 10));
    } else if (rnd == 2) {
      sensenWave(r.x, r.y, r.w, r.h, time*random(-100, 100));
    } else if (rnd == 3) {
      vectorField(r.x, r.y, r.w, r.h, time*random(-10, 10));
    } else if (rnd == 4) {
      multiNoiseWave(r.x, r.y, r.w, r.h, time*random(-10, 10));
    }
    noFill();
    rect(r.x, r.y, r.w, r.h);
  }
}

void hexaTerrain(float x, float y, float w, float h, PGraphics gra, float time) {
  int sub = 11;
  float det = random(0.1, 1);
  float dd = max(w, h)*random(1.5, 3)/sub;
  float hh = dd*random(1, 6);
  float dx = dd*(sub-1)*0.5;
  float dy = dd*(sub-1)*0.5; 
  float min = random(0.4, 0.7);
  float dnx = time*random(-0.02, 0.02);
  float dny = time*random(-0.02, 0.02);
  gra.beginDraw();
  gra.background(10);
  gra.ortho();
  gra.translate(w*0.5, h*0.5, -max(w, h));
  gra.rotateX(PI*random(0.22, 0.28));//PI*random(0.05, 0.25));
  gra.rotateZ(time*random(-0.06, 0.06));
  PVector points[][] = new PVector[sub][sub];
  for (int j = 0; j < sub; j++) {
    for (int i = 0; i < sub; i++) {
      float nh = constrain(noise(i*det+dnx, j*det+dny)-min, 0, 1);
      nh = map(nh, 0, 1-min, 0, 1);
      points[i][j] = new PVector(i*dd-dx, j*dd-dy, nh*hh);
    }
  }
  gra.stroke(255);
  gra.fill(10);
  gra.noFill();
  for (int i = 0; i < sub-1; i++) {
    for (int j = 0; j < sub-1; j++) {
      gra.beginShape();
      gra.vertex(points[i][j].x, points[i][j].y, points[i][j].z);
      gra.vertex(points[i+1][j].x, points[i+1][j].y, points[i+1][j].z);
      gra.vertex(points[i+1][j+1].x, points[i+1][j+1].y, points[i+1][j+1].z);
      gra.vertex(points[i][j+1].x, points[i][j+1].y, points[i][j+1].z);
      gra.endShape(CLOSE);
    }
  }
  gra.endDraw();
  image(gra, x, y);
}

void sensenWave(float x, float y, float w, float h, float time) {
  noFill();
  beginShape();  
  float vel1 = random(0.2);
  float vel2 = random(0.2);
  float vel3 = random(0.2);
  float dt = random(1);
  float dt1 = random(1-dt, 1+dt);
  float dt2 = random(1-dt, 1+dt);
  float dt3 = random(1-dt, 1+dt);
  float amp1 = random(0.8);
  float amp2 = random(1-amp1);
  float amp3 = 1-amp1-amp2;
  for (int i = 0; i <= w; i++) {
    float noi = cos((time*dt1+i)*vel1)*amp1;
    noi      += cos((time*dt2+i)*vel2)*amp2;
    noi      += cos((time*dt3+i)*vel3)*amp3;
    noi = noi*h*0.5+h*0.5;
    vertex(x+i, y+noi);
  }
  endShape();
}

void noiseWave(float x, float y, float w, float h, float time) {
  beginShape();  
  float des = random(10000)+time*random(1);
  float vel = random(0.15)*random(1);
  for (int i = 0; i <= w; i++) {
    float noi = noise(des+i*vel)*h;
    vertex(x+i, y+noi);
  }
  endShape();
}

void multiNoiseWave(float x, float y, float w, float h, float time) {
  int cc = int(random(4, random(8, 20)));
  float dh = h/cc;
  float des = random(10000)+time*random(0.1);
  float vel = random(0.2)*random(1);
  float tt = time*random(0.01);
  for (int j = 0; j < cc; j++) {
    beginShape();  
    for (int i = 0; i <= w; i++) {
      float noi = noise(des+i*vel, j, tt)*dh;
      vertex(x+i, y+noi+j*dh);
    }
    endShape();
  }
}

void vectorField(float x, float y, float w, float h, float time) {
  int cc = int(min(w, h)/random(8, 30));
  int ch, cw;
  if (w > h) {
    ch = cc;
    cw = int(cc*w/h);
  } else {
    cw = cc;
    ch = int(cc*h/w);
  }
  float ww = w/cw;
  float hh = h/ch;
  float det1 = random(0.01);
  float det2 = random(0.05);
  float tt = time*random(0.05, 0.2)*random(0.2, 1);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float xx = x+(i+0.5)*ww;
      float yy = y+(j+0.5)*hh;
      float ang = noise(xx*det1, yy*det1, tt)*TWO_PI*2;
      float amp = noise(xx*det2, yy*det2, tt+10212.023)*0.8;
      line(xx, yy, xx+cos(ang)*ww*amp, yy+sin(ang)*hh*amp);
    }
  }
}