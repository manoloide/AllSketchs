int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();

  //render();
  noStroke(); 
  ellipse(-10, -10, 2, 2);
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  seed = int(random(999999));

  render();
}

void render() {
  background(getColor(random(colors.length*2)));
  //translate(width/2, height/2);

  stroke(255);
  ArrayList<Line> lines = new ArrayList<Line>();

  for (int i = 0; i < 50000; i++) {
    float cx = random(width); 
    float cy = random(height);
    float ss = random(5, random(100, 600));
    float a = random(TWO_PI);

    Line nl = new Line(cx, cy, ss, a);

    boolean add = true;
    for (int j = 0; j < lines.size(); j++) {
      Line al = lines.get(j);
      if (polyPoly(nl.getPoly(), al.getPoly())) {
        add = false; 
        break;
      }
    }
    if (add) lines.add(nl);
  }

  for (int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i); 
    l.show();

    /*
    noFill(); 
     stroke(255); 
     PVector[] p = l.getPoly(); 
     beginShape(); 
     for (int j = 0; j < p.length; j++) {
     vertex(p[j].x, p[j].y);
     }
     endShape(CLOSE);
     */
  }
}

class Line {
  float c1, c2; 
  float s, ss, a, h; 
  PVector p1, p2;
  Line(float x, float y, float s, float a) {   
    this.s = s; 
    this.a = a; 
    ss = s*0.8;
    float dx = cos(a)*s*0.5; 
    float dy = sin(a)*s*0.5; 
    c1 = random(colors.length); 
    c2 = c1+random(colors.length*0.5)*random(1);
    p1 = new PVector(x-dx, y-dy); 
    p2 = new PVector(x+dx, y+dy);
  }

  void show() {
    line(p1.x, p1.y, p2.x, p2.y, ss, ss, c1, c2);
  }

  PVector[] getPoly() {
    PVector[] aux = new PVector[4];
    float dx1 = cos(a-HALF_PI)*ss*0.55;
    float dy1 = sin(a-HALF_PI)*ss*0.55;
    float dx2 = cos(a)*ss*0.55;
    float dy2 = sin(a)*ss*0.55;
    aux[0] = new PVector(p1.x+dx1-dx2, p1.y+dy1-dy2);
    aux[1] = new PVector(p1.x-dx1-dx2, p1.y-dy1-dy2);
    aux[2] = new PVector(p2.x-dx1+dx2, p2.y-dy1+dy2);
    aux[3] = new PVector(p2.x+dx1+dx2, p2.y+dy1+dy2); 
    return aux;
  }
}

void line(float x1, float y1, float x2, float y2, float s1, float s2, float c1, float c2) {
  float a = atan2(y2-y1, x2-x1); 
  float dx = cos(a);
  float dy = sin(a);
  float dis = dist(x1, y1, x2, y2);
  int cc = int(dis+1);
  float dd = dis*1./cc; 
  float r = 1; 
  noStroke();
  for (int i = 0; i <= cc; i++) {
    fill(getColor(map(i, 0, cc, c1, c2)));
    r = map(i, 0, cc, s1, s2);
    ellipse(x1+dx*dd*i, y1+dy*dd*i, r, r);
  }
}



int colors[] = {#F8CA9C, #F8B6D9, #EF276B, #A14FBE, #1D43B8};
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};
int rcol() {
  return colors[int(random(colors.length))] ;
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}