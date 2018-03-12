ArrayList<Pin> pines;
ArrayList<Wire> wires;
Wire selec;

void setup() {
  size(640, 640);
  pines = new ArrayList<Pin>();
  wires = new ArrayList<Wire>();
  for (int i = 0; i < 10; i++) {
    pines.add(new Pin(random(width), random(height)));
  }
  int cc = 64;
  float da = TWO_PI/cc;
  for (int i = 0; i < cc; i++) {
    float xx = width/2+cos(da*i)*200;
    float yy = height/2+sin(da*i)*200;
    pines.add(new Pin(xx, yy));
  }
}

void draw() {
  background(234);
  for (int i = 0; i < pines.size(); i++) {
    Pin p = pines.get(i);
    p.update();
  }
  for (int i = 0; i < wires.size(); i++) {
    Wire w = wires.get(i);
    w.update();
    if (w.remove) wires.remove(i--);
  }
  if (selec != null) {
    selec.update();
  }
}

void mousePressed() {
  selec = new Wire(mouseX, mouseY);
  selec.drag = true;
}

void mouseReleased() {
  for (int i = 0; i < pines.size(); i++) {
    Pin p = pines.get(i);
    if (dist(p.x, p.y, selec.x2, selec.y2) < 10) {
      selec.p2 = p;
    }
  }
  selec.drag = false;

  wires.add(selec);
  selec = null;
}

void mouseDragged() {
  selec.x2 = mouseX;
  selec.y2 = mouseY;
}

class Pin {
  boolean drag;
  float x, y;
  Pin(float x, float y) {
    this.x = x; 
    this.y = y;
  }
  void update() {
    show();
  }
  void show() {
    fill(60);
    stroke(210);
    strokeWeight(2);
    ellipse(x, y, 6, 6);
  }
}

class Wire {
  boolean drag, remove;
  color col;
  float x1, y1, x2, y2;
  float ang, amp, dis;
  Pin p1, p2;
  Wire(float x, float y) {
    x1 = x2 = x;
    y1 = y2 = y;
    p1 = null;
    p2 = null;
    col = rcol();
    amp = random(0.1, 0.9);
    for (int i = 0; i < pines.size(); i++) {
      Pin p = pines.get(i);
      if (dist(p.x, p.y, x1, y1) < 10) {
        p1 = p;
      }
    }
  }
  void update() {
    if (!drag) {
      if (p1 == null) {
        x1 += (x2-x1)*0.2;
        y1 += (y2-y1)*0.2;
      }
      if (p2 == null) {
        x2 += (x1-x2)*0.2;
        y2 += (y1-y2)*0.2;
      }
      float d = dist(x1, y1, x2, y2);
      if (d < 1) {
        remove = true;
      }
    }
    if (p1 != null) {
      x1 += (p1.x-x1)*0.2;
      y1 += (p1.y-y1)*0.2;
    }
    if (p2 != null) {
      x2 += (p2.x-x2)*0.2;
      y2 += (p2.y-y2)*0.2;
    }
    ang = atan2(y2-y1, x2-x1);
    dis = dist(x1, y1, x2, y2);
    amp = cos(frameCount*0.1)*0.1;
    show();
  }
  void show() {
    noFill();
    stroke(0, 22);
    strokeWeight(3);
    float dx = cos(ang+PI/2)*dis*amp;
    float dy = sin(ang+PI/2)*dis*amp;
    bezier(x1, y1+2, x1+dx, y1+dy+2, x2-dx, y2-dy+2, x2, y2+2);
    stroke(col);
    strokeWeight(2);
    bezier(x1, y1, x1+dx, y1+dy, x2-dx, y2-dy, x2, y2);
  }
}

color rcol() {
  return (random(1) < 0.4)?  color(200, 255, 20) : (random(1) < 0.5)? color(20, 255, 200) : color(255, 20, 200);
}