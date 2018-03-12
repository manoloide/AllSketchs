void setup() {
  size(960, 960);
  rectMode(CENTER);
  smooth(8);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String name = nf(day(), 2)+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2);
  saveFrame(name+".png");
}

void generate() {

  background(255);
  float cx = width/2;
  float cy = height/2;

  int cc = int(random(3, 40)); 
  int ver = int(random(3, 16));
  int sub = int(random(1, 40*random(0.5, 1))*2+1);
  float dd = random(1);
  float ang = random(TWO_PI);

  float va = random(-PI, PI)*random(1);
  float desx = random(-10, 10);
  float desy = random(-10, 10);
  va = desx = desy = 0;

  noFill();
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < cc; i++) {
    ang += va;
    cx += desx;
    cy += desy;
    float s1 = map(i, 0, cc-0.5, width*3, 0);
    float s2 = map(i+1, 0, cc-0.5, width*3, 0);
    float ds = (s1-s2)*0.25;
    float r1 = s1*0.5; 
    float r2 = s2*0.5+ds;
    float da = TWO_PI/ver; 
    for (int j = 0; j < ver; j++) {
      float a = ang+da*j;
      float x1 = cx+cos(a)*r1;
      float y1 = cy+sin(a)*r1;
      float x2 = cx+cos(a+da)*r1;
      float y2 = cy+sin(a+da)*r1;
      for (int k = 0; k < sub; k++) {
        float xx1 = map(k, 0, sub, x1, x2);
        float yy1 = map(k, 0, sub, y1, y2);
        points.add(new PVector(xx1, yy1));
      }
    }
    float dx = random(ds)-ds*0.5*dd;
    float dy = random(ds)-ds*0.5*dd;
    for (int j = 0; j < ver; j++) {
      float a = ang+da*j;
      float x1 = cx+cos(a)*r2;
      float y1 = cy+sin(a)*r2;
      float x2 = cx+cos(a+da)*r2;
      float y2 = cy+sin(a+da)*r2;
      for (int k = 0; k < sub; k++) {
        float xx1 = map(k, 0, sub, x1, x2);
        float yy1 = map(k, 0, sub, y1, y2);
        points.add(new PVector(xx1+dx, yy1+dy));
      }
    }
  }

  noStroke();
  strokeWeight(1);
  for (int i = 0; i < cc*2-1; i++) {
    int a1 = ver*sub;
    for (int j = 0; j < a1; j++) {
      int ind1 = (j+0)%a1+(i+0)*a1;
      int ind2 = (j+1)%a1+(i+0)*a1;
      int ind3 = (j+1)%a1+(i+1)*a1;
      int ind4 = (j+0)%a1+(i+1)*a1;
      PVector p1 = points.get(ind1);
      PVector p2 = points.get(ind2);
      PVector p3 = points.get(ind3);
      PVector p4 = points.get(ind4);
      stroke(col(j), 100);
      fill(col(j));
      beginShape();
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(p3.x, p3.y);
      vertex(p4.x, p4.y);
      endShape(CLOSE);
    }
  }
}

int pallet[] = {color(0), color(0), color(255), color(0), color(255)};

int col(int v) {
  return pallet[v%pallet.length];
}