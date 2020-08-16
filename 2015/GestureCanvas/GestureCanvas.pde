Gesture gesture;

void setup() {  
  size(800, 600);
  gesture = new Gesture();
  frame.setResizable(true);
}


void draw() {
  background(80);
  int sep = 20;
  stroke(90);
  strokeWeight(1);
  for (int i = 0; i <= width; i+=sep) {
    line(i, 0, i, height);
  }
  for (int i = 0; i <= height; i+=sep) {

    line(0, i, width, i);
  }
  gesture.update();
  gesture.show();
}

void mousePressed() {
  gesture = new Gesture(new PVector(mouseX, mouseY));
}

void mouseDragged() {
  gesture.addPoint(new PVector(mouseX, mouseY));
}

void mouseReleased() {
  gesture.process();
}


class Gesture {
  ArrayList<PVector> points;
  Gesture() {
    init();
  }

  Gesture(ArrayList<PVector> points) {
    init();
    this.points = points;
  }

  Gesture(PVector point) {
    init();
    points.add(point);
  }

  void init() {
    points = new ArrayList<PVector>();
  }

  void update() {
  }

  void show() {
    strokeWeight(2);
    stroke(200);
    for (int i = 1; i < points.size (); i++) {
      PVector ant = points.get(i-1);
      PVector act = points.get(i);
      line(ant.x, ant.y, act.x, act.y);
    }
  }

  void clear() {
    init();
  }

  void process() {
    for (int i = 1; i < points.size ()-1; i++) {
      PVector ant = points.get(i-1);
      PVector act = points.get(i);
      PVector sig = points.get(i+1);
      float a1 = atan2(act.y-ant.y, act.x-ant.x);
      float a2 = atan2(sig.y-act.y, sig.x-act.x);
      if (abs(a1-a2) < 0.2) {
        points.remove(i--);
      }
    }

    for (int i = 1; i < points.size (); i++) {
      PVector ant = points.get(i-1);
      PVector act = points.get(i);
      if (ant.dist(act) < 5) {
        PVector aux = new PVector(ant.x, ant.y);
        aux.add(act);
        aux.div(2);
        points.remove(i);
        points.remove(i-1);
        points.add(i-1, aux);
      }
    }

    int sep = 20;
    for (int i = 0; i < points.size (); i++) {
      PVector act = points.get(i);
      float dx = act.x%sep;
      float dy = act.y%sep;
      act.x += (abs(dx) < sep/2)? -dx : dx;
      act.y += (abs(dy) < sep/2)? -dy : dy;
    }
  }

  void addPoint(PVector point) {
    points.add(point);
  }
}

