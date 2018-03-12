ArrayList<Line> lines;

void setup() {
  size(1600, 1600);
  lines = new ArrayList<Line>();
  for (int i = 0; i < 10; i++) {
    lines.add(new Line()); 
    lines.get(i).des = (i+1)/10.;
  }
  background(255);
}

void draw() {
  //background(250);
  if (mousePressed) {
    for (int i = 0; i < lines.size (); i++) {
      Line l = lines.get(i);
      l.setCenter(mouseX, mouseY);
      l.update();
    }
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  //background(250);
  int cant = 20;
  ArrayList<Line> lines = new ArrayList<Line>();
  ArrayList<PVector> centros = new ArrayList<PVector>(); 
  for (int i = 0; i < cant; i++) {
    //for (int j = 0; j < 10; j++) {
    lines.add(new Line());   
    lines.get(i).des = (i+1)*1./cant;
    //}
    centros.add(new PVector(width/2, height/2, random(TWO_PI)));
  }
  for (int j = 0; j < 1000; j++) {
    for (int i = 0; i < lines.size (); i++) {
      Line l = lines.get(i);
      PVector cen = centros.get(i);
      cen.z += random(-0.8, 0.8);
      cen.x += cos(cen.z)*20;
      cen.y += sin(cen.z)*20;
      l.setCenter(cen.x, cen.y);
      l.update();
    }
  }
}

void mouseReleased() {
  for (int i = 0; i < lines.size (); i++) {
    Line l = lines.get(i);
    l.clear();
  }
}


class Point {
  float ax, ay, x, y;
  Point(float x, float y) {
    this.x = ax = x;
    this.y = ay = y;
  }
  void set(float x, float y) {
    ax = x;
    ay = y;
    this.x = x;
    this.y = y;
  }
}
class Line {
  ArrayList<Point> points;
  color col;
  float x, y;
  int maxCount;
  float des;
  Line() {
    col = color(random(256), random(256), random(256));
    points = new ArrayList<Point>();
    maxCount = 12;
    des = 0.8;
  }
  void update() {
    //setCenter(mouseX, mouseY);
    add(new Point(x, y));
    for (int i = 0; i < points.size (); i++) {
      Point p = points.get(i);
      if (i == 0) {
        p.set(p.x+(x-p.x)*des, p.y+(y-p.y)*des);
      } else {
        Point ap = points.get(i-1);
        p.set(p.x+(ap.x-p.x)*des, p.y+(ap.y-p.y)*des);
        if (ap.x == p.x && ap.y == p.y) {
          points.remove(i--);
        }
      }
    }
    show();
  }
  void show() {
    stroke(0, 4);
    fill(#FFE91F, 2);
    stroke(0, 10);
    fill(col, 6);
    beginShape();
    for (int i = 0; i < points.size (); i++) {
      Point p = points.get(i);
      vertex(p.x, p.y);
    }
    endShape();
  }
  void setCenter(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void add(Point p) {
    points.add(0, p);
    if (points.size() > maxCount) {
      points.remove(maxCount);
    }
  }
  void clear() {
    points = new ArrayList<Point>();
  }
}


void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 4)+".png");
}
