/* sacar lines de los puntos, una cantidad fija, jugar con las cantidad
 // hacer que las lineas se corten al cruzarce, desde el punto de nacimiento
 */

int seed = int(random(999999));
void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class rect {
  float x, y, w, h;
  rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

void generate() { 

  //add = loadShader("addfrag.glsl", "addvert.glsl");

  int aux[] = {#000F29, #FE0706, #F85E8D, #3E56A8, #090D0E, #06A5FF, #FE0706, #F85E8D, #06A5FF};
  colors = aux;

  colorMode(HSB);
  float hr = random(360);
  println(hr);
  for (int i = 0; i < aux.length; i++) {
    int col = aux[i];
    colors[i] = color((hue(col)+hr)%360, saturation(col), brightness(col));
  }
  colorMode(RGB);

  randomSeed(seed);
  noiseSeed(seed);

  background(252);

  int grid = 40;

  stroke(0, 4);
  for (int i = 0; i < width; i+=grid) {
    line(0, i, width, i);
    line(i, 0, i, height);
  }

  stroke(0, 30);
  for (int j = 0; j < height; j+=grid) {
    for (int i = 0; i < width; i+=grid) {
      point(i+0.5, j+0.5);
    }
  }

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 10; i++) {
    float x = random(width);
    float y = random(height);
    x -= x%grid;
    y -= y%grid;
    float s = width*random(0.04, 0.7);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(x, y, p.x, p.y) < (s+p.z)*0.5) {
        add = false; 
        break;
      }
    }
    if (add) {
      points.add(new PVector(x, y, s));
    }
  }

  ArrayList<Line> lines = new ArrayList<Line>();
  float diag = dist(0, 0, width, height);
  for (int i = 0; i < points.size(); i++) {
    PVector p1 = points.get(i).copy();

    int cc = int(random(3, 20));
    float da = TAU/cc;
    float a = random(TAU);

    for (int j = 0; j < cc; j++) {
      PVector p2 = p1.copy().add(cos(a+da*j)*diag, sin(a+da*j)*diag);
      lines.add(new Line(p1.x, p1.y, p2.x, p2.y));
    }
  }

  ArrayList<PVector> inters = new ArrayList<PVector>();
  for (int j = 0; j < lines.size(); j++) {
    Line l1 = lines.get(j);
    for (int i = 0; i < lines.size(); i++) {
      if (i == j) continue;
      Line l2 = lines.get(i);
      PVector p = lineLineIntersect(l1, l2);
      if (p != null) {
        inters.add(p);
      }
    }
  }

  /*
  stroke(0);
   for (int i = 0; i < lines.size(); i++) {
   Line l = lines.get(i);
   l.show();
   }
   
   noFill();
   stroke(0, 200);
   for (int i = 0; i < inters.size(); i++) {
   PVector p = inters.get(i);
   ellipse(p.x, p.y, 3, 3);
   }
   */

  noStroke();
  for (int i = 0; i < inters.size()*0.5; i++) {
    PVector p1 = inters.get(int(random(inters.size())));
    PVector p2 = inters.get(int(random(inters.size())));
    PVector p3 = inters.get(int(random(inters.size())));
    beginShape();
    fill(rcol(), random(80)*random(1));
    vertex(p1.x, p1.y);
    fill(rcol(), random(80)*random(1));
    vertex(p2.x, p2.y);
    fill(rcol(), random(80)*random(1));
    vertex(p3.x, p3.y);
    endShape(CLOSE);
  }

  noFill();
  stroke(0, 12);
  for (int i = 0; i < inters.size(); i++) {
    PVector p1 = inters.get(int(random(inters.size())));
    PVector p2 = inters.get(int(random(inters.size())));
    line(p1.x, p1.y, p2.x, p2.y);
  }
}

class Line {
  PVector p1, p2;
  Line(float x1, float y1, float x2, float y2) {
    p1 = new PVector(x1, y1);
    p2 = new PVector(x2, y2);
  }
  void show() {
    line(p1.x, p1.y, p2.x, p2.y);
  }
}

PVector lineLineIntersect(Line l1, Line l2) {
  return lineLineIntersect(l1.p1.x, l1.p1.y, l1.p2.x, l1.p2.y, l2.p1.x, l2.p1.y, l2.p2.x, l2.p2.y);
}

PVector lineLineIntersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4 ) {
  float a1 = y2 - y1;
  float b1 = x1 - x2;
  float c1 = a1*x1 + b1*y1;

  float a2 = y4 - y3;
  float b2 = x3 - x4;
  float c2 = a2*x3 + b2*y3;

  float det = a1*b2 - a2*b1;
  if (det == 0) {
    return null;
  } else {
    float x = (b2*c1 - b1*c2)/det;
    float y = (a1*c2 - a2*c1)/det;
    if (x > min(x1, x2) && x < max(x1, x2) && 
      x > min(x3, x4) && x < max(x3, x4) &&
      y > min(y1, y2) && y < max(y1, y2) &&
      y > min(y3, y4) && y < max(y3, y4)) {
      return new PVector(x, y);
    }
  }
  return null;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
//int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
int colors[] = {#000F29, #FE0706, #F85E8D, #3E56A8, #090D0E, #06A5FF, #FE0706, #F85E8D, #06A5FF};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
