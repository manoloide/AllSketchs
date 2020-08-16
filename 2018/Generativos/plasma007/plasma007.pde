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

  randomSeed(seed);
  noiseSeed(seed);

  background(252);

  int grid = 80;

  noStroke();
  for (int j = 0; j < height; j+=grid) {
    for (int i = 0; i < width; i+=grid) {
      fill(rcol(), 20);
      if (random(1) < 0.1) {
        rect(i+2, j+2, grid-3, grid-3);
      }
      rect(i+grid*0.5-2.5, j+grid*0.5-2.5, 2, 2);
    }
  }

  stroke(0, 5);
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
  FloatList angles = new FloatList();
  
  float des = random(1000);
  float det = random(0.002);
  
  for (int i = 0; i <  1000; i++) {
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
      angles.push(noise(des+x*det, des+y*det)*TAU*2);
    }
  }

  ArrayList<Line> lines = new ArrayList<Line>();
  float diag = dist(0, 0, width, height);
  for (int i = 0; i < points.size(); i++) {
    PVector p1 = points.get(i).copy();

    int cc = 4;//int(random(12, 47));
    float da = TAU/cc;
    float a = angles.get(i);

    for (int j = 0; j < cc; j++) {
      PVector p2 = p1.copy().add(cos(a+da*j)*diag, sin(a+da*j)*diag);
      lines.add(new Line(p1.x, p1.y, p2.x, p2.y));
    }
  }

  ArrayList<Line> newLines = new ArrayList<Line>();

  for (int j = 0; j < lines.size(); j++) {
    Line l1 = lines.get(j);
    float minDis = diag+1;
    boolean add = false;
    PVector min = new PVector();
    for (int i = j+1; i < lines.size(); i++) {
      if (i == j) continue;
      Line l2 = lines.get(i);
      PVector p = lineLineIntersect(l1, l2);
      if (p != null) {
        float dis = dist(l1.p1.x, l1.p1.y, p.x, p.y);
        if (dis < minDis) {
          minDis = dis;
          min = p;
          add = true;
        }
      }
    }
    if (add) newLines.add(new Line(l1.p1.x, l1.p1.y, min.x, min.y));
  }

  lines = newLines;

  for (int j = 0; j < lines.size(); j++) {
    Line l1 = lines.get(j);
    float ang = atan2(l1.p2.y-l1.p1.y, l1.p2.x-l1.p1.x); 
    l1.p2.x += cos(ang)*diag;
    l1.p2.y += sin(ang)*diag;

    float minDis = diag+1;
    for (int i = j+1; i < lines.size(); i++) {
      if (i == j) continue;
      Line l2 = lines.get(i);
      PVector p = lineLineIntersect(l1, l2);
      if (p != null) {
        float dis = dist(l1.p1.x, l1.p1.y, p.x, p.y);
        if (dis < minDis) {
          minDis = dis;
          l1.p2.x = p.x;
          l1.p2.y = p.y;
        }
      }
    }
  }

  stroke(0, 120);
  for (int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i);
    stroke(rcol(), 120);
    l.show();
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float a = angles.get(i)+int(random(4))*HALF_PI;
    noStroke();
    arc2(p.x, p.y, p.z*0, p.z, a, a+HALF_PI, rcol(), 20, 0);


    arc2(p.x, p.y, p.z*0, p.z*0.8, a, a+HALF_PI, rcol(), 250, 250);
    int cc = int(p.z*0.11);
    float ss = p.z*0.8/cc;
    noFill();
    strokeWeight(1.8);
    strokeCap(SQUARE);
    for (int j = 0; j < cc; j++) {
      stroke(getColor());
      arc(p.x, p.y, ss*j, ss*j, a, a+HALF_PI);
    }
    strokeWeight(1);
    noStroke();
    blendMode(ADD);
    arc2(p.x, p.y, p.z*0, p.z*0.8, a, a+HALF_PI, rcol(), 240, 0);
    blendMode(BLEND);



    arc2(p.x, p.y, p.z*0.4, p.z, a+HALF_PI, a+TAU, rcol(), 0, 50);
    arc2(p.x, p.y, p.z*0.8, p.z, a+HALF_PI, a+TAU, rcol(), 0, 80);
    
    
    arc2(p.x, p.y, p.z*0, p.z*0.5, a, a+TAU, color(0), 10, 0);
    fill(getColor(), 40);
    ellipse(p.x, p.y, p.z*0.08, p.z*0.08);
    fill(rcol());
    ellipse(p.x, p.y, p.z*0.06, p.z*0.06);
    fill(252);
    ellipse(p.x, p.y, p.z*0.01, p.z*0.01);
  }
}

class Line {
  PVector p1, p2;
  Line(float x1, float y1, float x2, float y2) {
    p1 = new PVector(x1, y1);
    p2 = new PVector(x2, y2);
  }
  void show() {
    if (random(1) < 0.2) {
      lineDot(p1.x, p1.y, p2.x, p2.y, 8, 0.5);
    } else {
      line(p1.x, p1.y, p2.x, p2.y);
    }
  }
}

void lineDot(float x1, float y1, float x2, float y2, float sep, float amp) {
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  float dx = cos(ang);
  float dy = sin(ang);
  for (float i = 0; i < dis; i+=sep) {
    float di = (i+sep*amp);
    if (di > dis) di = dis;
    line(x1+dx*i, y1+dy*i, x1+dx*di, y1+dy*di);
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma*0.5));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
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
//int colors[] = {#000F29, #FE0706, #F85E8D, #3E56A8, #090D0E, #06A5FF, #FE0706, #F85E8D, #06A5FF};
int colors[] = {#DAAC80, #FCC9D2, #FC2E1D, #235F3F, #02272D};
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
