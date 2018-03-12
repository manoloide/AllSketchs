void setup() {
  size(960, 960);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  background(240);
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 300; i++) {
    PVector a = new PVector();
    a.x = width*random(0.1, 0.9);
    a.y = height*random(0.1, 0.9);
    a.z = random(0.4)*random(1);

    boolean add = true;
    for (int j = 0; j < points.size (); j++) {
      PVector p = points.get(j);
      if (dist(a.x, a.y, p.x, p.y) < (width*(a.z+p.z))*1.1) {
        add = false;
        break;
      }
    }

    if (add) points.add(a);
  }
  stroke(0, 30);
  for (int j = 0; j < points.size (); j++) {
    PVector aux = points.get(j);
    float xx = aux.x;
    float yy = aux.y;
    float mr = aux.z; 
    int cc = int(PI*pow(int(map(mr, 0, 0.4, 0, 40000)), 1));
    for (int i = 0; i < cc; i++) {
      float r = width*(mr-random(mr)*random(0.1, 1));
      float a = random(TWO_PI);
      float x = xx+cos(a)*r;
      float y = yy+sin(a)*r;
      a += random(-0.3, 0.3);
      float l = random(mr*120)*sin(map(r, 0, width*0.4, 0.1, 1)*PI/2);
      line(x, y, x+cos(a)*l, y+sin(a)*l);
    }
  }

  stroke(0, 30);
  float diag = dist(0, 0, width, height);
  for (int i = 0; i < 300000; i++) {
    float x = random(width);
    float y = random(height);
    if (random(1-dist(x, y, width/2, height/2)/(diag*0.5)) > 0.1) continue;
    float lar = random(4, 8);
    float a = random(TWO_PI);
    boolean dra = true;
    for (int j = 0; j < points.size (); j++) {
      PVector p = points.get(j);
      if (dist(p.x, p.y, x+cos(a)*-lar, y+sin(a)*-lar) < (width*p.z)*1.1+2 || dist(p.x, p.y, x+cos(a)*lar, y+sin(a)*lar) < (width*p.z)*1.1+2) {
        dra = false;
        break;
      }
    }
    if (dra) line(x+cos(a)*-lar, y+sin(a)*-lar, x+cos(a)*lar, y+sin(a)*lar);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

