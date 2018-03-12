int fps = 30;
float seconds = 6;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  frameRate(fps);
}

void draw() {
  if (export) time = map(frameCount-1, 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    else saveFrame("export/f####.gif");
  }
}

void keyPressed() {
  seed = int(random(9999999));
  println(seed);
}

int seed = 8056208; 
void render() {

  randomSeed(seed);
  noiseSeed(seed);

  background(10);
  translate(width/2, height/2);

  ArrayList<PVector> points = new ArrayList<PVector>();
  points.add(new PVector(0, 0, 0));
  int cc = 5; 
  float sep = 500;

  float dd = 0.3;
  for (int i = 1; i < cc; i++) {
    PVector ant = points.get(i-1);
    float a1 = random(-PI*dd, PI*dd)-HALF_PI;
    float a2 = random(-PI*dd, PI*dd);
    float x = sin(a1)*sin(a2)*sep;
    float y = sin(a1)*cos(a2)*sep;
    float z = cos(a1)*sep;
    PVector nex = ant.copy().add(x, y, z);
    points.add(nex);
  }

  int sel1 = int(time*(cc-1));
  if (sel1 >= cc) sel1 = cc-1;
  int sel2 = sel1+1;
  if (sel2 >= cc) sel2 = cc-1;

  float tt = (time*(cc-1))%1;
  tt = Easing.ExpoInOut(tt, 0, 1, 1);
  PVector des = points.get(sel1).copy();
  des.lerp(points.get(sel2), tt);

  translate(-des.x, -des.y, -des.z);

  stroke(255);
  strokeWeight(1);
  PVector last = points.get(int(points.size()-1));
  for (int i = 1; i < points.size(); i++) {
    PVector p1 = points.get(i-1);
    PVector p2 = points.get(i);
    lineSeg(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, 30, 0.2);
    pushMatrix();
    translate(-last.x, -last.y, -last.z);
    lineSeg(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, 30, 0.2);
    popMatrix();
    pushMatrix();
    translate(last.x, last.y, last.z);
    lineSeg(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, 30, 0.2);
    popMatrix();
  }


  float sss = 200;
  stroke(255);
  noFill();
  strokeWeight(1.5);
  for (int i = 0; i < points.size()-1; i++) {
    PVector p = points.get(i);
    int ii = i; 
    pushMatrix(); 
    if (i == 0 && sel1 > 1) {
      translate(last.x, last.y, last.z);
      ii = points.size()-1;
    } 
    float s = 0; 
    if ((cc-1+ii)%cc == sel1) s = ((time*(cc-1))%1);
    if (ii == sel1) s = (1-((time*(cc-1))%1)*1.5);
    if (s < 0) s = 0;
    float ss = sss*Easing.ElasticInOut(s, 0, random(1, 5), 1, 0, 1);
    float tttt = Easing.ExpoInOut(pow(1-s, random(1, 2)), 0, 1, 1);
    strokeWeight(1.5*s);
    translate(p.x, p.y, p.z);
    int ccc = int(random(10, 30));
    for (int j = 0; j < ccc; j++) {
      rotateX(random(TWO_PI)+tttt*random(-2, 2));
      rotateY(random(TWO_PI)+tttt*random(-2, 2));
      rotateZ(random(TWO_PI)+tttt*random(-2, 2));

      int rnd = int(random(5));
      if (rnd == 0) {
        lineSeg(0, 0, 0, ss*0.51, 0, 0, int(random(2, 28)), 0.5);
      }
      if (rnd == 1) {
        ellipse(0, 0, ss, ss);
      }
      if (rnd == 2) {
        int sub = int(random(3, 40));
        float amp = random(0.1, 0.9);
        float da = TWO_PI/sub;
        for (int k = 0; k < sub; k++) {
          arc(0, 0, ss, ss, da*k, da*(k+amp));
        }
      }
      if (rnd == 3) {
        int sub = int(pow(2, int(random(3, 8))));
        float da = TWO_PI/sub;
        float amp = random(0.2, 1);
        for (int k = 0; k < sub; k++) {
          float x = cos(da*k+tttt)*ss*0.5;
          float y = sin(da*k+tttt)*ss*0.5;
          float h = (5-(k%2)*2)*amp;
          line(x, y, -h, x, y, h);
        }
      }
    }
    popMatrix();
  }
}  

void lineSeg(float x1, float y1, float z1, float x2, float y2, float z2, int sub, float amp) {
  float dx = (x2-x1)/sub;
  float dy = (y2-y1)/sub;
  float dz = (z2-z1)/sub;
  for (int i = 0; i < sub; i++) {
    float xx = x1 + dx * i;
    float yy = y1 + dy * i;
    float zz = z1 + dz * i;
    line(xx, yy, zz, xx+dx*amp, yy+dy*amp, zz+dz*amp);
  }
}