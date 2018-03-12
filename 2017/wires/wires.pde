ArrayList<Pin> pines;
ArrayList<Wire> wires;
PGraphics renderPin;


int actCol = int(random(4));

Pin pinOn;
Wire wireOn;

void setup() {
  size(720, 720, P2D);
  smooth(4);
  pixelDensity(2);
  create();
}

void create() {
  int ss = 40; 
  int cw = int(width*1.0/ss);
  int ch = int(height*1.0/ss);
  pines = new ArrayList<Pin>();
  wires = new ArrayList<Wire>();
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      pines.add(new Pin(i*ss, j*ss, ss));
    }
  }

  pinOn = null;
  wireOn = null;

  renderPin = createGraphics(ss, ss);
  renderPin.beginDraw();
  renderPin.noStroke();
  renderPin.fill(60);
  renderPin.ellipse(ss*0.5, ss*0.5, ss*0.7, ss*0.7);
  renderPin.fill(0);
  renderPin.ellipse(ss*0.5, ss*0.5, ss*0.55, ss*0.55);
  renderPin.endDraw();
}


void draw() {

  background(120);
  strokeWeight(1);
  pinOn = null;
  for (int i = 0; i < pines.size(); i++) {
    pines.get(i).update();
    pines.get(i).show();
  }

  for (int i = 0; i < wires.size(); i++) {
    wires.get(i).update();
    wires.get(i).show();
  }
}

void keyPressed() {
  if (key == 'c') {
    create();
  }
}

void mousePressed() {
  if (pinOn != null) {
    wireOn =  pinOn.wire;
    if (wireOn == null) {
      wireOn = new Wire(pinOn, null);
      pinOn.wire = wireOn;
      wires.add(wireOn);
    } else {
      wireOn.disconnect(pinOn);
    }
  }
}

void mouseDragged() {
}

void mouseReleased() {
  if (wireOn != null) {
    if (pinOn == null) {
      wireOn.remove();
    } else {
      if (pinOn.wire != null) pinOn.wire.remove();
      wireOn.connect(pinOn);
      if (wireOn.in == wireOn.out) {
        wireOn.remove();
      }
    }
  }
  wireOn = null;
}

class SprintPoint {
  float mass;       // Mass 
  float k = 0.2;    // Spring constant 
  float damp;       // Damping 
  float rx;  // Rest position X 
  float ry;  // Rest position Y 

  float velx = 0.0;   // X Velocity 
  float vely = 0.0;   // Y Velocity 
  float accel = 0;    // Acceleration 
  float force = 0;    // Force 

  float x, y, nx, ny, s;
  //240, 260, 40, 0.98, 8.0, 0.1
  SprintPoint(float x, float y, int s, float m, float k) { 
    this.x = nx = rx =  x; 
    this.x = ny = ry = y;
    this.s = s;
    this.damp = 0.96; 
    this.mass = m; 
    this.k = k;
  }

  void update(float rx, float ry) {
    this.rx = rx; 
    this.ry = ry;

    force = -k*(ny-ry);
    accel = force / mass;
    vely = damp * (vely + accel);
    ny = ny + vely;

    force = -k * (nx - rx);
    accel = force / mass;
    velx = damp * (velx + accel);
    nx = nx + velx;
  }
}

class Wire {
  boolean remove, dragged;
  color col;
  float dd;
  SprintPoint center;
  Pin in, out;
  Wire(Pin in, Pin out) {
    this.in = in;
    this.out = out;
    actCol++;
    col = colors[actCol%colors.length];

    center = new SprintPoint(mouseX, mouseY, 40, 4, 0.06);
  }
  void update() {
  }
  void show() {
    float x1 = mouseX;
    float y1 = mouseY;
    float x2 = mouseX;
    float y2 = mouseY;

    if (in != null) {
      x1 = in.x+in.s*0.5;
      y1 = in.y+in.s*0.5;
    }
    if (out != null) {
      x2 = out.x+out.s*0.5;
      y2 = out.y+out.s*0.5;
    }

    float cx = (x1+x2)*0.5;
    float cy = (y1+y2)*0.5;
    float ww = abs(x1-x2);
    float hh = abs(y1-y2);
    float dd = (hh*0.5+ww*0.2)*1.4;

    center.update(cx, cy+dd);

    stroke(col);
    strokeWeight(8);
    beginShape();
    curveVertex(x1, y1);
    curveVertex(x1, y1);
    curveVertex(center.nx, center.ny);
    curveVertex(x2, y2);
    curveVertex(x2, y2);
    endShape();
  }

  void connect(Pin pin) {
    if (in == null) {
      in = pin;
      in.wire = this;
    } else if (out == null) {
      out = pin;
      out.wire = this;
    }
  }  

  void disconnect(Pin pin) {
    if (in == pin) {
      in.wire = null;
      in = null;
    }
    if (out == pin) {
      out.wire = null;
      out = null;
    }
  }

  void remove() {
    if (in != null) in.wire = null;
    if (out != null) out.wire = null;
    wires.remove(this);
  }
}

class Pin {
  boolean on;
  float x, y, s;
  Wire wire;
  Pin(float x, float y, float s) {
    this.x = x; 
    this.y = y; 
    this.s = s;
    wire = null;
  }

  void update() {
    on = mouseX >= x && mouseX <= x+s && mouseY >= y && mouseY <= y+s;
    if (on) {
      on = dist(mouseX, mouseY, x+s*0.5, y+s*0.5) < s*0.4;
      if (on) pinOn = this;
    }
  }

  void show() {
    image(renderPin, x, y);
    noFill();
    stroke((on)? 150 : 130);
    if (wire != null) stroke(wire.col);
    ellipse(x+s*0.5, y+s*0.5, s*0.9-0.5, s*0.9-0.5);
  }
}

int colors[] = {#E0212B, #2AC942, #17AED8, #F7C41D};
int rcol() {
  return colors[int(random(colors.length*2))%colors.length];
}