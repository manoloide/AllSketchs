ArrayList<Trazo> trazos;

float cx, cy;
float time;

void setup() {
  size(640, 640, P2D);
  pixelDensity(2);
  noiseDetail(1);
  cx = width/2;
  cy = height/2;

  trazos = new ArrayList<Trazo>();
  for (int i = 0; i < 20; i++) {
    trazos.add(new Trazo());
  }
}

void draw() {
  time = millis()*0.001;
  background(255);
  stroke(0);

  //cx += (trazo.x-cx)*0.1;
  //cy += (trazo.y-cy)*0.1;
  translate(width/2, height/2);

  for (int i = 0; i < trazos.size(); i++) {
    Trazo trazo = trazos.get(i);
    trazo.update();
    trazo.show();
  }
}

void keyPressed() {
  trazos = new ArrayList<Trazo>();
  for (int i = 0; i < 200; i++) {
    trazos.add(new Trazo());
  }
}

class Trazo {
  ArrayList<PVector> points;
  float x, y;
  float det, des, loop;
  Trazo() {
    points = new ArrayList<PVector>();
    points.add(new PVector(cx, cy));
    det = random(0.1, 1);
    des = random(2000);
    loop = random(1, 10);
  }

  void update() {
    PVector p = points.get(points.size()-1).copy();
    float ang = noise(time*det*2+des)*TWO_PI*2;
    float vv = map(time%loop, 0, loop, 0, 1); 
    ang = cnoise(vv, det, des)*TWO_PI*4;
    float vel = map(cos(vv*TWO_PI), -1, 1, 1, 5);
    p.add(cos(ang)*vel, sin(ang)*vel);
    points.add(p);
    x = p.x;
    y = p.y;
  }

  void show() {
    PVector p = points.get(points.size()-1);
    noFill();
    pushMatrix();
    translate(-p.x, -p.y);
    beginShape();
    float d, a, xx, yy, ax, ay;
    ax = ay = 0;
    for (int i = 0; i < points.size(); i++) {
      p = points.get(i);
      ax = p.x;
      ay = p.y;
      vertex(p.x, p.y);
    }
    endShape();
    popMatrix();

    if (points.size() > 1000) points.remove(0);
  }
}

float cnoise(float v, float det, float des) {
  float ang = v*TWO_PI;
  return noise(des+cos(ang)*det, des+sin(ang)*det);
}