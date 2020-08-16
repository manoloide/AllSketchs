int seed;

ArrayList<Fish> fishes;
float det, des;
PShader blur;

void setup() {
  size(720, 720, P2D);
  blur = loadShader("blur.glsl"); 
  pixelDensity(2);

  generate();
}

void draw() {
  background(#312E2C);

  if (frameCount%1 == 0) fishes.add(new Fish(random(-100, width+100), random(-100, height+100), random(80, 240)));
  if (frameCount%1 == 0) fishes.add(new Fish(random(width), random(height), random(80, 240)));

  noiseDetail(2);
  for (int i = 0; i < fishes.size(); i++) {
    Fish f = fishes.get(i);
    f.update();
    f.show();
    if (f.remove) fishes.remove(f);
  }
  if (frameCount%20 == 0) 
    blur = loadShader("blur.glsl");
  //filter(blur);
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void mousePressed() {
  fishes.add(new Fish(mouseX, mouseY, random(20, 120)));
}

void mouseMoved() {
  //if (frameCount%3 == 0) 
  //fishes.add(new Fish(mouseX, mouseY, random(20, 120)));
}

void generate() {
  seed = int(random(999999));

  randomSeed(seed);

  des = random(1000);
  det = random(0.004);

  fishes = new ArrayList<Fish>();
}

class Fish {
  ArrayList<PVector> points;
  FloatList angles;
  boolean remove;
  color col1, col2;
  float x, y, s, vel, amp;
  float time, timeLife;
  float c1, c2, vc1, vc2;
  Fish(float x, float y, float s) {
    this.x = x; 
    this.y = y;
    this.s = s;

    vel = s*random(0.01, 0.04);

    time = 0;
    timeLife = random(4, 8);
    c1 = random(colors.length);
    c2 = random(colors.length);
    vc1 = random(0.05)*random(1);
    vc2 = random(0.05)*random(1);

    points = new ArrayList<PVector>();
    angles = new FloatList();
  }

  void update() {
    float dir = noise(des+x*det, des+y*det)*TAU;
    time += 1./60;

    c1 += vc1;
    c2 += vc2;
    col1 = getColor(c1);
    col2 = getColor(c2);

    float pt = pow(map(time, 0, timeLife, 0, 1), 1.2);

    amp = 0;
    if (pt < 0.2) amp = map(pt, 0, 0.2, 0, 1);
    else if (pt > 0.7) amp = map(pt, 0.7, 1, 1, 0);
    else amp = 1;

    x += cos(dir)*vel;
    y += sin(dir)*vel;


    points.clear();
    angles.clear();
    float xx = x;
    float yy = y;
    float sv = 10;
    float cs = s*1./sv;
    for (int i = 0; i <= cs; i++) {
      float ang = noise(des+xx*det, des+yy*det)*TAU;
      angles.push(ang);
      points.add(new PVector(xx, yy));
      xx += cos(ang+PI)*sv*amp;
      yy += sin(ang+PI)*sv*amp;
    }
    endShape();


    if (time > timeLife) {
      remove = true;
    }
  }

  void show() {
    if (points.size() <= 0) return;

    float xx = x;
    float yy = y;

    float ss = s*0.2*amp;
    noStroke();
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      float ang = angles.get(i);
      float val = map(i, points.size()-1, 0, 0, 1);
      float a = pow(val, 0.7)*ss*0.5;
      fill(lerpColor(col1, col2, val));
      vertex(p.x+cos(ang+HALF_PI)*a, p.y+sin(ang+HALF_PI)*a);
    }
    for (int i = points.size()-1; i >= 0; i--) {
      PVector p = points.get(i);
      float ang = angles.get(i);
      float val = map(i, points.size()-1, 0, 0, 1);
      float a = pow(val, 0.7)*ss*0.5;
      fill(lerpColor(col1, col2, val));
      vertex(p.x+cos(ang-HALF_PI)*a, p.y+sin(ang-HALF_PI)*a);
    }
    endShape();

    ellipse(xx, yy, ss, ss);


    /*
    stroke(190);
     arc(xx, yy, 20, 20, PI*1.5, PI*(1.5+time*2/timeLife));
     */
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#DDD3C9, #EE9A02, #EB526E, #0169B3, #024E2C};
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