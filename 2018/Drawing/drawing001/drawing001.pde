ArrayList<Trazo> trazos;
ArrayList<PVector> points;
float time;
void setup() {
  size(640, 640);
  smooth(8);
  pixelDensity(2);
  trazos = new ArrayList<Trazo>();
  points = new ArrayList<PVector>();
}

void draw() {
  time = millis()*0.001;
  background(255);
  for (int i = 0; i < trazos.size(); i++) {
    Trazo t = trazos.get(i);
    t.update();
    t.show();
  }

  beginShape();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    vertex(p.x, p.y);
  }
  endShape();
}

void mousePressed() { 
  points.add(new PVector(mouseX, mouseY));
}

void mouseDragged() {
  points.add(new PVector(mouseX, mouseY));
}

void mouseReleased() {
  if (points.size() > 2) trazos.add(new Trazo(points));
  points.clear();
}

float cnoise(float v, float det, float des) {
  v %= 1;
  float ang = v*TWO_PI;
  return noise(des+cos(ang)*det, des+sin(ang)*det);
}


class Trazo {
  ArrayList<PVector> points;
  float x, y, ex, ey, ang;
  float dx, dy, da;
  float time, loop;
  Trazo(ArrayList<PVector> p) {
    loop = 3;
    points = new ArrayList<PVector>(); 
    PVector in = p.get(0);
    PVector en = p.get(p.size()-1);
    PVector in2 = p.get(1);
    x = in.x;
    y = in.y;
    ex = en.x-x;
    ey = en.y-y;
    for (int i = 0; i < p.size(); i++) {
      points.add(p.get(i).copy().sub(in));
    }
    dx = en.x-in.x;
    dy = en.y-in.y;

    ang = atan2(in.y-in2.y, in.x-in2.x);
  }
  void update() {
    time += 1./60;
    if (time >= loop) {
      time -= loop;
      x += dx;
      y += dy;
    }
  }
  void show() {
    noFill();
    stroke(0);
    pushMatrix();
    translate(x, y);
    beginShape();
    PVector p;
    int init = int(map(time%loop, 0, loop, 0, points.size())); 
    for (int i = init; i < points.size(); i++) {
      p = points.get(i);
      vertex(p.x, p.y);
    }
    for (int i = 0; i < init; i++) {
      p = points.get(i).copy().rotate(-ang);
      float dx = ex;
      float dy = ey;
      vertex(p.x+dx, p.y+dy);
    }
    endShape();
    popMatrix();
  }
}