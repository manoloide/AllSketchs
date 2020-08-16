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

  ArrayList<PVector> points = new ArrayList<PVector>();
  float dd = -random(0.2, 0.4);//-random(0.1, 0.5);
  int cc = 4+int(random(100)*random(1));
  for (int i = 0; i < cc; i++) {
    points.add(new PVector(random(-width*dd, width*(1+dd)), random(-height*dd, height*(1+dd))));
  }

  Triangulator triangulator = new Triangulator();
  ArrayList<Triangle> tris = triangulator.triangulate(points.toArray(new PVector[points.size()]));

  noStroke();
  float det = 0.01; 
  noFill();
  stroke(0);
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);

    triangle(t.p1.x, t.p1.y, t.p2.x, t.p2.y, t.p3.x, t.p3.y);
  }

  /*
  noStroke();
   for (int i = 0; i < points.size(); i++) {
   PVector p = points.get(i); 
   fill(rcol());
   ellipse(p.x, p.y, 5, 5);
   }
   */


  /*
  ArrayList<Line> lines = new ArrayList<Line>();
   
   for (int i = 0; i < 300; i++) {
   float cx = random(width); 
   float cy = random(height);
   float ss = random(5, 300);
   float a = random(TWO_PI);
   
   lines.add(new Line(cx, cy, ss, a));
   }
   
   for (int i = 0; i < lines.size(); i++) {
   Line l = lines.get(i); 
   l.show();
   }
   */
}

class Line {
  float c1, c2; 
  float s, a, h; 
  PVector p1, p2;
  Line(float x, float y, float s, float a) {   
    this.s = s; 
    this.a = a; 
    float dx = cos(a)*s*0.5; 
    float dy = sin(a)*s*0.5; 
    c1 = random(colors.length); 
    c2 = c1+random(colors.length)*random(1);
    p1 = new PVector(x-dx, y-dy); 
    p2 = new PVector(x+dx, y+dy);
  }

  void show() {
    line(p1.x, p1.y, p2.x, p2.y, s*0.2, s*0.1, c1, c2);
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

void circle(float x, float y, float s) {
  float r = s*0.5;
  int res = 360/2; 
  float da = TWO_PI/res; 
  noStroke();
  float ang = random(TWO_PI);
  float dc = 0;//random(1); 
  //stroke(0, 80);
  int cs = int(random(1, 4));
  float mr1 = random(0.4)*random(1);
  float mr2 = random(0.4);
  for (int i = 0; i < res; i++) {
    float a1 = ang+i*da; 
    float a2 = ang+(i+1)*da;
    float r1 = map(cos(map(i, 0, res-1, 0, TWO_PI)), -1, 1, mr1, mr2)*r;
    float r2 = map(cos(map(i+1, 0, res-1, 0, TWO_PI)), -1, 1, mr1, mr2)*r;
    beginShape();
    fill(getColor(map(i, 0, res, 0, dc+colors.length*cs)));
    vertex(x+cos(a1)*(r+r1), y+sin(a1)*(r+r1));
    vertex(x+cos(a1)*(r-r1), y+sin(a1)*(r-r1));
    fill(getColor(map(i+1, 0, res, 0, dc+colors.length*cs)));
    vertex(x+cos(a2)*(r-r2), y+sin(a2)*(r-r2));
    vertex(x+cos(a2)*(r+r2), y+sin(a2)*(r+r2));
    //line(x+cos(a1)*r, y+sin(a1)*r, x+cos(a2)*r, y+sin(a2)*r);
    endShape(CLOSE);
  }
  //ellipse(x, y, s, s);
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